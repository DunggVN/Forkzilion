#

from userbot.include.aux_funcs import event_log, fetch_user
from userbot.include.language_processor import (UserText as msgRep,
                                                ModuleDescriptions as descRep,
                                                ModuleUsages as usageRep)
from userbot.sysutils.configuration import getConfig
from userbot.sysutils.event_handler import EventHandler
from userbot.sysutils.registration import (register_cmd_usage,
                                           register_module_desc,
                                           register_module_info)
from userbot.version import VERSION
from telethon.tl.types import User, Chat, Channel, PeerChannel, PeerChat
from telethon.tl.functions.contacts import GetBlockedRequest
from telethon.tl.functions.photos import GetUserPhotosRequest
from logging import getLogger

MAXINT = 2147483647  # I sure do love hammering down shit
log = getLogger(__name__)
ehandler = EventHandler(log)


@ehandler.on(command="userid", hasArgs=True, outgoing=True)
async def userid(event):
    if event.reply_to_msg_id:
        msg = await event.get_reply_message()
        sender = msg.sender
        org_author = msg.forward.sender if msg.forward else None
        if not sender and not org_author:
            await event.edit(msgRep.UNABLE_GET_IDS)
            return

        if sender:
            sender_link = f"[{sender.first_name}](tg://user?id={sender.id})"

        if org_author:
            org_author_link = (f"[{org_author.first_name}]"
                               f"(tg://user?id={org_author.id})")

        if sender and org_author:
            if not sender == org_author:
                text = (f"**{msgRep.ORIGINAL_AUTHOR}**:\n" +
                        msgRep.DUAL_HAS_ID_OF.format(org_author_link,
                                                     org_author.id) + "\n\n")
                text += (f"**{msgRep.FORWARDER}**:\n" +
                         msgRep.DUAL_HAS_ID_OF.format(sender_link, sender.id))
            else:
                if sender.deleted:
                    text = msgRep.DEL_HAS_ID_OF.format(sender.id)
                elif sender.is_self:
                    text = msgRep.MY_ID.format(sender.id)
                else:
                    text = msgRep.DUAL_HAS_ID_OF.format(sender_link, sender.id)
        elif sender and not org_author:
            if msg.fwd_from and msg.fwd_from.from_name:
                text = (f"**{msgRep.ORIGINAL_AUTHOR}**:\n" +
                        msgRep.ID_NOT_ACCESSIBLE.format(
                            msg.fwd_from.from_name) + "\n\n")
                text += (f"**{msgRep.FORWARDER}**:\n" +
                         msgRep.DUAL_HAS_ID_OF.format(sender_link, sender.id))
            else:
                if sender.deleted:
                    text = msgRep.DEL_HAS_ID_OF.format(sender.id)
                elif sender.is_self:
                    text = msgRep.MY_ID.format(sender.id)
                else:
                    text = msgRep.DUAL_HAS_ID_OF.format(sender_link, sender.id)
        elif not sender and org_author:
            text = msgRep.ORG_HAS_ID_OF.format(org_author_link, org_author.id)
    else:
        user_obj = await fetch_user(event)

        if not user_obj:
            return

        if user_obj.deleted:
            text = msgRep.DEL_HAS_ID_OF.format(user_obj.id)
        elif user_obj.is_self:
            text = msgRep.MY_ID.format(user_obj.id)
        else:
            user_link = f"[{user_obj.first_name}](tg://user?id={user_obj.id})"
            text = msgRep.DUAL_HAS_ID_OF.format(user_link, user_obj.id)
    await event.edit(text)
    return


for cmd in ("userid"):
    register_cmd_usage(cmd,
                       usageRep.USER_USAGE.get(cmd, {}).get("args"),
                       usageRep.USER_USAGE.get(cmd, {}).get("usage"))

register_module_desc(descRep.USER_DESC)
register_module_info(
    name="User",
    version=VERSION
)
