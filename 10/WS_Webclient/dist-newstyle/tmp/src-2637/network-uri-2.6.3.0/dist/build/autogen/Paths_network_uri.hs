{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_network_uri (
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
version = Version [2,6,3,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\bin"
libdir     = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\lib"
dynlibdir  = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\lib"
datadir    = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\share"
libexecdir = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\libexec"
sysconfdir = "C:\\Users\\kevin\\AppData\\Roaming\\cabal\\store\\ghc-8.8.4\\network-uri-2.6.3.0-1ab6c19a3168305802272bc71e19269637477463\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "network_uri_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "network_uri_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "network_uri_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "network_uri_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "network_uri_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "network_uri_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
