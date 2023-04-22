require 'rails_helper'

RSpec.describe ItemTransactionForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @item_transaction_form = FactoryBot.build(:item_transaction_form, user_id: user.id, item_id: item.id)
    sleep(1) # サーバーの負荷を減らすため、1秒待機
  end

  describe '商品購入機能' do
    context '商品購入が成功するとき' do
      it '必須項目が全て存在すれば購入できる' do
        expect(@item_transaction_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @item_transaction_form.building = ''
        expect(@item_transaction_form).to be_valid
      end
    end

    context '商品購入が失敗するとき' do

      it '郵便番号が空だと購入できない' do
        @item_transaction_form.postal_code = ''
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列でないと購入できない' do
        @item_transaction_form.postal_code = '1234567'
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include('Postal code は「3桁ハイフン4桁」の半角文字列で入力してください')
      end

      it '都道府県が選択されていないと購入できない' do
        @item_transaction_form.prefecture_id = 0
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '市区町村が空だと購入できない' do
        @item_transaction_form.city = ''
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @item_transaction_form.address = ''
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @item_transaction_form.phone_number = ''
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁以上11桁以内の半角数値でないと購入できない' do
        @item_transaction_form.phone_number = '090-1234-5678'
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数値で入力してください')
      end

      it '電話番号が9桁以下だと購入できない' do
        @item_transaction_form.phone_number = '090123456'
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数値で入力してください')
      end

      it '電話番号が12桁以上だと購入できない' do
        @item_transaction_form.phone_number = '090123456789'
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include('Phone number は10桁以上11桁以内の半角数値で入力してください')
      end

      it 'tokenが空だと購入できない' do
        @item_transaction_form.token = ''
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Token can't be blank")
      end 
      
      it 'user_idが空だと購入できない' do
        @item_transaction_form.user_id = nil
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("User can't be blank")
      end
      
      it 'item_idが空だと購入できない' do
        @item_transaction_form.item_id = nil
        @item_transaction_form.valid?
        expect(@item_transaction_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

