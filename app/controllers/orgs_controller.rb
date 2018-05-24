class OrgsController < ApplicationController

    def display
        @user = User.find(session[:user_id])
        @orgs = Org.all()

        render "display"
      end



    def event
        @event= Org.create(user:User.find(session[:user_id]),name:params[:name],description:params[:description])
        if @event.invalid?
        flash[:messages] = @event.errors.full_messages 
        redirect_to "/groups"
        else
        redirect_to "/groups"
        end
      
      end

      def delete_post
        @post = Org.find(params[:id])
        @post.destroy
        redirect_to '/groups'
      end

      def detail
        @user = User.find(session[:user_id])
        @orgs = Org.find_by(id:params[:id])
        @manies = Many.where(org_id:params[:id])
        @manie = Many.find_by(user_id:session[:user_id], org_id:params[:id])

        render "detail"
      end

      def join_group
        @user = User.find_by(id:session[:user_id])
        @orgs = Org.find_by(id:params[:id])
        @manies = Many.find_by(user_id:session[:user_id],org_id:params[:id])
      
        if @manies==nil
           @manies = Many.create(user_id:@user.id,org_id:params[:id])
          redirect_to "/groups/#{params[:id]}"
        else
           @orgs == @manies
           redirect_to "/groups/#{params[:id]}"
        end
      
      end

      def leave_group
        @manies = Many.find_by(org_id:params[:id],user_id:session[:user_id])
        @manies.destroy
        redirect_to "/groups/#{params[:id]}"
      end

end
