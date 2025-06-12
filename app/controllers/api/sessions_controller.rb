module Api
    class SessionsController < ::ApplicationController
      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          expiration = 24.hours.from_now
          token = JwtService.encode({ user_id: user.id, type: "access" }, expiration)

          render json: {
            token: token,
            user: user.as_json(only: [ :id, :email, :role ])
          }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
end
