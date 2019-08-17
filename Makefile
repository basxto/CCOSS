CC=c++
CXX=c++

PREPARED_DIR=
OBJ_DIR=objs

ifneq ($(shell command -v ccache 2> /dev/null),)
CC::=ccache $(CC)
CXX::=ccache $(CXX)
$(info Building with ccache ENABLED!)
else
$(info Building with ccache DISABLED. Consider installing it.)
endif

ifeq ($(strip $(PREPARED_DIR)),)
$(error The PREPARED_DIR variable has not been set. Set it to your system's path to the dependencies by appending PREPARED_DIR=foo . You can find the dependencies here: https://github.com/liberated-cortex/CCOSS_dependencies)
endif

RAKNET_LOCATION=external/sources/RakNet
LUABIND_LOCATION=external/sources/luabind-0.9.1
ENTITIES_INC=-IEntities/
RAKNET_INC=-I$(RAKNET_LOCATION)
LUA_INC=-I$(LUABIND_LOCATION)
MANAGERS_INC=-IManagers/
SYSTEM_INC=-ISystem -ISystem/MicroPather -ISystem/InterGif -ISystem/MD5 -ISystem/Steam -ISystem/Slick_Profiler -ISystem/LZ4
GUI_INC=-IGUI
MENUS_INC=-IMenus
ALLEGRO_LIBS=$(PREPARED_DIR)/liballeg.a -lm -lpthread -lrt -lSM -lICE -lX11 -lXext -lXext -lXcursor -lXcursor -lXpm -lXxf86vm -lXxf86dga -lSM -lICE -lX11 -lXext -ldl
ZLIB_LIBS=$(PREPARED_DIR)/libz.a
LUA_LIBS=$(PREPARED_DIR)/liblua.a
OGG_LIBS=$(PREPARED_DIR)/libogg.a
VORBIS_LIBS=$(PREPARED_DIR)/libvorbis.a
#VORBISFILE_LIBS=$(PREPARED_DIR)/libvorbisfile.a
VORBISFILE_LIBS::=$(shell pkg-config --libs vorbisfile)
MINIZIP_LIBS=$(PREPARED_DIR)/libminizip.a $(PREPARED_DIR)/libaes.a
BSD_LIBS=$(PREPARED_DIR)/libbsd.a
OPENAL_LIBS::=$(shell pkg-config --libs openal)
GORILLA_AUDIO_LIBS=$(PREPARED_DIR)/libgorilla.a
SHARED_LIBS=-lpthread -ldl

INCLUDES=-I. -I$(PREPARED_DIR)/include/minizip -I$(PREPARED_DIR)/include $(LUA_INC) $(ENTITIES_INC) $(RAKNET_INC) $(MANAGERS_INC) $(SYSTEM_INC) $(GUI_INC) $(MENUS_INC) $(ALLEGRO_INC) $(BOOST_INC) $(LUABIND_INC)
INCLUDES+= $(OPENAL_INC) $(OGG_INC) $(VORBIS_INC) $(VORBISFILE_INC) $(MINIZIP_INC) $(OPENSSL_INC)
WARN=-Wno-write-strings -Wno-endif-labels -Wno-deprecated-declarations
CPPFLAGS=-D__USE_SOUND_GORILLA -D__OPEN_SOURCE_EDITION -std=c++11 -fdiagnostics-color $(INCLUDES) $(WARN) -DALLEGRO_NO_FIX_ALIASES -fpermissive -g
LDFLAGS=-Llibs/ $(ALLEGRO_LIBS) $(OPENSSL_LIBS) $(BOOST_LIBS) $(LUABIND_LIBS) $(LUA_LIBS) $(ZIPIO_LIBS) $(OPENAL_LIBS) $(OGG_LIBS) $(VORBIS_LIBS) $(VORBISFILE_LIBS)
LDFLAGS+= $(MINIZIP_LIBS) $(ZLIB_LIBS) $(BSD_LIBS) $(GORILLA_AUDIO_LIBS) $(OPENAL_LIBS) $(SHARED_LIBS)

ENTITIES_SRCS=MultiplayerGame MultiplayerServerLobby Controller Emission PEmitter ACDropShip ACrab ACraft ACRocket Actor ADoor AEmitter AHuman Arm Atom AtomGroup Attachable BunkerAssembly BunkerAssemblyScheme Deployment Entity GlobalScript HDFirearm HeldDevice Icon Leg LimbPath Loadout Magazine Material MetaPlayer MOPixel MOSParticle MOSprite MOSRotating MovableObject Scene SceneLayer SceneObject SLTerrain Sound TDExplosive TerrainDebris TerrainObject ThrownDevice Turret ActorEditor AreaEditor AssemblyEditor BaseEditor EditorActivity GABaseDefense GABrainMatch GameActivity GAScripted GATutorial GibEditor SceneEditor
RAKNET_SRCS=Base64Encoder BitStream CCRakNetSlidingWindow CCRakNetUDT CheckSum CloudClient CloudCommon CloudServer CommandParserInterface ConnectionGraph2 ConsoleServer DataCompressor DirectoryDeltaTransfer DR_SHA1 DS_BytePool DS_ByteQueue DS_HuffmanEncodingTree DS_Table DynDNS EmailSender EpochTimeToString FileList FileListTransfer FileOperations FormatString FullyConnectedMesh2 Getche Gets GetTime gettimeofday GridSectorizer HTTPConnection HTTPConnection2 IncrementalReadInterface Itoa LinuxStrings LocklessTypes LogCommandParser MessageFilter NatPunchthroughClient NatPunchthroughServer NatTypeDetectionClient NatTypeDetectionCommon NatTypeDetectionServer NetworkIDManager NetworkIDObject PacketConsoleLogger PacketFileLogger PacketizedTCP PacketLogger PacketOutputWindowLogger PluginInterface2 PS4Includes Rackspace RakMemoryOverride RakNetCommandParser RakNetSocket RakNetSocket2 RakNetSocket2_360_720 RakNetSocket2_Berkley RakNetSocket2_Berkley_NativeClient RakNetSocket2_NativeClient RakNetSocket2_PS3_PS4 RakNetSocket2_PS4 RakNetSocket2_Vita RakNetSocket2_WindowsStore8 RakNetSocket2_Windows_Linux RakNetSocket2_Windows_Linux_360 RakNetStatistics RakNetTransport2 RakNetTypes RakPeer RakSleep RakString RakThread RakWString Rand RandSync ReadyEvent RelayPlugin ReliabilityLayer ReplicaManager3 Router2 RPC4Plugin SecureHandshake SendToThread SignaledEvent SimpleMutex SocketLayer StatisticsHistory StringCompressor StringTable SuperFastHash TableSerializer TCPInterface TeamBalancer TeamManager TelnetTransport ThreadsafePacketLogger TwoWayAuthentication UDPForwarder UDPProxyClient UDPProxyCoordinator UDPProxyServer VariableDeltaSerializer VariableListDeltaTracker VariadicSQLParser VitaIncludes _FindFirst WSAStartupSingleton
MANAGERS_SRCS=NetworkServer NetworkClient AchievementMan ActivityMan AudioMan ConsoleMan LicenseMan EntityMan FrameMan LuaMan MetaMan MovableMan PresetMan SceneMan SettingsMan TimerMan UInputMan
SYSTEM_SRCS=Box Color ContentFile DataModule DDTError DDTTools Matrix PathFinder Reader System Timer Vector Writer MicroPather/micropather LZ4/lz4 LZ4/lz4hc
GUI_SRCS=AllegroBitmap AllegroInput AllegroScreen GUI GUIBanner GUIButton GUICheckbox GUICollectionBox GUIComboBox GUIControl GUIControlFactory GUIControlManager GUIEvent GUIFont GUIInput GUILabel GUIListBox GUIListPanel GUIManager GUIPanel GUIProgressBar GUIProperties GUIPropertyPage GUIRadioButton GUIScrollbar GUIScrollPanel GUISkin GUISlider GUITab GUITextBox GUITextPanel GUIUtil
MENUS_SRCS=AreaEditorGUI AreaPickerGUI AssemblyEditorGUI BuyMenuGUI GibEditorGUI MainMenuGUI MetagameGUI ObjectPickerGUI PieMenuGUI ScenarioGUI SceneEditorGUI
LUABIND_SRCS=class class_info class_registry class_rep create_class error exception_handler function inheritance link_compatibility object_rep open pcall scope stack_content_by_name weak_ref wrapper_base

OBJS=$(foreach src,$(SYSTEM_SRCS),$(OBJ_DIR)/System/$(src).o) $(foreach src,$(ENTITIES_SRCS),$(OBJ_DIR)/Entities/$(src).o) $(foreach src,$(MANAGERS_SRCS),$(OBJ_DIR)/Managers/$(src).o) $(foreach src,$(GUI_SRCS),$(OBJ_DIR)/GUI/$(src).o) $(foreach src,$(MENUS_SRCS),$(OBJ_DIR)/Menus/$(src).o)

.PHONY: all
all: cortex

cortex: $(OBJS) $(OBJ_DIR)/libluabind.a $(OBJ_DIR)/libraknet.a
	$(CXX) $(CPPFLAGS) -o $@ Main.cpp $^ $(LDFLAGS)

$(OBJ_DIR)/libluabind.a: $(foreach src,$(LUABIND_SRCS),$(OBJ_DIR)/LUABIND/$(src).o)
	ar rcs $@ $^

$(OBJ_DIR)/LUABIND/%.o: $(LUABIND_LOCATION)/src/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -c $^ -o $@

$(OBJ_DIR)/libraknet.a: $(foreach src,$(RAKNET_SRCS),$(OBJ_DIR)/RAKNET/$(src).o)
	ar rcs $@ $^

$(OBJ_DIR)/RAKNET/%.o: $(RAKNET_LOCATION)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -c $^ -o $@

# oh my
$(OBJ_DIR)/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) -c $^ -o $@

$(OBJ_DIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) -c $^ -o $@

clean:
	rm -r $(OBJ_DIR)
	rm cortex
