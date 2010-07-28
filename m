From: Lin Ming <ming.m.lin@intel.com>
Subject: [RFC][PATCH 2/4] ACPICA: Implements new OSI interfaces
Date: Wed, 28 Jul 2010 14:28:14 +0800
Message-ID: <1280298494.20797.69.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31223 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab0G1G2G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Jul 2010 02:28:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

Adds 3 new interfaces.

1. acpi_status acpi_install_interface(acpi_string interface_name)

This function installs an interface into the global list of interfaces
that are recognized by the _OSI predefined control method. Once
installed, _OSI will return TRUE for a query that matches the
interface_name.

2. acpi_status acpi_remove_interface(acpi_string interface_name)

This function removes an interface from the global list of interfaces
that are recognized by the _OSI predefined control method. Once removed,
an _OSI query for the interface_name will return FALSE.

3. acpi_status acpi_install_interface_handler(acpi_interface_handler
handler)

This function installs a _OSI interface handler. OS can do specific
handling of the interface _OSI queried in the handler. 

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    7 +
 drivers/acpi/acpica/aclocal.h  |    5 +
 drivers/acpi/acpica/acutils.h  |   17 +++-
 drivers/acpi/acpica/utosi.c    |  243 ++++++++++++++++++++++++++++++++++++----
 drivers/acpi/acpica/utxface.c  |  121 ++++++++++++++++++++-
 include/acpi/acpixf.h          |    6 +
 include/acpi/actypes.h         |    3 +
 7 files changed, 378 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 899d68a..7b75247 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -194,6 +194,11 @@ ACPI_EXTERN u8 acpi_gbl_integer_bit_width;
 ACPI_EXTERN u8 acpi_gbl_integer_byte_width;
 ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
 
+/* Lock for _OSI entries install/remove */
+
+ACPI_EXTERN spinlock_t _acpi_gbl_osi_lock;
+#define acpi_gbl_osi_lock	&_acpi_gbl_osi_lock
+
 /* Reader/Writer lock is used for namespace walk and dynamic table unload */
 
 ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
@@ -262,6 +267,7 @@ ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
 ACPI_EXTERN acpi_tbl_handler acpi_gbl_table_handler;
 ACPI_EXTERN void *acpi_gbl_table_handler_context;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
+ACPI_EXTERN acpi_interface_handler acpi_gbl_interface_handler;
 
 /* Owner ID support */
 
@@ -282,6 +288,7 @@ ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 ACPI_EXTERN u8 acpi_gbl_osi_data;
+ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
 
 #ifndef DEFINE_ACPI_GLOBALS
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 147a7e6..e925969 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -913,9 +913,14 @@ struct acpi_bit_register_info {
 
 struct acpi_interface_info {
 	char *name;
+	struct acpi_interface_info *next;
+	u8 flags;
 	u8 value;
 };
 
+#define ACPI_OSI_INVALID                0x01
+#define ACPI_OSI_DYNAMIC                0x02
+
 struct acpi_port_info {
 	char *name;
 	u16 start;
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 35df755..78e0121 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -312,8 +312,6 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list);
 /*
  * uteval - object evaluation
  */
-acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
-
 acpi_status
 acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 			char *path,
@@ -395,6 +393,21 @@ acpi_status
 acpi_ut_get_object_size(union acpi_operand_object *obj, acpi_size * obj_length);
 
 /*
+ * utosi - Support for the _OSI predefined control method
+ */
+acpi_status acpi_ut_initialize_interfaces(void);
+
+void acpi_ut_interface_terminate(void);
+
+acpi_status acpi_ut_install_interface(acpi_string interface_name);
+
+acpi_status acpi_ut_remove_interface(acpi_string interface_name);
+
+struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name);
+
+acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
+
+/*
  * utstate - Generic state creation/cache routines
  */
 void
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index b156241..af09f71 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -58,33 +58,234 @@ ACPI_MODULE_NAME("utosi")
  * The second element of each entry is used to track the newest version of
  * Windows that the BIOS has requested.
  */
