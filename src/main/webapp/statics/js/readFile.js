
//jsReadFile:<input type="file" onchange="jsReadFiles(this.files)"/>
//选择并读取文件
function jsReadFiles(files) {
    console.log(files)
    if (files.length) {
        var file = files[0];
        var reader = new FileReader();//new一个FileReader实例
        if (/text+/.test(file.type)) {//判断文件类型，是不是text类型
            reader.onload = function() {
                $('body').append('<pre>' + this.result + '</pre>');
            }
            reader.readAsText(file);
        } else if(/image+/.test(file.type)) {//判断文件是不是imgage类型
            reader.onload = function() {
                $('body').append('<img src="' + this.result + '"/>');
            }
            reader.readAsDataURL(file);
        }
    }
}