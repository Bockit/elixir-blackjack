defmodule Blackjack.Otp.Supervisor do
  use Supervisor

  def init(_) do
    processes = [worker(Blackjack.Otp.Table, [])]
    supervise(processes, strategy: :one_for_one)
  end
end