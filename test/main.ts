// apply gaussian blur to 3x3 matrix with n
// return the last element of the matrix

function getNear (matrix: Uint8Array[], i: number, j: number): number[] {
  const mlen = matrix.length;
  const near = [];
  for (let x = i - 1; x <= i + 1; x++) {
    for (let y = j - 1; y <= j + 1; y++) {
      if (x >= 0 && x < mlen && y >= 0 && y < mlen) {
        // @ts-ignore
        near.push(matrix[x][y]);
      }
    }
  }
  return near;
};

function blurMatrix (matrix: Uint8Array[]): Uint8Array[] {
  const blurredMatrix = matrix.map((row, i) =>
    row.map((_, j) => {
      const near = getNear(matrix, i, j);
      const sum = near.reduce((acc, x) => acc + x, 0);
      return sum / near.length;
    })
  );
  return blurredMatrix;
}

// 0s,0n0,0s
const createMatrix = (n: number): Uint8Array[] => {
  const matrix = new Array(3).fill(0).map(() => new Uint8Array(3));
  const mlen = matrix.length;
  for (let i = 0; i < mlen; i++) {
    for (let j = 0; j < mlen; j++) {
      matrix[i][j] = i + j;
    }
  }
  matrix[1][1] = n;
  return matrix;
};


let args: any = process.argv.slice(2);
const n = parseInt(args[0]);
if (isNaN(n)) {
  throw new Error("Invalid number: " + args[0]);
}

const matrix: Uint8Array[] = createMatrix(n);
const bm: Uint8Array[] = blurMatrix(matrix);
const last: number = bm[bm.length - 1][bm[0].length - 1];
console.log(last);
