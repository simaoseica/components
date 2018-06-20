(() => {
    'use strict'

    window.onload = () => {
        const collapsers = document.querySelectorAll("[data-toggle='collapse']")
        collapsers.forEach(setupCollapserEventListener)
    }

    const setupCollapserEventListener = (collapser) => {
        const onCollapserClick = () => {
            const components = collapser.parentNode.querySelectorAll(".component[data-imgsrc]")
            components.forEach(loadImage)
            // Remove the event listener so this is only called once (minor optimization)
            collapser.removeEventListener("click", onCollapserClick)
        }

        collapser.addEventListener("click", onCollapserClick)
    }

    const loadImage = (node) => {
        const imgSrc = node.getAttribute("data-imgsrc")
        node.setAttribute("src", imgSrc)
        node.removeAttribute("data-imgsrc")
    }
})()