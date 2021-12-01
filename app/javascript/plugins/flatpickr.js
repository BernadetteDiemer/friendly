import flatpickr from "flatpickr";
// import 'flatpickr/dist/flatpickr.css';

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    enableTime: true,
    dateFormat: "Y-m-d H:i",
    disableMobile: true
  });
}

export { initFlatpickr };
