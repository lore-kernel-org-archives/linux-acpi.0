From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] ACPI autoload (v2) - acpica modifications
Date: Mon, 23 Jul 2007 14:43:32 +0200
Message-ID: <1185194612.14451.44.camel@fanta4.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:48002 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855AbXGWMpC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 08:45:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>

Define standardized HIDs - Rename current acpi_device_id to acpica_device_id

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/acpi/events/evrgnini.c    |    2 +-
 drivers/acpi/namespace/nsxfeval.c |    2 +-
 drivers/acpi/utilities/uteval.c   |    4 ++--
 include/acpi/acpi_bus.h           |    5 +++--
 include/acpi/acpi_drivers.h       |   21 +++++++++++++--------
 include/acpi/actypes.h            |    6 +++---
 include/acpi/acutils.h            |    4 ++--
 7 files changed, 25 insertions(+), 19 deletions(-)

Index: lenb/drivers/acpi/events/evrgnini.c
===================================================================
--- lenb.orig/drivers/acpi/events/evrgnini.c
+++ lenb/drivers/acpi/events/evrgnini.c
@@ -378,7 +378,7 @@ static u8 acpi_ev_match_pci_root_bridge(
 static u8 acpi_ev_is_pci_root_bridge(struct acpi_namespace_node *node)
 {
 	acpi_status status;
-	struct acpi_device_id hid;
+	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
 
Index: lenb/drivers/acpi/utilities/uteval.c
===================================================================
--- lenb.orig/drivers/acpi/utilities/uteval.c
+++ lenb/drivers/acpi/utilities/uteval.c
@@ -407,7 +407,7 @@ acpi_ut_copy_id_string(char *destination
 
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *hid)
+		    struct acpica_device_id *hid)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
@@ -609,7 +609,7 @@ acpi_ut_execute_CID(struct acpi_namespac
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *uid)
+		    struct acpica_device_id *uid)
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
Index: lenb/include/acpi/actypes.h
===================================================================
--- lenb.orig/include/acpi/actypes.h
+++ lenb/include/acpi/actypes.h
@@ -809,7 +809,7 @@ acpi_status(*acpi_walk_callback) (acpi_h
 
 /* Common string version of device HIDs and UIDs */
 
-struct acpi_device_id {
+struct acpica_device_id {
 	char value[ACPI_DEVICE_ID_LENGTH];
 };
 
@@ -859,8 +859,8 @@ struct acpi_device_info {
 	u32 valid;		/* Indicates which fields below are valid */
 	u32 current_status;	/* _STA value */
 	acpi_integer address;	/* _ADR value if any */
-	struct acpi_device_id hardware_id;	/* _HID value if any */
-	struct acpi_device_id unique_id;	/* _UID value if any */
+	struct acpica_device_id hardware_id;	/* _HID value if any */
+	struct acpica_device_id unique_id;	/* _UID value if any */
 	u8 highest_dstates[4];	/* _sx_d values: 0xFF indicates not valid */
 	struct acpi_compatible_id_list compatibility_id;	/* List of _CIDs if any */
 };
Index: lenb/include/acpi/acutils.h
===================================================================
--- lenb.orig/include/acpi/acutils.h
+++ lenb/include/acpi/acutils.h
@@ -354,7 +354,7 @@ acpi_ut_evaluate_numeric_object(char *ob
 
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *hid);
+		    struct acpica_device_id *hid);
 
 acpi_status
 acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
@@ -366,7 +366,7 @@ acpi_ut_execute_STA(struct acpi_namespac
 
 acpi_status
 acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
-		    struct acpi_device_id *uid);
+		    struct acpica_device_id *uid);
 
 acpi_status
 acpi_ut_execute_sxds(struct acpi_namespace_node *device_node, u8 * highest);
Index: lenb/include/acpi/acpi_bus.h
===================================================================
--- lenb.orig/include/acpi/acpi_bus.h
+++ lenb/include/acpi/acpi_bus.h
@@ -131,7 +131,7 @@ struct acpi_device_ops {
 struct acpi_driver {
 	char name[80];
 	char class[80];
-	char *ids;		/* Supported Hardware IDs */
+	const struct acpi_device_id *ids; /* Supported Hardware IDs */
 	struct acpi_device_ops ops;
 	struct device_driver drv;
 	struct module *owner;
@@ -341,7 +341,8 @@ int acpi_bus_add(struct acpi_device **ch
 int acpi_bus_trim(struct acpi_device *start, int rmdevice);
 int acpi_bus_start(struct acpi_device *device);
 acpi_status acpi_bus_get_ejd(acpi_handle handle, acpi_handle * ejd);
-int acpi_match_ids(struct acpi_device *device, char *ids);
+int acpi_match_device_ids(struct acpi_device *device,
+			  const struct acpi_device_id *ids);
 int acpi_create_dir(struct acpi_device *);
 void acpi_remove_dir(struct acpi_device *);
 
Index: lenb/include/acpi/acpi_drivers.h
===================================================================
--- lenb.orig/include/acpi/acpi_drivers.h
+++ lenb/include/acpi/acpi_drivers.h
@@ -34,16 +34,21 @@
 #define ACPI_BUS_COMPONENT		0x00010000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 
-/* _HID definitions */
+/*
+ * _HID definitions
+ * HIDs must conform to ACPI spec(6.1.4)
+ * Linux specific HIDs do not apply to this and begin with LNX:
+ */
 
-#define ACPI_POWER_HID			"power_resource"
+#define ACPI_POWER_HID			"LNXPOWER"
 #define ACPI_PROCESSOR_HID		"ACPI0007"
-#define ACPI_SYSTEM_HID			"acpi_system"
-#define ACPI_THERMAL_HID		"thermal"
-#define ACPI_BUTTON_HID_POWERF		"button_power"
-#define ACPI_BUTTON_HID_SLEEPF		"button_sleep"
-#define ACPI_VIDEO_HID			"video"
-#define ACPI_BAY_HID			"bay"
+#define ACPI_SYSTEM_HID			"LNXSYSTM"
+#define ACPI_THERMAL_HID		"LNXTHERM"
+#define ACPI_BUTTON_HID_POWERF		"LNXPWRBN"
+#define ACPI_BUTTON_HID_SLEEPF		"LNXSLPBN"
+#define ACPI_VIDEO_HID			"LNXVIDEO"
+#define ACPI_BAY_HID			"LNXIOBAY"
+
 /* --------------------------------------------------------------------------
                                        PCI
    -------------------------------------------------------------------------- */
Index: lenb/drivers/acpi/namespace/nsxfeval.c
===================================================================
--- lenb.orig/drivers/acpi/namespace/nsxfeval.c
+++ lenb/drivers/acpi/namespace/nsxfeval.c
@@ -440,7 +440,7 @@ acpi_ns_get_device_callback(acpi_handle 
 	acpi_status status;
 	struct acpi_namespace_node *node;
 	u32 flags;
-	struct acpi_device_id hid;
+	struct acpica_device_id hid;
 	struct acpi_compatible_id_list *cid;
 	acpi_native_uint i;
 


