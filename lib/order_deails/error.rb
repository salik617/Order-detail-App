module UpcomingGadgets
    class BaseError < StandardError; end
    class BadRequest < StandardError; end
    class NotFound < StandardError; end
    class FailedRequestError < StandardError
      def initialize(msg = "Subscriber call failed")
        super
      end
    end
    class AuthorizationFailedError < BaseError
      def initialize(msg = "Passcode do not match")
        super
      end
    end
end
