class TicketsController < ApplicationController
before_action :require_signin!, except: [:show, :index]
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
def new
@ticket = @project.tickets.build
  end

  def create
  @ticket = @project.tickets.build(ticket_params)
  @ticket.user = current_user
  if @ticket.save
  flash[:notice] = "Ticket has been created."
  redirect_to [@project, @ticket]
  else
  flash[:alert] = "Ticket has not been created."
  render "new"
  end
  end

  def set_ticket
@ticket = @project.tickets.find(params[:id])
end

def edit
end

def update
if @ticket.update(ticket_params)
flash[:notice] = "Ticket has been updated."
redirect_to [@project, @ticket]
else
flash[:alert] = "Ticket has not been updated."
render action: "edit"
end
end

def destroy
@ticket.destroy
flash[:notice] = "Ticket has been deleted."
redirect_to @project
end

  private
  def ticket_params
  params.require(:ticket).permit(:title, :description)
  end

  def set_project
  @project = Project.find(params[:project_id])
  end

end
