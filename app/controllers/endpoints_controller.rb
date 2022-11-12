class EndpointsController < ApplicationController

  def index
    # Create an arrray of all endpoints
    @data = []
    Endpoint.all.each do |e|
      @data.push(e.to_hash)
    end
    render json: {"data" => @data}
  end

  def create
    filtered_params = endpoint_params  
    attr = endpoint_attributes
    
    endpoint = Endpoint.new( 
      endpoint_type: filtered_params[:type],   
      path: attr[:path], 
      verb: attr[:verb], 
      res_code: attr[:response][:code],
      res_headers: attr[:response][:headers],
      res_body: attr[:response][:body]
    )

    # Attempt to save endpoint. Show errors if validation fails
    if endpoint.save
      render json: {data: endpoint.to_hash}, status: :created
    else
      render_errors endpoint
    end
  end

  def update
    # Does endpoint exist?
    begin
      endpoint = Endpoint.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render_single_error :not_found, "Requested Endpoint with ID `#{params[:id]}` does not exist"
    end

    data = endpoint_data 
    attr = endpoint_attributes

    # Check if the update can be done successfully
    # endpoint.id = data[:id]
    update_success = endpoint.update( 
      id: data[:id],
      endpoint_type: data[:type], 
      verb: attr[:verb], 
      path: attr[:path], 
      res_code: attr[:response][:code],
      res_headers: attr[:response][:headers],
      res_body: attr[:response][:body]
    )
    if !update_success
      return render_errors endpoint  
    end

    render json: {data: endpoint.to_hash}, status: :ok

  end

  def destroy
    # Check if endpoint exists
    begin
      endpoint = Endpoint.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return render_single_error :not_found, "Requested Endpoint with ID `#{params[:id]}` does not exist"
    end

    # Delete endpoint
    endpoint.delete
    render json: {}, status: :no_content
  end

  # Handle dynamically defined endpoints
  def custom 
    # Check if endpoint exists
    endpoint = Endpoint.where(verb: request.method, path: request.path)[0]
    if endpoint.nil?
      return render_single_error :not_found, "Requested page '#{request.path}' does not exist"
    end

    # Return endpoint
    render json: endpoint.res_body, status: endpoint.res_code
  end

  private
  def endpoint_params
    params.require(:data).permit(:type, {attributes: [:verb, :path, {response: [:code, {headers: {}}, :body]}]})
  end

  def endpoint_data
    params.require(:data).permit(:type, :id)
  end

  def endpoint_attributes
    params.require(:data).require(:attributes).permit(:verb, :path, {response: [:code, {headers: {}}, :body]})
    
  end

  def render_errors endp
    all = []
    endp.errors.objects.each do |e|
      all.push(error_to_hash(:bad_request, e.full_message))
    end
    render json: {errors: all}, status: :bad_request
  end

  def render_single_error(code, detail) 
    render json: {errors: [error_to_hash(code, detail)]}, status: code
  end

  def error_to_hash(code, detail) 
    {
      code: code.to_s,
      detail: detail
    }
  end
end
