module Model.User where

newtype User
  = User
  { name :: String
  , pwd :: String
  }
