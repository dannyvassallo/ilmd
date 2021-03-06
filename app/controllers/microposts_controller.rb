class MicropostsController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.eager_load(:user).all

    respond_to do |format|
      format.html
      format.csv { send_data Micropost.as_csv(@microposts) }
    end
  end

  def import
    Micropost.import(params[:file])
    redirect_to root_url, notice: "Microposts imported."
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = current_user.microposts.build
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.user = current_user

    respond_to do |format|
      if @micropost.save
        # add "create micropost" event to session
        add_event("micropost", "create")
        format.html { redirect_to @micropost, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @micropost }
        PostMailer.posted_confirmation(@micropost).deliver
      else
        add_event("micropost", "failed-to-create")
        format.html { render :new }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        add_event("micropost", "updated")
        format.html { redirect_to @micropost, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        add_event("micropost", "failed-to-update")
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    add_event("micropost", "deleted")
    respond_to do |format|
      format.html { redirect_to microposts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    def correct_user
      @user = current_user || User.new
      @micropost = @user.microposts.find_by(id: params[:id])
      redirect_to root_path, notice: "Not authorized to edit this post!" if @micropost.nil? unless admin?
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:drname, :content, :user_id, :created_at, :id).tap do |params|
        params[:drname].gsub!(",",", ")
      end
    end

end
