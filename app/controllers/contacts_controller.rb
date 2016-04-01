class ContactsController < ApplicationController
 
  def new
    @contact = Contact.new
  end      
  
  def create
    @contact =Contact.new(contact_params)
    #the code below white lists the objects in the form. 
    #must whitelist for security purposes in  
   
    if @contact.save
      name = params[:contact][:name] #translates into whatever is in name sect of form
      email = params[:contact][:email]
      body = params[:contact][:comments]
     
      ContactMailer.contact_email(name, email, body).deliver
      flash[:sucess] = "Message sent."
      redirect_to new_contact_path
    else
      flash[:error] = "Error occured. Message has not been sent."
      redirect_to new_contact_path
    end
  end      
  
  private
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end  