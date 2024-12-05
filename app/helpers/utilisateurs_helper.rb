module UtilisateursHelper
  def detect_device
    user_agent = request.user_agent
    @detector = DeviceDetector.new(user_agent)
  end
end
