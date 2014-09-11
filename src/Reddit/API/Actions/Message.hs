module Reddit.API.Actions.Message where

import Reddit.API.Routes.Run
import Reddit.API.Types.Empty
import Reddit.API.Types.Listing
import Reddit.API.Types.Message
import Reddit.API.Types.Reddit
import Reddit.API.Types.Thing
import Reddit.API.Types.User
import qualified Reddit.API.Routes.Message as Route

import Control.Monad.IO.Class
import Data.Text (Text)
import Network.API.Builder.Query

getInbox :: MonadIO m => RedditT m (Listing MessageKind Message)
getInbox = runRoute Route.inbox

getUnread :: MonadIO m => RedditT m (Listing MessageKind Message)
getUnread = runRoute Route.unread

readMessage :: (ToQuery a, Thing a, MonadIO m) => a -> RedditT m ()
readMessage = nothing . runRoute . Route.readMessage

sendMessage :: MonadIO m => Username -> Text -> Text -> RedditT m ()
sendMessage u s b = nothing $ runRoute $ Route.sendMessage u s b Nothing Nothing

sendMessageWithCaptcha :: MonadIO m => Username -> Text -> Text -> Text -> Text -> RedditT m ()
sendMessageWithCaptcha u s b i c = nothing $ runRoute $ Route.sendMessage u s b (Just i) (Just c)
