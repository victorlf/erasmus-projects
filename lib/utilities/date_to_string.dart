parseDateToString(DateTime picked) {
  //DateTime picked = DateTime.parse(date);
  String date =
      "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
  return date;
}
