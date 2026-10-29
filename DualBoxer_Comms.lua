function DualBoxer:CommsInit()
    return C_ChatInfo.RegisterAddonMessagePrefix(DualBoxer.MessagePrefix)
end

function DualBoxer:SendMessage(message)
    DualBoxer.DebugPrint(format("Sending test message: %s", message))
    return C_ChatInfo.SendAddonMessage(DualBoxer.MessagePrefix, message, "PARTY")
end
