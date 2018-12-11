import Foundation
#if os(macOS)
    import PostboxMac
#else
    import Postbox
#endif

public struct Namespaces {
    public struct Message {
        public static let Cloud: Int32 = 0
        public static let Local: Int32 = 1
        public static let SecretIncoming: Int32 = 2
    }
    
    public struct Media {
        public static let CloudImage: Int32 = 0
        public static let CloudAudio: Int32 = 2
        public static let CloudContact: Int32 = 3
        public static let CloudMap: Int32 = 4
        public static let CloudFile: Int32 = 5
        public static let CloudWebpage: Int32 = 6
        public static let LocalImage: Int32 = 7
        public static let LocalFile: Int32 = 8
        public static let CloudSecretImage: Int32 = 9
        public static let CloudSecretFile: Int32 = 10
        public static let CloudGame: Int32 = 11
        public static let CloudInvoice: Int32 = 12
        public static let LocalWebpage: Int32 = 13
    }
    
    public struct Peer {
        public static let CloudUser: Int32 = 0
        public static let CloudGroup: Int32 = 1
        public static let CloudChannel: Int32 = 2
        public static let SecretChat: Int32 = 3
        public static let Empty: Int32 = Int32.max
    }
    
    public struct ItemCollection {
        public static let CloudStickerPacks: Int32 = 0
        public static let CloudMaskPacks: Int32 = 1
        public static let CloudRecentStickers: Int32 = 2
    }
    
    public struct OrderedItemList {
        public static let CloudRecentStickers: Int32 = 0
        public static let CloudRecentGifs: Int32 = 1
        public static let RecentlySearchedPeerIds: Int32 = 2
        public static let CloudRecentInlineBots: Int32 = 3
        public static let CloudFeaturedStickerPacks: Int32 = 4
        public static let CloudArchivedStickerPacks: Int32 = 5
        public static let CloudWallpapers: Int32 = 6
        public static let CloudSavedStickers: Int32 = 7
        public static let RecentlyUsedHashtags: Int32 = 8
    }
    
    struct CachedItemCollection {
        public static let resolvedByNamePeers: Int8 = 0
        public static let cachedTwoStepToken: Int8 = 1
        public static let cachedStickerPacks: Int8 = 2
        public static let cachedAvailableLocalizations: Int8 = 3
        public static let cachedSentMediaReferences: Int8 = 4
        public static let cachedStickerQueryResults: Int8 = 5
        public static let cachedSecureIdConfiguration: Int8 = 6
    }
    
    struct UnorderedItemList {
        static let synchronizedDeviceContacts: UnorderedItemListEntryTag = {
            let key = ValueBoxKey(length: 1)
            key.setUInt8(0, value: 0)
            return UnorderedItemListEntryTag(value: key)
        }()
    }
    
    public struct PeerGroup {
        public static let feed = PeerGroupId(rawValue: 1)
    }
}

public extension MessageTags {
    static let photoOrVideo = MessageTags(rawValue: 1 << 0)
    static let file = MessageTags(rawValue: 1 << 1)
    static let music = MessageTags(rawValue: 1 << 2)
    static let webPage = MessageTags(rawValue: 1 << 3)
    static let voiceOrInstantVideo = MessageTags(rawValue: 1 << 4)
    static let unseenPersonalMessage = MessageTags(rawValue: 1 << 5)
    static let liveLocation = MessageTags(rawValue: 1 << 6)
    
    static let all: MessageTags = [.photoOrVideo, .file, .music, .webPage, .voiceOrInstantVideo, .unseenPersonalMessage, .liveLocation]
}

public extension GlobalMessageTags {
    static let Calls = GlobalMessageTags(rawValue: 1 << 0)
    static let MissedCalls = GlobalMessageTags(rawValue: 1 << 1)
    
    static let all: GlobalMessageTags = [.Calls, .MissedCalls]
}

public extension LocalMessageTags {
    static let OutgoingLiveLocation = LocalMessageTags(rawValue: 1 << 0)
    static let OutgoingDeliveredToServer = LocalMessageTags(rawValue: 1 << 1)
}

public extension PendingMessageActionType {
    static let consumeUnseenPersonalMessage = PendingMessageActionType(rawValue: 0)
}

let peerIdNamespacesWithInitialCloudMessageHoles = [Namespaces.Peer.CloudUser, Namespaces.Peer.CloudGroup, Namespaces.Peer.CloudChannel]

