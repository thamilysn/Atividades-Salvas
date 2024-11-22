function getColors(){
    const vetorCores = []
    
    for (let i = 1; i <= 148; i++){
        const colorName = document.querySelector(`#box${i} > span > a`).innerText.toLowerCase()
        vetorCores.push(colorName)
    }
    return vetorCores.push
}

