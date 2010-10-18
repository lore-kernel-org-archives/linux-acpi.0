From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20101013 linuxized patches
Date: Mon, 18 Oct 2010 09:49:31 +0800
Message-ID: <1287366571.6530.3026.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WZkrbbyvM3S1D0QSHdrz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12547 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab0JRBwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 17 Oct 2010 21:52:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-WZkrbbyvM3S1D0QSHdrz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

ACPICA release 20101013 linuxized patches attached.
There is a small conflict for PATCH 5 between test and acpica branches,
so I made 2 mbox files for each branch to apply, you choose it.

acpica-v20101013-on_top_of_test_branch.mbox applied cleanly on top of
your linux-acpi-2.6/test branch.

acpica-v20101013-on_top_of_acpica_branch.mbox applied cleanly on top of
your linux-acpi-2.6/acpica branch.

Build/Tested on my 32/64 bit machines, both work OK.

[PATCH 1/6] ACPICA: Comment update; no functional change
[PATCH 2/6] ACPICA: Change type of _TZ from ThermalZone to Device
[PATCH 3/6] ACPICA: Eliminate duplicate code in acpi_ut_execute_* functions
[PATCH 4/6] ACPICA: Add Vista SP2 to supported _OSI strings
[PATCH 5/6] ACPICA: Clear PCIEXP_WAKE_STS when clearing ACPI events
[PATCH 6/6] ACPICA: Update version to 20101013

Lin Ming

--=-WZkrbbyvM3S1D0QSHdrz
Content-Type: application/mbox; name="acpica-v20101013-on_top_of_acpica_branch.mbox"
Content-Disposition: attachment; filename="acpica-v20101013-on_top_of_acpica_branch.mbox"
Content-Transfer-Encoding: 7bit

>From a62aab9d00993d08810e0890241d89066e235f7e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:43:13 +0800
Subject: [PATCH 1/6] ACPICA: Comment update; no functional change

Add a usage note to InstallAddressSpaceHandler.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/evxfregn.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 541cbc1..ce9314f 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -64,6 +64,12 @@ ACPI_MODULE_NAME("evxfregn")
  *
  * DESCRIPTION: Install a handler for all op_regions of a given space_id.
  *
+ * NOTE: This function should only be called after acpi_enable_subsystem has
+ * been called. This is because any _REG methods associated with the Space ID
+ * are executed here, and these methods can only be safely executed after
+ * the default handlers have been installed and the hardware has been
+ * initialized (via acpi_enable_subsystem.)
+ *
  ******************************************************************************/
 acpi_status
 acpi_install_address_space_handler(acpi_handle device,

>From e3a8653a164f0c5b6580f8e2ca4d67702a9f20aa Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:44:34 +0800
Subject: [PATCH 2/6] ACPICA: Change type of _TZ from ThermalZone to Device

The type of ThermalZone was confusing hosts as they process the
various ThermalZone objects. ACPICA BZ 876.

http://www.acpica.org/bugzilla/show_bug.cgi?id=876

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utglobal.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 45f6334..4a5dcaa 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -154,14 +154,16 @@ ACPI_EXPORT_SYMBOL(acpi_format_exception)
  * 1) _SB_ is defined to be a device to allow \_SB_._INI to be run
  *    during the initialization sequence.
  * 2) _TZ_ is defined to be a thermal zone in order to allow ASL code to
