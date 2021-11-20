import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        const messageInput = document.getElementById('message_content');
        messagesContainer.insertAdjacentHTML("beforeend", data)
        messageInput.value = ""
        messageInput.focus()
      },
    });
  }
}

export { initChatroomCable };