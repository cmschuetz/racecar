module Racecar
  ##
  # Common API for instrumentation to standardize
  # namespace and default payload
  #
  class Instrumenter
    NAMESPACE = "racecar"
    attr_reader :backend

    def initialize(default_payload = {})
      @default_payload = default_payload

      @backend = if defined?(ActiveSupport::Notifications)
        ActiveSupport::Notifications
      else
        NullInstrumenter
      end
    end

    def instrument(event_name, payload = {}, &block)
      @backend.instrument("#{event_name}.#{NAMESPACE}", @default_payload.merge(payload), &block)
    end
  end
end
