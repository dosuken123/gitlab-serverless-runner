class RunnersController < ApplicationController
  before_action :set_runner, only: [:show, :edit, :update, :delete]

  # GET /runners
  def index
    @runners = Runner.all
  end

  # GET /runners/1
  def show
  end

  # GET /runners/new
  def new
    @runner = Runner.new
  end

  # GET /runners/1/edit
  def edit
  end

  # POST /runners
  def create
    @runner = Runner.new(runner_params)

    if @runner.save
      if request.xhr?
        render json: {success: true, location: url_for(@runner)}
      else
        redirect_to runner_path(@runner)
      end
    else
      render :new
    end
  end

  # PUT /runners/1
  def update
    if @runner.update(runner_params)
      if request.xhr?
        render json: {success: true, location: url_for(@runner)}
      else
        redirect_to runner_path(@runner)
      end
    else
      render :edit
    end
  end

  # DELETE /runners/1
  def delete
    @runner.destroy
    if request.xhr?
      render json: {success: true}
    else
      redirect_to runners_path
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_runner
    @runner = Runner.find(params[:id])
  end

  def runner_params
    params.require(:runner).permit(:url, :token, :description, :tags, :runtime)
  end
end
