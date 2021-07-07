defmodule Account.AccountWorker do
  use GenServer

  require Logger

  @logpath "/logs/account.log"

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(state) do
    File.mkdir_p!(Path.dirname(@logpath))

    schedule_log_write()
    {:ok, state}
  end

  def handle_info(:write_log, state) do
    random_number = :rand.uniform()
    {:ok, file} = File.open(@logpath, [:write, :append])

    log_line = Poison.encode!(%{
      msg: "some log with random number: #{random_number}",
      application: Application.fetch_env!(:account, :name)
    }) <> "\n"

    file
    |> IO.binwrite(log_line)

    IO.inspect(log_line)

    schedule_log_write()

    {:noreply, state}
  end

  defp schedule_log_write do
    Process.send_after(self(), :write_log, 5_000)
  end
end
