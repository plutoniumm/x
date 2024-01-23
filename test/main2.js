// apply gaussian blur to 3x3 matrix with n
// return the last element of the matrix

function getNeighbors ( matrix, i, j ) {
  const neighbors = [];
  for ( let x = i - 1;x <= i + 1;x++ ) {
    for ( let y = j - 1;y <= j + 1;y++ ) {
      if ( x >= 0 && x < matrix.length && y >= 0 && y < matrix[ 0 ].length ) {
        neighbors.push( matrix[ x ][ y ] );
      }
    }
  }
  return neighbors;
};

function blurMatrix ( matrix ) {
  const blurredMatrix = matrix.map( ( row, i ) => {
    return row.map( ( col, j ) => {
      const neighbors = getNeighbors( matrix, i, j );
      const sum = neighbors.reduce( ( acc, val ) => acc + val, 0 );
      return sum / neighbors.length;
    } );
  } );
  return blurredMatrix;
}

// 0s,0n0,0s
const createMatrix = ( n ) => {
  const matrix = new Array( 3 ).fill( 0 ).map( () => new Uint8Array( 3 ) );
  matrix[ 1 ][ 1 ] = n;
  return matrix;
};


let args = process.argv.slice( 2 );
console.log( args );
const n = parseInt( args[ 0 ] );
if ( isNaN( n ) ) {
  throw new Error( "Invalid number: " + args[ 0 ] );
}

const matrix = createMatrix( n );
const bm = blurMatrix( matrix );
const last = bm[ bm.length - 1 ][ bm[ 0 ].length - 1 ];
console.log( last );