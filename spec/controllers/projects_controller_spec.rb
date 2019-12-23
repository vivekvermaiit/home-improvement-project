require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  describe "for admin user" do
    login_admin

    before(:all) do
      @member = create(:user)
      @member2 = create(:user)
      @admin = User.admin_user

      @project1 = create(:project, name: "publicmember", project_type: Project::PROJECT_TYPES[:public], user: @member )
      @project2 = create(:project, name: "privatemember", project_type: Project::PROJECT_TYPES[:private], user: @member)
      @project3 = create(:project, name: "privatemember2", project_type: Project::PROJECT_TYPES[:private], user: @member2)
      @project4 = create(:project, name: "privateadmin", project_type: Project::PROJECT_TYPES[:private], user: @admin)
    end

    after(:all) do
      @member.destroy
      @member2.destroy
      @project4.destroy
    end

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should GET all projects" do
      get :index
      assert_equal assigns(:projects).size, 4
    end

    it "gets correct id for #show" do
      get :show, params: { id: @project1.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project1)
    end

    it "gets correct id for #edit" do
      get :edit, params: { id: @project1.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project1)
    end

    it "updates for #update and redirects" do
      put :update, params: { id: @project1.id, project: { description: "r2d2" } }
      expect(response.status).to eq(302)
      @project1.reload
      assert_equal @project1.description, "r2d2"
    end

    it "destroys any project" do
      expect{
        delete :destroy, params: {id: @project3.id}
      }.to change(Project,:count).by(-1)
    end
  end




  describe "for member user" do
    login_user

    before(:all) do
      @member = create(:user)
      @member2 = create(:user)
      @admin = User.admin_user

      @project1 = create(:project, name: "publicmember", project_type: Project::PROJECT_TYPES[:public], user: @member )
      @project2 = create(:project, name: "privatemember", project_type: Project::PROJECT_TYPES[:private], user: @member)
      @project3 = create(:project, name: "privatemember2", project_type: Project::PROJECT_TYPES[:private], user: @member2)
      @project4 = create(:project, name: "privateadmin", project_type: Project::PROJECT_TYPES[:private], user: @admin)
    end

    after(:all) do
      @member.destroy
      @member2.destroy
      @project4.destroy
    end

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should GET only current user projects and public projects" do
      @project2.user=subject.current_user
      @project2.save!
      get :index
      @projects =  assigns(:projects)
      assert_equal @projects.size, 2
      assert_equal @projects[0].id, @project1.id
      assert_equal @projects[1].id, @project2.id
    end

    it "gets correct id for #show for public" do
      get :show, params: { id: @project1.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project1)
    end

    it "gets correct id for #show for self" do
      @project2.user=subject.current_user
      @project2.save!
      get :show, params: { id: @project2.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project2)
    end

    it "doesnt gets id for #show for other users and redirects" do
      @project2.user=subject.current_user
      @project2.save!
      get :show, params: { id: @project3.id }
      expect(response.status).to eq(302)
    end

    it "gets correct id for #edit" do
      get :edit, params: { id: @project1.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project1)
    end

    it "gets correct id for #edit for self" do
      @project2.user=subject.current_user
      @project2.save!
      get :edit, params: { id: @project2.id }
      expect(response.status).to eq(200)
      assigns(:project).should eq(@project2)
    end

    it "doesn't gets correct id for #edit for other users and redirects" do
      @project2.user=subject.current_user
      @project2.save!
      get :edit, params: { id: @project3.id }
      expect(response.status).to eq(302)
    end

    it "updates description for public and redirects" do
      put :update, params: { id: @project1.id, project: { description: "r2d2" } }
      expect(response.status).to eq(302)
      @project1.reload
      assert_equal @project1.description, "r2d2"
    end

    it "doesn't update name for public and redirects" do
      put :update, params: { id: @project1.id, project: { name: "r2d2" } }
      expect(response.status).to eq(302)
      @project1.reload
      assert_equal @project1.name, "publicmember"
    end

    it "updates name for self and redirects" do
      @project2.user=subject.current_user
      @project2.save!
      put :update, params: { id: @project2.id, project: { name: "r2d2" } }
      expect(response.status).to eq(302)
      @project2.reload
      assert_equal @project2.name, "r2d2"
    end

    it "cannot destroy other project" do
      expect{
        delete :destroy, params: {id: @project3.id}
      }.to change(Project,:count).by(0)
    end
  end



end