- *    perform a Notify() operation on it.
+ *    perform a Notify() operation on it. 09/2010: Changed to type Device.
+ *    This still allows notifies, but does not confuse host code that
+ *    searches for valid thermal_zone objects.
  */
 const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
 	{"_GPE", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_PR_", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_SB_", ACPI_TYPE_DEVICE, NULL},
 	{"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
-	{"_TZ_", ACPI_TYPE_THERMAL, NULL},
+	{"_TZ_", ACPI_TYPE_DEVICE, NULL},
 	{"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
 	{"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
 	{"_GL_", ACPI_TYPE_MUTEX, (char *)1},

>From 60bbb75887c99e15c2d2b21c470bc333d4cf4be4 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:47:16 +0800
Subject: [PATCH 3/6] ACPICA: Eliminate duplicate code in acpi_ut_execute_* functions

Now that the nsrepair code automatically repairs _HID-related
strings, this type of code is no longer needed in acpi_ut_execute_HID,
acpi_ut_execute_CID, and acpi_ut_execute_UID. ACPICA BZ 878.

http://www.acpica.org/bugzilla/show_bug.cgi?id=878

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utids.c |   45 +++---------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 1397fad..d290632 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -48,42 +48,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utids")
 
-/* Local prototypes */
-static void acpi_ut_copy_id_string(char *destination, char *source);
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_copy_id_string
- *
- * PARAMETERS:  Destination         - Where to copy the string
- *              Source              - Source string
- *
- * RETURN:      None
- *
- * DESCRIPTION: Copies an ID string for the _HID, _CID, and _UID methods.
- *              Performs removal of a leading asterisk if present -- workaround
- *              for a known issue on a bunch of machines.
- *
- ******************************************************************************/
-
-static void acpi_ut_copy_id_string(char *destination, char *source)
-{
-
-	/*
-	 * Workaround for ID strings that have a leading asterisk. This construct
-	 * is not allowed by the ACPI specification  (ID strings must be
-	 * alphanumeric), but enough existing machines have this embedded in their
-	 * ID strings that the following code is useful.
-	 */
-	if (*source == '*') {
-		source++;
-	}
-
-	/* Do the actual copy */
-
-	ACPI_STRCPY(destination, source);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_execute_HID
@@ -101,7 +65,6 @@ static void acpi_ut_copy_id_string(char *destination, char *source)
  *              NOTE: Internal function, no parameter validation
  *
  ******************************************************************************/
-
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 		    struct acpica_device_id **return_id)
@@ -147,7 +110,7 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_eisa_id_to_string(hid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(hid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(hid->string, obj_desc->string.pointer);
 	}
 
 	hid->length = length;
@@ -224,7 +187,7 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_integer_to_string(uid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(uid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(uid->string, obj_desc->string.pointer);
 	}
 
 	uid->length = length;
@@ -357,8 +320,8 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 
 			/* Copy the String CID from the returned object */
 
-			acpi_ut_copy_id_string(next_id_string,
-					       cid_objects[i]->string.pointer);
+			ACPI_STRCPY(next_id_string,
+				    cid_objects[i]->string.pointer);
 			length = cid_objects[i]->string.length + 1;
 		}
 

>From 3297ccea5a008bcfa4c18160c7046a2f10c3105f Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:50:47 +0800
Subject: [PATCH 4/6] ACPICA: Add Vista SP2 to supported _OSI strings

Added "Windows 2006 SP2" for Vista SP2.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 ++-
 drivers/acpi/acpica/utosi.c   |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 04ce322..1bb18c0 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -908,7 +908,8 @@ struct acpi_bit_register_info {
 #define ACPI_OSI_WIN_VISTA              0x07
 #define ACPI_OSI_WINSRV_2008            0x08
 #define ACPI_OSI_WIN_VISTA_SP1          0x09
-#define ACPI_OSI_WIN_7                  0x0A
+#define ACPI_OSI_WIN_VISTA_SP2          0x0A
+#define ACPI_OSI_WIN_7                  0x0B
 
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 0a37950..18c59a8 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -71,6 +71,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2006", NULL, 0, ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
 	{"Windows 2006.1", NULL, 0, ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
 	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 
 	/* Feature Group Strings */

>From 5b066690876734ac141b4ba59bd3fa37d16994e1 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 18 Oct 2010 09:38:36 +0800
Subject: [PATCH 5/6] ACPICA: Clear PCIEXP_WAKE_STS when clearing ACPI events

When clearing status bits via acpi_hw_clear_acpi_status, also clear
the PCIEXP_WAKE_STS bit. Original change from Colin King.
ACPICA BZ 880.

http://www.acpica.org/bugzilla/show_bug.cgi?id=880
http://bugs.launchpad.net/bugs/613381

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1bb18c0..8acf1e8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -854,6 +854,7 @@ struct acpi_bit_register_info {
 	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
 	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
 	ACPI_BITMASK_RT_CLOCK_STATUS       | \
+	ACPI_BITMASK_PCIEXP_WAKE_STATUS    | \
 	ACPI_BITMASK_WAKE_STATUS)
 
 #define ACPI_BITMASK_TIMER_ENABLE               0x0001

>From 6dcc7146c181c1551c3a08979cd5defbf1251d0d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 09:10:58 +0800
Subject: [PATCH 6/6] ACPICA: Update version to 20101013

Version 20101013.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c6bc604..12fe979 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100915
+#define ACPI_CA_VERSION                 0x20101013
 
 #include "actypes.h"
 #include "actbl.h"


--=-WZkrbbyvM3S1D0QSHdrz
Content-Type: application/mbox; name="acpica-v20101013-on_top_of_test_branch.mbox"
Content-Disposition: attachment; filename="acpica-v20101013-on_top_of_test_branch.mbox"
Content-Transfer-Encoding: 7bit

>From 63af5fa7aa3e0659c0ae2123124d22dbd166a5bf Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:43:13 +0800
Subject: [PATCH 1/6] ACPICA: Comment update; no functional change

Add a usage note to InstallAddressSpaceHandler.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/evxfregn.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 541cbc1..ce9314f 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -64,6 +64,12 @@ ACPI_MODULE_NAME("evxfregn")
  *
  * DESCRIPTION: Install a handler for all op_regions of a given space_id.
  *
+ * NOTE: This function should only be called after acpi_enable_subsystem has
+ * been called. This is because any _REG methods associated with the Space ID
+ * are executed here, and these methods can only be safely executed after
+ * the default handlers have been installed and the hardware has been
+ * initialized (via acpi_enable_subsystem.)
+ *
  ******************************************************************************/
 acpi_status
 acpi_install_address_space_handler(acpi_handle device,

>From a6be79c47967be7196e3273a2141696973c8043a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:44:34 +0800
Subject: [PATCH 2/6] ACPICA: Change type of _TZ from ThermalZone to Device

The type of ThermalZone was confusing hosts as they process the
various ThermalZone objects. ACPICA BZ 876.

http://www.acpica.org/bugzilla/show_bug.cgi?id=876

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utglobal.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 3c1ce46..e87bc67 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -154,14 +154,16 @@ ACPI_EXPORT_SYMBOL(acpi_format_exception)
  * 1) _SB_ is defined to be a device to allow \_SB_._INI to be run
  *    during the initialization sequence.
  * 2) _TZ_ is defined to be a thermal zone in order to allow ASL code to
- *    perform a Notify() operation on it.
+ *    perform a Notify() operation on it. 09/2010: Changed to type Device.
+ *    This still allows notifies, but does not confuse host code that
+ *    searches for valid thermal_zone objects.
  */
 const struct acpi_predefined_names acpi_gbl_pre_defined_names[] = {
 	{"_GPE", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_PR_", ACPI_TYPE_LOCAL_SCOPE, NULL},
 	{"_SB_", ACPI_TYPE_DEVICE, NULL},
 	{"_SI_", ACPI_TYPE_LOCAL_SCOPE, NULL},
-	{"_TZ_", ACPI_TYPE_THERMAL, NULL},
+	{"_TZ_", ACPI_TYPE_DEVICE, NULL},
 	{"_REV", ACPI_TYPE_INTEGER, (char *)ACPI_CA_SUPPORT_LEVEL},
 	{"_OS_", ACPI_TYPE_STRING, ACPI_OS_NAME},
 	{"_GL_", ACPI_TYPE_MUTEX, (char *)1},

>From f1f876621c6f56317ca6df456fdaa714f6542d06 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:47:16 +0800
Subject: [PATCH 3/6] ACPICA: Eliminate duplicate code in acpi_ut_execute_* functions

Now that the nsrepair code automatically repairs _HID-related
strings, this type of code is no longer needed in acpi_ut_execute_HID,
acpi_ut_execute_CID, and acpi_ut_execute_UID. ACPICA BZ 878.

http://www.acpica.org/bugzilla/show_bug.cgi?id=878

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/utids.c |   45 +++---------------------------------------
 1 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index 1397fad..d290632 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -48,42 +48,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("utids")
 
-/* Local prototypes */
-static void acpi_ut_copy_id_string(char *destination, char *source);
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_copy_id_string
- *
- * PARAMETERS:  Destination         - Where to copy the string
- *              Source              - Source string
- *
- * RETURN:      None
- *
- * DESCRIPTION: Copies an ID string for the _HID, _CID, and _UID methods.
- *              Performs removal of a leading asterisk if present -- workaround
- *              for a known issue on a bunch of machines.
- *
- ******************************************************************************/
-
-static void acpi_ut_copy_id_string(char *destination, char *source)
-{
-
-	/*
-	 * Workaround for ID strings that have a leading asterisk. This construct
-	 * is not allowed by the ACPI specification  (ID strings must be
-	 * alphanumeric), but enough existing machines have this embedded in their
-	 * ID strings that the following code is useful.
-	 */
-	if (*source == '*') {
-		source++;
-	}
-
-	/* Do the actual copy */
-
-	ACPI_STRCPY(destination, source);
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_execute_HID
@@ -101,7 +65,6 @@ static void acpi_ut_copy_id_string(char *destination, char *source)
  *              NOTE: Internal function, no parameter validation
  *
  ******************************************************************************/
-
 acpi_status
 acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 		    struct acpica_device_id **return_id)
@@ -147,7 +110,7 @@ acpi_ut_execute_HID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_eisa_id_to_string(hid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(hid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(hid->string, obj_desc->string.pointer);
 	}
 
 	hid->length = length;
@@ -224,7 +187,7 @@ acpi_ut_execute_UID(struct acpi_namespace_node *device_node,
 	if (obj_desc->common.type == ACPI_TYPE_INTEGER) {
 		acpi_ex_integer_to_string(uid->string, obj_desc->integer.value);
 	} else {
-		acpi_ut_copy_id_string(uid->string, obj_desc->string.pointer);
+		ACPI_STRCPY(uid->string, obj_desc->string.pointer);
 	}
 
 	uid->length = length;
@@ -357,8 +320,8 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 
 			/* Copy the String CID from the returned object */
 
-			acpi_ut_copy_id_string(next_id_string,
-					       cid_objects[i]->string.pointer);
+			ACPI_STRCPY(next_id_string,
+				    cid_objects[i]->string.pointer);
 			length = cid_objects[i]->string.length + 1;
 		}
 

>From 3d1be248097867572ac0b081ea8ab63f567590ef Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 08:50:47 +0800
Subject: [PATCH 4/6] ACPICA: Add Vista SP2 to supported _OSI strings

Added "Windows 2006 SP2" for Vista SP2.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 ++-
 drivers/acpi/acpica/utosi.c   |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index a77414f..be2f4b8 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -910,7 +910,8 @@ struct acpi_bit_register_info {
 #define ACPI_OSI_WIN_VISTA              0x07
 #define ACPI_OSI_WINSRV_2008            0x08
 #define ACPI_OSI_WIN_VISTA_SP1          0x09
-#define ACPI_OSI_WIN_7                  0x0A
+#define ACPI_OSI_WIN_VISTA_SP2          0x0A
+#define ACPI_OSI_WIN_7                  0x0B
 
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
index 0a37950..18c59a8 100644
--- a/drivers/acpi/acpica/utosi.c
+++ b/drivers/acpi/acpica/utosi.c
@@ -71,6 +71,7 @@ static struct acpi_interface_info acpi_default_supported_interfaces[] = {
 	{"Windows 2006", NULL, 0, ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
 	{"Windows 2006.1", NULL, 0, ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
 	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},	/* Windows Vista SP2 - Added 09/2010 */
 	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 
 	/* Feature Group Strings */

>From 8893d6cf57009bf98b08791c0ee8ddf04456d12d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 09:02:55 +0800
Subject: [PATCH 5/6] ACPICA: Clear PCIEXP_WAKE_STS when clearing ACPI events

When clearing status bits via acpi_hw_clear_acpi_status, also clear
the PCIEXP_WAKE_STS bit. Original change from Colin King.
The name used in the macro should be ACPI_BITMASK_PCIEXP_WAKE_STATUS.
ACPICA BZ 880.

http://www.acpica.org/bugzilla/show_bug.cgi?id=880

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index be2f4b8..2ceb0c0 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -855,7 +855,7 @@ struct acpi_bit_register_info {
 	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
 	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
 	ACPI_BITMASK_RT_CLOCK_STATUS       | \
-	ACPI_BITMASK_PCIEXP_WAKE_DISABLE   | \
+	ACPI_BITMASK_PCIEXP_WAKE_STATUS    | \
 	ACPI_BITMASK_WAKE_STATUS)
 
 #define ACPI_BITMASK_TIMER_ENABLE               0x0001

>From 6a3161038db7f9bc443f6032fcee3316f4007069 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 18 Oct 2010 09:10:58 +0800
Subject: [PATCH 6/6] ACPICA: Update version to 20101013

Version 20101013.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 041a63d..53b7cfd 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100915
+#define ACPI_CA_VERSION                 0x20101013
 
 #include "actypes.h"
 #include "actbl.h"


--=-WZkrbbyvM3S1D0QSHdrz--

