$(document).ready(function(){
  $('body').on('keyup', '#pw_list', null, function(e){
  if (e.keyCode == 32 || e.keyCode == 13){ // проверка на "пробел"" и "энтер"
    $('#pw_list').removeClass('warning');
    input = $('#pw_list');
    word = input.val().trim();
    if (word.length > 0){
      words = $('.list_of_words').children();
      for(i = 0; i < words.length; i++){
        if (words[i].children[0].innerText == word){
          input.addClass('warning');
          input.val(word);
          return;
        }
      }
      input.val('');
      word_html = ('<span href="#/" class="word">' + 
         '<word>' + word + '</word>' +
         '<span class="delete-word-icon">×</span></span>');
      $('.list_of_words').append(word_html);
      }
    }
  });

  $('body').on('click', '.delete-word-icon', null, function(e){
    $(this).parent().remove();
  });

  $('body').on('click', '.js__generate', null, function(e){
    $('.error').html("");
    list = [];
    children = $('.list_of_words').children();
    if (children.length < 3)
      $('.error').html('Слишком мало слов для генерации пароля. Необходимо минимум 3 слова.');
    else {
      for(i = 0; i < children.length; i++)
        list.push(children[i].children[0].innerText);
      word_list = list.join(',');
      $.ajax({
        url: "/generate",
        data: { words: word_list },
        type: "get",
        dataType: "json",
        success: function(data){
          $('.list_passwords').html("<h1>Сгенерируемые пароли</h1>" +
            "<ul>");
          for(i = 0; i < data.length;i++)
            $('.list_passwords').append("<li>" + data[i] + "</li>");
          $('.list_passwords').append("</ul>");
        },
        error: function(data){
          alert(data.responseText);
        }
      });
    }
  });
})
