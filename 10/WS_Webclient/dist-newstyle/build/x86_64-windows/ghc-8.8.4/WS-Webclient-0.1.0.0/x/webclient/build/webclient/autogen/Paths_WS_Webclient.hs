{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_WS_Webclient (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\bin"
libdir     = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.8.4\\WS-Webclient-0.1.0.0-inplace-webclient"
dynlibdir  = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.8.4"
datadir    = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.8.4\\WS-Webclient-0.1.0.0"
libexecdir = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\WS-Webclient-0.1.0.0-inplace-webclient\\x86_64-windows-ghc-8.8.4\\WS-Webclient-0.1.0.0"
sysconfdir = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "WS_Webclient_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "WS_Webclient_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "WS_Webclient_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "WS_Webclient_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "WS_Webclient_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "WS_Webclient_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
