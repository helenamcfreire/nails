ActiveAdmin.register User do

  form do |f|
    f.inputs "Details" do
      f.input             :email
      f.input             :password
      f.input             :password_confirmation
      f.input             :firstName
      f.input             :lastName
      f.input             :birth
      f.input             :phone
      f.input             :gender,     :as => :select,      :collection => { 'Masculino' => 'M', 'Feminino' => 'F' }
      f.input             :isBeauty,   :as => :radio,       :collection => { 'Yes' => true, 'No' => false }

    end
    f.buttons
  end

end