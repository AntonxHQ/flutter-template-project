///
/// [loading] : When data is loading from remote db
/// and to show progress bar to the user.
///
/// [idle] : When data is ready to renders on the UI.
///
/// [busy] : When there is some process(loading data, performing
/// any time taking task) going on and to block new process requests.
///
enum ViewState {
  loading,
  idle,
  busy,
}
