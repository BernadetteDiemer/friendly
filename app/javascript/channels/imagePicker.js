const imagePicker = () => {
  const imagesEvent = document.querySelectorAll(".image-event")
  if (imagesEvent.length===0) return;
  const radioContainer = document.getElementById("event-radios")

  imagesEvent.forEach(image => {
    image.addEventListener("click", () => {
      console.log(image.dataset.eventTypeId)
      imagesEvent.forEach(image => image.classList.remove("border"))
      image.classList.add("border", "border-dark","rounded" )

      const radio = document.getElementById(`event_event_type_id_${image.dataset.eventTypeId}`)
      console.log(radio)
      radio.checked = true
    })
  })
}
export {imagePicker}
