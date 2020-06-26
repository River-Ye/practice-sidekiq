module Api

  class CreateWorker

    include Sidekiq::Worker
    sidekiq_options retry: 48, dead: true, queue: "api_create_worker"

    sidekiq_retry_in { |count| count + 1_800 }

    def perform(user_id)
      logger.info "====== start ====== user_id: #{user_id}"
      puts "hello world"
      logger.info "====== done ======"
    rescue StandardError => e
      logger.error "[Api::CreateWorker] ERROR:\n #{e.inspect}\n #{e.backtrace}"
    end

    private

    def logger
      FileLog.logger("worker/api/create_worker.log")
    end

  end

end
