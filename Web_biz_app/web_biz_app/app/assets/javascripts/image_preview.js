$(document).on('ready page:load', function(){
  $('.js-preview-images').each(function() {
    var preview = $(this),
        image   = preview.find('input[type=file]');

    image.change(function(){
      if (!this.files.length) {
        return;
      }
      var file = this.files[0]
      fileReader = new FileReader();
      fileReader.readAsDataURL(file);
      fileReader.onload = function(){
        preview.css({
          'background-image': "url(' + fileReader.result + ')",
          'background-size' : 'cover'
        });
      };
    });
  });
});