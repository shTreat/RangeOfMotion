class CustomScreenSize {
  double height;
  double width;

  CustomScreenSize({
    this.height=0,
    this.width=0,
  });

  double getDynamicScreenPaddingWidth() {
    if (width > 1400) {
      return width * .285;
    } else if (width < 1400 && width >= 1300) {
      return width * .249;
    } else if (width < 1300 && width >= 1200) {
      return width * .213;
    } else if (width < 1200 && width >= 1100) {
      return width * .178;
    } else if (width < 1100 && width >= 1000) {
      return width * .142;
    } else if (width < 1000 && width >= 900) {
      return width * .106;
    } else if (width < 900 && width >= 800) {
      return width * .071;
    } else if (width < 800 && width >= 700) {
      return width * .045;
    } else {
      return width * .030;
    }
  }
}
