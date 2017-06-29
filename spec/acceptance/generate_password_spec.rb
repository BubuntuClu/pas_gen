require_relative 'acceptance_helper'

feature 'Generate password', %q{
  In order to Generate password
  I want to be able to enter words that will contain the password
} do

  scenario 'try to generate password without words', js: true do
    visit root_path
    generate
    expect(page).to have_content('Слишком мало слов для генерации пароля. Необходимо минимум 3 слова.')
  end

  scenario 'try to generate password with 1 word', js: true do
    visit root_path
    enter_word('first_word ')

    within('.list_of_words') do
      expect(page).to have_content('first_word')
    end

    generate

    expect(page).to have_content('Слишком мало слов для генерации пароля. Необходимо минимум 3 слова.')
  end

  scenario 'try to generate password with 3 words', js: true do
    visit root_path
    enter_word('first_word ')
    enter_word('second ')
    enter_word('end ')

    within('.list_of_words') do
      expect(page).to have_content('first_word')
      expect(page).to have_content('second')
      expect(page).to have_content('end')
    end

    generate

    expect(page).to have_content('first_wordsecondend')
    expect(page).to have_content('first_wordendsecond')
    expect(page).to have_content('secondfirst_wordend')
    expect(page).to have_content('secondendfirst_word')
    expect(page).to have_content('endfirst_wordsecond')
    expect(page).to have_content('endsecondfirst_word')
  end

  scenario 'try to delete wrong word', js: true do
    visit root_path
    enter_word('first_word ')
    enter_word('second ')
    enter_word('end ')

    within('.list_of_words') do
      expect(page).to have_content('first_word')
      expect(page).to have_content('second')
      expect(page).to have_content('end')
    end

    first('.delete-word-icon').click

    within('.list_of_words') do
      expect(page).to_not have_content('first_word')
      expect(page).to have_content('second')
      expect(page).to have_content('end')
    end
  end

  scenario 'try to generate and then regenerate passwords', js: true do
    visit root_path
    enter_word('first_word ')
    enter_word('second ')
    enter_word('end ')

    within('.list_of_words') do
      expect(page).to have_content('first_word')
      expect(page).to have_content('second')
      expect(page).to have_content('end')
    end

    generate

    expect(page).to have_content('first_wordsecondend')
    expect(page).to have_content('first_wordendsecond')
    expect(page).to have_content('secondfirst_wordend')
    expect(page).to have_content('secondendfirst_word')
    expect(page).to have_content('endfirst_wordsecond')
    expect(page).to have_content('endsecondfirst_word')

    first('.delete-word-icon').click
    first('.delete-word-icon').click
    first('.delete-word-icon').click

    enter_word('new ')
    enter_word('123 ')
    enter_word('#gf! ')

    generate

    expect(page).to_not have_content('first_wordsecondend')
    expect(page).to_not have_content('first_wordendsecond')
    expect(page).to_not have_content('secondfirst_wordend')
    expect(page).to_not have_content('secondendfirst_word')
    expect(page).to_not have_content('endfirst_wordsecond')
    expect(page).to_not have_content('endsecondfirst_word')

    expect(page).to have_content('new123#gf!')
    expect(page).to have_content('new#gf!123')
    expect(page).to have_content('123new#gf!')
    expect(page).to have_content('123#gf!new')
    expect(page).to have_content('#gf!new123')
    expect(page).to have_content('#gf!123new')
  end

  private

  def enter_word(word)
    fill_in 'pw_list', with: word
  end

  def generate
    find('.js__generate').click
  end
end
