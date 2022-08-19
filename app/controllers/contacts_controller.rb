class ContactsController < ApplicationController
  before_action :set_contact, only: %i[show update destroy]

  def index
    @contacts = Contact.all

    render json: @contacts.map { |contact|
      contact.as_json.merge(kind: contact.kind.description)
    },
           methods: :birthdate_formatted_ptbr
  end

  def show
    render json: @contact.to_ptbr
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact.as_json.merge(kind: @contact.kind.description),
             status: :created,
             location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email, :birthdate, :kind_id)
  end
end
