defmodule PasswordLockTest do
  use ExUnit.Case
  doctest PasswordLock

  # What ever the setup function returns you can access those return values in your unit test cases.
  setup do
    {:ok,server_pid} = PasswordLock.start_link("foo")
    {:ok,server: server_pid}
  end

  test "unlock success test", %{server: pid} do
    assert :ok == PasswordLock.unlock(pid,"foo")
  end

  test "unlock failure  test", %{server: pid} do
    assert {:error,"wrongpassword"} == PasswordLock.unlock(pid,"bar")
  end

  test "reset failure error" ,%{server: pid} do
    assert {:error,"wrongpassword"} == PasswordLock.reset(pid,{"hello","bar"})
  end

  test "reset success test" ,%{server: pid} do
    assert :ok == PasswordLock.reset(pid,{"foo","bar"})
  end

end
