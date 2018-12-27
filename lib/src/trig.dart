import 'dart:math';

/*
//  Custom trig class that converts conventional trig notation into
//  "Progress" notation -- in which progres represents percent of a quarter
// circle with the first quarter circle 0-100% and the last 300-400%
//  Thus a full rotation is 400%, I perfer this notation since it makes it much easier to visualize,
//  quicker to know what quadrant you are in, and better represents angle as a percent of the circle's length( which is what it is)
//
//  The cos sin and tan are replaced by Z,K, and X respectively because they nicely represent what the function signifies
//  Z/cos finds the ratio of the line horizontal to the angle to the overall radius, which is represented by the two horizontal lines
// K/sin finds the ratio of the line vertical to the angle  to the overall radius, which is represented by the 'two' vertical lines of K
//
// Radians are super difficult to visualize so everything in my code is in progress indead and converted to radians
// just like degrees are(but divide by 200 instead of 180 bc 400 % instead of 360)
*/
double K(double progress) {
  return sin(progress * (pi / 200));
}

double Z(double progress) {
  return cos(progress * (pi / 200));
}

double X(double progress) {
  return tan(progress * (pi / 200));
}

double rad(double progress) {
  return progress * (pi / 200);
}

double toProgress(double rad) {
  return rad * (200.0 / pi);
}

double progressFromZ(double zlength, double radius) {
  return toProgress(acos(zlength / radius));
}

double progressFromK(double klength, double radius) {
  return toProgress(asin(klength / radius));
}
