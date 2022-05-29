let obj = {
    a1: {
        b1: {
            c1: 'd'
        },
    },
    x1: {
        y1: 'zl',
    }
};


function getObjectKeys(object, key) {   
    const keys = key.split('/');
    let obj = object;
    for (let ikey of keys) {
        for (let [objKey, value] of Object.entries(obj)) {
            if(!keys.includes(objKey)) {
                continue;
            }
            obj = value;
        }
    }
    return obj;
}

module.exports = getObjectKeys

console.log(getObjectKeys(obj, 'a1/b1/c1'));

console.log(getObjectKeys(obj, 'x1/y1'));
