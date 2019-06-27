const path = require('path')
const fs = require('fs')

const dirPath = path.join(__dirname, '../samples')

const readdir = (path) => {
  return new Promise((res, rej) => {
    fs.readdir(path, (err, data) => {
      if ( err ) {
        rej(err)
      }
      res(data)
    })
  })
}


function mapSamples() {
  const paths = []
  return new Promise((res) => {
    readdir(dirPath).then((sampleDirs) => {
      let count = sampleDirs.length
      sampleDirs.forEach((sampleDir) => {
        readdir(path.join(dirPath, sampleDir)).then((files) => {
          const samples = files.filter((name) => name.toLowerCase().endsWith('.wav') )
          console.log(samples)
          paths.push([`${sampleDir}:count`, samples.length]) 
          samples.forEach((sample, i) => {
            paths.push([`${sampleDir}:${i}`, path.join(dirPath, sampleDir, sample)] )
          })
          count--;
          if ( count == 0 ) {
            res(paths)
          }
        }).catch((err) => {
          count--
          if ( count == 0 ) {
            res(paths)
          }
        })
      })
    }).catch((err) => rej(err))
  })
}

mapSamples().then((paths) => {
  const chuck = `
public class SampleMap {
  string map[0];

  ${paths.map(([key, value]) => `"${value}" => map["${key}"];` ).join('\n')}
}
  `
  fs.writeFile(path.join(__dirname, "../samples", "index.ck"), chuck, (err) => {
    if (err) throw err;
    console.log('The file has been saved!');
  });
})
