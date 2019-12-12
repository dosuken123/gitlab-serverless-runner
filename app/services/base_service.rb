class BaseService
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def success(args = {})
    { status: :success }.merge(args)
  end

  def error(args = {})
    { status: :error }.merge(args)
  end
end