-static struct acpi_interface_info acpi_interfaces_supported[] = {
+static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	/* Operating System Vendor Strings */
 
-	{"Windows 2000", ACPI_OSI_WIN_2000},	/* Windows 2000 */
-	{"Windows 2001", ACPI_OSI_WIN_XP},	/* Windows XP */
-	{"Windows 2001 SP1", ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
-	{"Windows 2001.1", ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
-	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
-	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
-	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
-	{"Windows 2006.1", ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
-	{"Windows 2006 SP1", ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
-	{"Windows 2009", ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
+	{"Windows 2000", NULL, 0, ACPI_OSI_WIN_2000},	/* Windows 2000 */
+	{"Windows 2001", NULL, 0, ACPI_OSI_WIN_XP},	/* Windows XP */
+	{"Windows 2001 SP1", NULL, 0, ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
+	{"Windows 2001.1", NULL, 0, ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
+	{"Windows 2001 SP2", NULL, 0, ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
+	{"Windows 2001.1 SP1", NULL, 0, ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
+	{"Windows 2006", NULL, 0, ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
+	{"Windows 2006.1", NULL, 0, ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
+	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 
 	/* Feature Group Strings */
 
-	{"Extended Address Space Descriptor", 0}
+	{"Extended Address Space Descriptor", NULL, 0, 0}
 
 	/*
 	 * All "optional" feature group strings (features that are implemented
-	 * by the host) should be implemented in the host version of
-	 * acpi_os_validate_interface and should not be added here.
+	 * by the host) should be dynamically added by the host via
+	 * acpi_install_interface and should not be added here.
+	 *
+	 * Examples of optional feature group strings:
+	 *
+	 * "Module Device"
+	 * "Processor Device"
+	 * "3.0 Thermal Model"
+	 * "3.0 _SCP Extensions"
+	 * "Processor Aggregator Device"
 	 */
 };
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ut_initialize_interfaces
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize the global _OSI supported interfaces list
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_initialize_interfaces(void)
+{
+	acpi_cpu_flags flags;
+	u32 i;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
+	acpi_gbl_supported_interfaces = acpi_default_supported_interfaces;
+
+	/* Link the static list of supported interfaces */
+
+	for (i = 0;
+	     i < (ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces) - 1);
+	     i++) {
+		acpi_default_supported_interfaces[i].next =
+		    &acpi_default_supported_interfaces[(acpi_size) i + 1];
+	}
+
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_interface_terminate
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Delete all interfaces in the global list. Sets
+ *              acpi_gbl_supported_interfaces to NULL.
+ *
+ ******************************************************************************/
+
+void acpi_ut_interface_terminate(void)
+{
+	acpi_cpu_flags flags;
+	struct acpi_interface_info *next_interface;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
+	next_interface = acpi_gbl_supported_interfaces;
+
+	while (next_interface) {
+		acpi_gbl_supported_interfaces = next_interface->next;
+
+		/* Only interfaces added at runtime can be freed */
+
+		if (next_interface->flags & ACPI_OSI_DYNAMIC) {
+			ACPI_FREE(next_interface->name);
+			ACPI_FREE(next_interface);
+		}
+
+		next_interface = acpi_gbl_supported_interfaces;
+	}
+
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_install_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to install
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install the interface into the global interface list.
+ *              Caller MUST hold acpi_gbl_osi_lock
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_install_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *interface_info;
+
+	/* Allocate info block and space for the name string */
+
+	interface_info =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_interface_info));
+	if (!interface_info) {
+		return (AE_NO_MEMORY);
+	}
+
+	interface_info->name =
+	    ACPI_ALLOCATE_ZEROED(ACPI_STRLEN(interface_name) + 1);
+	if (!interface_info->name) {
+		ACPI_FREE(interface_info);
+		return (AE_NO_MEMORY);
+	}
+
+	/* Initialize new info and insert at the head of the global list */
+
+	ACPI_STRCPY(interface_info->name, interface_name);
+	interface_info->flags = ACPI_OSI_DYNAMIC;
+	interface_info->next = acpi_gbl_supported_interfaces;
+	acpi_gbl_supported_interfaces = interface_info;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_remove_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to remove
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove the interface from the global interface list.
+ *              Caller MUST hold acpi_gbl_osi_lock
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_remove_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *previous_interface;
+	struct acpi_interface_info *next_interface;
+
+	previous_interface = next_interface = acpi_gbl_supported_interfaces;
+	while (next_interface) {
+		if (!ACPI_STRCMP(interface_name, next_interface->name)) {
+			if (next_interface->flags & ACPI_OSI_DYNAMIC) {
+
+				/* Interface was added dynamically, remove and free it */
+
+				if (previous_interface == next_interface) {
+					acpi_gbl_supported_interfaces =
+					    next_interface->next;
+				} else {
+					previous_interface->next =
+					    next_interface->next;
+				}
+
+				ACPI_FREE(next_interface->name);
+				ACPI_FREE(next_interface);
+			} else {
+				/* Interface is in static list, just mark it invalid */
+
+				next_interface->flags |= ACPI_OSI_INVALID;
+			}
+
+			return (AE_OK);
+		}
+
+		previous_interface = next_interface;
+		next_interface = next_interface->next;
+	}
+
+	/* Interface was not found */
+
+	return (AE_NOT_EXIST);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to find
+ *
+ * RETURN:      struct acpi_interface_info if found. NULL if not found.
+ *
+ * DESCRIPTION: Search for the specified interface name in the global list.
+ *              Caller MUST hold acpi_gbl_osi_lock
+ *
+ ******************************************************************************/
+
+struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *next_interface;
+
+	next_interface = acpi_gbl_supported_interfaces;
+	while (next_interface) {
+		if (!ACPI_STRCMP(interface_name, next_interface->name)) {
+			return (next_interface);
+		}
+
+		next_interface = next_interface->next;
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ut_osi_implementation
  *
  * PARAMETERS:  walk_state          - Current walk state
@@ -125,18 +326,18 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 	/* Compare input string to static table of supported interfaces */
 
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces); i++) {
 		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 acpi_interfaces_supported[i].name)) {
+				 acpi_default_supported_interfaces[i].name)) {
 			/*
 			 * The interface is supported.
 			 * Update the osi_data if necessary. We keep track of the latest
 			 * version of Windows that has been requested by the BIOS.
 			 */
-			if (acpi_interfaces_supported[i].value >
+			if (acpi_default_supported_interfaces[i].value >
 			    acpi_gbl_osi_data) {
 				acpi_gbl_osi_data =
-				    acpi_interfaces_supported[i].value;
+				    acpi_default_supported_interfaces[i].value;
 			}
 
 			return_value = ACPI_UINT32_MAX;
@@ -185,9 +386,9 @@ acpi_status acpi_osi_invalidate(char *interface)
 {
 	int i;
 
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
-			*acpi_interfaces_supported[i].name = '\0';
+	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces); i++) {
+		if (!ACPI_STRCMP(interface, acpi_default_supported_interfaces[i].name)) {
+			*acpi_default_supported_interfaces[i].name = '\0';
 			return AE_OK;
 		}
 	}
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index db9d8ca..f765bd7 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -110,6 +110,15 @@ acpi_status __init acpi_initialize_subsystem(void)
 		return_ACPI_STATUS(status);
 	}
 
+	/* Initialize the global OSI interfaces list with the static names */
+
+	status = acpi_ut_initialize_interfaces();
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During OSI interfaces initialization"));
+		return_ACPI_STATUS(status);
+	}
+
 	/* If configured, initialize the AML debugger */
 
 	ACPI_DEBUGGER_EXEC(status = acpi_db_initialize());
@@ -533,4 +542,114 @@ acpi_status acpi_purge_cached_objects(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
-#endif
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_install_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to install
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install an _OSI interface to the global list
+ *
+ ****************************************************************************/
+acpi_status acpi_install_interface(acpi_string interface_name)
+{
+	acpi_status status;
+	acpi_cpu_flags flags;
+	struct acpi_interface_info *interface_info;
+
+	/* Parameter validation */
+
+	if (!interface_name || (ACPI_STRLEN(interface_name) == 0)) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
+
+	/* Check if the interface name is already in the global list */
+
+	interface_info = acpi_ut_get_interface(interface_name);
+	if (interface_info) {
+		/*
+		 * The interface already exists in the list. This is OK if the
+		 * interface has been marked invalid -- just clear the bit.
+		 */
+		if (interface_info->flags & ACPI_OSI_INVALID) {
+			interface_info->flags &= ~ACPI_OSI_INVALID;
+			status = AE_OK;
+		} else {
+			status = AE_ALREADY_EXISTS;
+		}
+	} else {
+		/* New interface name, install into the global list */
+
+		status = acpi_ut_install_interface(interface_name);
+	}
+
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_interface)
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_remove_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to remove
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove an _OSI interface from the global list
+ *
+ ****************************************************************************/
+acpi_status acpi_remove_interface(acpi_string interface_name)
+{
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	/* Parameter validation */
+
+	if (!interface_name || (ACPI_STRLEN(interface_name) == 0)) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
+
+	status = acpi_ut_remove_interface(interface_name);
+
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_remove_interface)
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_install_interface_handler
+ *
+ * PARAMETERS:  Handler             - The OSI interface handler to install
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install OSI interface handler, actually remove the handler
+ *              if Handler is NULL.
+ *
+ ****************************************************************************/
+acpi_status acpi_install_interface_handler(acpi_interface_handler handler)
+{
+	acpi_cpu_flags flags;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_osi_lock);
+
+	acpi_gbl_interface_handler = handler;
+
+	acpi_os_release_lock(acpi_gbl_osi_lock, flags);
+
+	return (AE_OK);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
+#endif				/* !ACPI_ASL_COMPILER */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 1371cc9..b388521 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -106,6 +106,10 @@ const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
 
+acpi_status acpi_install_interface(acpi_string interface_name);
+
+acpi_status acpi_remove_interface(acpi_string interface_name);
+
 /*
  * ACPI Memory management
  */
@@ -264,6 +268,8 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
 #endif
 
+acpi_status acpi_install_interface_handler(acpi_interface_handler handler);
+
 /*
  * Event interfaces
  */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d55f4a7..51cdb59 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -956,6 +956,9 @@ acpi_status(*acpi_walk_callback) (acpi_handle object,
 				  u32 nesting_level,
 				  void *context, void **return_value);
 
+typedef
+void (*acpi_interface_handler) (acpi_string interface_name);
+
 /* Interrupt handler return values */
 
 #define ACPI_INTERRUPT_NOT_HANDLED      0x00




