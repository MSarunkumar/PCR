/*
var input = document.querySelector('input[type=file]');

input.onchange = function () {
  var file = input.files[0];
  console.log(file);
  drawOnCanvas(file);   
  displayAsImage(file); 
};

function drawOnCanvas(file) {
  var reader = new FileReader();

  reader.onload = function (e) {
    var dataURL = e.target.result,
        c = document.querySelector('canvas'), 
        ctx = c.getContext('2d'),
        img = new Image();

    img.onload = function() {
      c.width = img.width;
      c.height = img.height;
      ctx.drawImage(img, 0, 0);
    };

    img.src = dataURL;
  };

  reader.readAsDataURL(file);
}

function displayAsImage(file) {
  var imgURL = URL.createObjectURL(file),
      img = document.createElement('img');

  img.onload = function() {
    URL.revokeObjectURL(imgURL);
  };
  console.log(imgURL);
  img.src = imgURL;
  
  document.body.appendChild(img);
 
}

$("#upfile1").click(function () {
    $("#file1").trigger('click');
});
*/