public struct OperationLogTags {
    public static let SecretOutgoing = PeerOperationLogTag(value: 0)
    static let SecretIncomingEncrypted = PeerOperationLogTag(value: 1)
    static let SecretIncomingDecrypted = PeerOperationLogTag(value: 2)
    static let CloudChatRemoveMessages = PeerOperationLogTag(value: 3)
    static let SynchronizePinnedCloudChats = PeerOperationLogTag(value: 4)
    static let AutoremoveMessages = PeerOperationLogTag(value: 5)
    static let SynchronizePinnedChats = PeerOperationLogTag(value: 6)
    static let SynchronizeConsumeMessageContents = PeerOperationLogTag(value: 7)
    static let SynchronizeInstalledStickerPacks = PeerOperationLogTag(value: 8)
    static let SynchronizeInstalledMasks = PeerOperationLogTag(value: 9)
    static let SynchronizeMarkFeaturedStickerPacksAsSeen = PeerOperationLogTag(value: 10)
    static let SynchronizeChatInputStates = PeerOperationLogTag(value: 11)
    static let SynchronizeSavedGifs = PeerOperationLogTag(value: 12)
    static let SynchronizeLocalizationUpdates = PeerOperationLogTag(value: 13)
    static let SynchronizeSavedStickers = PeerOperationLogTag(value: 14)
    static let SynchronizeGroupedPeers = PeerOperationLogTag(value: 15)
    static let SynchronizeMarkAllUnseenPersonalMessages = PeerOperationLogTag(value: 16)
    static let SynchronizeRecentlyUsedStickers = PeerOperationLogTag(value: 17)
    static let SynchronizeAppLogEvents = PeerOperationLogTag(value: 18)
}

public extension PeerSummaryCounterTags {
    public static let regularChatsAndPrivateGroups = PeerSummaryCounterTags(rawValue: 1 << 0)
    public static let publicGroups = PeerSummaryCounterTags(rawValue: 1 << 1)
    public static let channels = PeerSummaryCounterTags(rawValue: 1 << 2)
}

private enum PreferencesKeyValues: Int32 {
    case globalNotifications = 0
    case cacheStorageSettings = 1
    case localizationSettings = 2
    case suggestedLocalization = 3
    case limitsConfiguration = 4
    case proxySettings = 5
    case coreSettings = 7
    case contentPrivacySettings = 8
    case networkSettings = 9
    case remoteStorageConfiguration = 10
    case voipConfiguration = 11
    case appChangelogState = 12
    case localizationListState = 13
    case appConfiguration = 14
    case searchBotsConfiguration = 15
}

public func applicationSpecificPreferencesKey(_ value: Int32) -> ValueBoxKey {
    let key = ValueBoxKey(length: 4)
    key.setInt32(0, value: value + 1000)
    return key
}

public struct PreferencesKeys {
    public static let globalNotifications: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.globalNotifications.rawValue)
        return key
    }()
    
    public static let cacheStorageSettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.cacheStorageSettings.rawValue)
        return key
    }()
    
    public static let localizationSettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.localizationSettings.rawValue)
        return key
    }()
    
    public static let suggestedLocalization: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.suggestedLocalization.rawValue)
        return key
    }()
    
    public static let limitsConfiguration: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.limitsConfiguration.rawValue)
        return key
    }()
    
    public static let proxySettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.proxySettings.rawValue)
        return key
    }()
    
    public static let coreSettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.coreSettings.rawValue)
        return key
    }()
    
    public static let contentPrivacySettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.contentPrivacySettings.rawValue)
        return key
    }()
    
    public static let networkSettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.networkSettings.rawValue)
        return key
    }()
    
    public static let remoteStorageConfiguration: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.remoteStorageConfiguration.rawValue)
        return key
    }()
    
    public static let voipConfiguration: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.voipConfiguration.rawValue)
        return key
    }()
    
    public static let appChangelogState: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.appChangelogState.rawValue)
        return key
    }()
    
    public static let localizationListState: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.localizationListState.rawValue)
        return key
    }()
    
    public static let appConfiguration: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.appConfiguration.rawValue)
        return key
    }()
    
    public static let searchBotsConfiguration: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: PreferencesKeyValues.searchBotsConfiguration.rawValue)
        return key
    }()
}

private enum SharedDataKeyValues: Int32 {
    case loggingSettings = 0
}

public struct SharedDataKeys {
    public static let loggingSettings: ValueBoxKey = {
        let key = ValueBoxKey(length: 4)
        key.setInt32(0, value: SharedDataKeyValues.loggingSettings.rawValue)
        return key
    }()
}

public func applicationSpecificItemCacheCollectionId(_ value: Int8) -> Int8 {
    return 64 + value
}

public func applicationSpecificOrderedItemListCollectionId(_ value: Int32) -> Int32 {
    return 1000 + value
}
