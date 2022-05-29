const nestedArray = require('./nestedArray')

test('clone array', () => {
    let obj = {
        a1: {
            b1: {
                c1: 'd'
            },
        },
        x1: {
            y1: 'zl',
        }
    }

    expect(nestedArray(obj,'a1/b1/c1')).toEqual('d') 
})