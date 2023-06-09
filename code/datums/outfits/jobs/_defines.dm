#define OUTFIT_JOB_NAME(job_name) ("Job - " + job_name)

#define BACKPACK_OVERRIDE_CHEMISTRY \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/chemistry; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/chem; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/chem;

#define BACKPACK_OVERRIDE_ENGINEERING \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/industrial; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/eng; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/engi;

#define BACKPACK_OVERRIDE_MEDICAL \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/medic; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/med; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/med;

#define BACKPACK_OVERRIDE_RESEARCH \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/sci; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/sci; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/sci;

#define BACKPACK_OVERRIDE_RESEARCH_CORP \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/corpsci; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/corpsci; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/corpsci;

#define BACKPACK_OVERRIDE_SECURITY \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/security; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/sec; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/sec;

#define BACKPACK_OVERRIDE_SECURITY_EXO \
backpack_overrides[/singleton/backpack_outfit/backpack]      = /obj/item/storage/backpack/security/exo; \
backpack_overrides[/singleton/backpack_outfit/satchel]       = /obj/item/storage/backpack/satchel/sec/exo; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag] = /obj/item/storage/backpack/messenger/sec/exo;

#define BACKPACK_OVERRIDE_COMMAND \
backpack_overrides[/singleton/backpack_outfit/backpack]		= /obj/item/storage/backpack/command; \
backpack_overrides[/singleton/backpack_outfit/satchel]		= /obj/item/storage/backpack/satchel/com; \
backpack_overrides[/singleton/backpack_outfit/messenger_bag]	= /obj/item/storage/backpack/messenger/com;
