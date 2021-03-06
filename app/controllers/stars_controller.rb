class StarsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]

  def index
    @themes = Theme.find(1)
  end

  def show
    @themes = Theme.find(1)
  end

  def new
    @themes = Theme.find(params[:id])
    @posts = @themes.posts
    @star = Star.new  #新規ファボ作成
  end

  def create
    @star = Star.new(star_params)
    if @star.save
      redirect_to :back, notice: "お気に入り登録完了"
    else
      render 'home#index'
    end
  end

  def destroy
    @star.destroy
  end

    private
    # Rails4からStrongParamaterと呼ばれる機能が追加されました。
    # セキュリティのため、permitメソッドで許可したパラメータ名しか取得できません。
    def star_params
      params.require(:star).permit(:user_id, :post_id, :current_user_id)
    end
end
