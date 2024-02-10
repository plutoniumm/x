package test;
// we'll calculate Gauss constant via
// 1/M(1, sqrt(2))
// used to calculate the lemniscate constant
public class main {
  public static void main(String[] args) {
    if (args.length != 1) {
      System.out.println("Usage: java main <number>");
      return;
    }

    float n = Float.parseFloat(args[0]);
    n = (int) n;

    double a = 1;
    double g = Math.sqrt(2);

    for (int i = 0; i < n + 1; i++) {
      double nextA = (a + g) / 2; // calculate next arithmetic mean
      double nextG = Math.sqrt(a * g); // calculate next geometric mean

      a = nextA;
      g = nextG;
    }

    double gauss = 1 / a;
    gauss = Math.round(gauss * 10000.0) / 10000.0;

    System.out.println(gauss);
  }
}
