$('#micropost_picture').bind("change", function() {
  var size_in_megabytes = this.files[0]
    .size/Settings.size_in_megabytes/Settings.size_in_megabytes;
  if (size_in_megabytes > 5) {
    alert(I18n.t("img_over_size_error", {size: Settings.picture_size}));
  }
});
