From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20090903 linuxized patches
Date: Fri, 04 Sep 2009 09:05:30 +0800
Message-ID: <1252026330.3565.3.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-B4X/sbLNl2UPU/MqjHtP"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44762 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbZIDBJ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Sep 2009 21:09:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-B4X/sbLNl2UPU/MqjHtP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached.

Applied cleanly on top of linux-acpi-2.6/test branch.
Build & Test on 32 & 64 bit machines.

Lin Ming
---
[PATCH 1/6] ACPICA: Fix extraneous warning if _DSM returns a package
[PATCH 2/6] ACPICA: Remove error message for Store(Localx,Localx)
[PATCH 3/6] ACPICA: Fix memory leak for ill-formed Package objects
[PATCH 4/6] ACPICA: Update _OSI with new Windows OS strings
[PATCH 5/6] ACPICA: Windows compatibility: autoexecute root _INI method
[PATCH 6/6] ACPICA: Update version to 20090903.

--=-B4X/sbLNl2UPU/MqjHtP
Content-Disposition: attachment; filename="acpica-v20090903.patch"
Content-Type: text/x-patch; name="acpica-v20090903.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 7f646eda8ad9c53589a0379f061cb0448f5fa6db Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 3 Sep 2009 09:55:40 +0800
Subject: [PATCH 1/6] ACPICA: Fix extraneous warning if _DSM returns a package

_DSM can return any type of object, so validation on the return
type cannot be performed. ACPICA BZ 802.

http://www.acpica.org/bugzilla/show_bug.cgi?id=802

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nspredef.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 8314e6a..f8427af 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -193,11 +193,15 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
 	/*
-	 * We have a return value, but if one wasn't expected, just exit, this is
+	 * 1) We have a return value, but if one wasn't expected, just exit, this is
 	 * not a problem. For example, if the "Implicit Return" feature is
 	 * enabled, methods will always return a value.
+	 *
+	 * 2) If the return value can be of any type, then we cannot perform any
+	 * validation, exit.
 	 */
-	if (!predefined->info.expected_btypes) {
+	if ((!predefined->info.expected_btypes) ||
+	    (predefined->info.expected_btypes == ACPI_RTYPE_ALL)) {
 		goto cleanup;
 	}
 

>From 9e64aa6b0869bbe91bfb0162ef1ad55a2b4e31ef Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 3 Sep 2009 09:58:14 +0800
Subject: [PATCH 2/6] ACPICA: Remove error message for Store(Localx,Localx)

We silently ignore this construct for Windows compatibility
ACPICA BZ 785.

http://www.acpica.org/bugzilla/show_bug.cgi?id=785

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsmthdat.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/dsmthdat.c b/drivers/acpi/acpica/dsmthdat.c
index 22b1a3c..7d077bb 100644
--- a/drivers/acpi/acpica/dsmthdat.c
+++ b/drivers/acpi/acpica/dsmthdat.c
@@ -433,10 +433,10 @@ acpi_ds_method_data_get_value(u8 type,
 
 			case ACPI_REFCLASS_LOCAL:
 
-				ACPI_ERROR((AE_INFO,
-					    "Uninitialized Local[%d] at node %p",
-					    index, node));
-
+				/*
+				 * No error message for this case, will be trapped again later to
+				 * detect and ignore cases of Store(local_x,local_x)
+				 */
 				return_ACPI_STATUS(AE_AML_UNINITIALIZED_LOCAL);
 
 			default:

>From bab98bb52ac90d722f8615c4e1bf0242160f2b2a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 3 Sep 2009 10:03:37 +0800
Subject: [PATCH 3/6] ACPICA: Fix memory leak for ill-formed Package objects

Fixes a possible memory leak in the interpreter for package
objects if the package initializer list is longer than the
defined size of the package. This apparently can only happen
if the BIOS changes the package size on the fly (seen in a _PSS
object), as both iASL and the other compiler do not allow this.
The interpreter will truncate the package to the defined size
(and issue an error message), but can leave the extra objects
undeleted if they have been pre-created during the argument
processing (such is the case if the package consists of a number
of sub-packages as in the _PSS.) ACPICA BZ 805.

http://www.acpica.org/bugzilla/show_bug.cgi?id=805

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsobject.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 02e6caa..507e1f0 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -482,14 +482,27 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 	if (arg) {
 		/*
 		 * num_elements was exhausted, but there are remaining elements in the
-		 * package_list.
+		 * package_list. Truncate the package to num_elements.
 		 *
 		 * Note: technically, this is an error, from ACPI spec: "It is an error
 		 * for NumElements to be less than the number of elements in the
-		 * PackageList". However, for now, we just print an error message and
-		 * no exception is returned.
+		 * PackageList". However, we just print an error message and
+		 * no exception is returned. This provides Windows compatibility. Some
+		 * BIOSs will alter the num_elements on the fly, creating this type
+		 * of ill-formed package object.
 		 */
 		while (arg) {
+			/*
+			 * We must delete any package elements that were created earlier
+			 * and are not going to be used because of the package truncation.
+			 */
+			if (arg->common.node) {
+				acpi_ut_remove_reference(ACPI_CAST_PTR
+							 (union
+							  acpi_operand_object,
+							  arg->common.node));
+				arg->common.node = NULL;
+			}
 
 			/* Find out how many elements there really are */
 
@@ -498,7 +511,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		}
 
 		ACPI_WARNING((AE_INFO,
-			    "Package List length (%X) larger than NumElements count (%X), truncated\n",
+			    "Package List length (0x%X) larger than NumElements count (0x%X), truncated\n",
 			    i, element_count));
 	} else if (i < element_count) {
 		/*
@@ -506,7 +519,7 @@ acpi_ds_build_internal_package_obj(struct acpi_walk_state *walk_state,
 		 * Note: this is not an error, the package is padded out with NULLs.
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Package List length (%X) smaller than NumElements count (%X), padded with null elements\n",
+				  "Package List length (0x%X) smaller than NumElements count (0x%X), padded with null elements\n",
 				  i, element_count));
 	}
 

>From 7319440b9a5b04283b5424699ee16fb3a2f17a8a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 3 Sep 2009 10:05:08 +0800
Subject: [PATCH 4/6] ACPICA: Update _OSI with new Windows OS strings

Added strings for Windows server 2008, Windows Vista SP1,
Windows 7, and Windows server 2008 R2.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    3 +++
 drivers/acpi/acpica/uteval.c  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index ff6689e..81e64f4 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -898,6 +898,9 @@ struct acpi_bit_register_info {
 #define ACPI_OSI_WIN_XP_SP2             0x05
 #define ACPI_OSI_WINSRV_2003_SP1        0x06
 #define ACPI_OSI_WIN_VISTA              0x07
+#define ACPI_OSI_WINSRV_2008            0x08
+#define ACPI_OSI_WIN_VISTA_SP1          0x09
+#define ACPI_OSI_WIN_7                  0x0A
 
 #define ACPI_ALWAYS_ILLEGAL             0x00
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 5503307..5d54e36 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -69,6 +69,9 @@ static struct acpi_interface_info acpi_interfaces_supported[] = {
 	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
 	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
 	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
+	{"Windows 2006.1", ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
+	{"Windows 2006 SP1", ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2009", ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
 
 	/* Feature Group Strings */
 

>From 93825bb02cabfffa9e5683649ac0d13a4463903a Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Thu, 3 Sep 2009 10:21:03 +0800
Subject: [PATCH 5/6] ACPICA: Windows compatibility: autoexecute root _INI method

Add support for execution of an _INI method at the namespace root.
Although not defined in the ACPI specification, this support was
added to Windows around the Vista timeframe. It is added here
for Windows compatibility.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsinit.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 2adfcf3..1d5b360 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -170,6 +170,21 @@ acpi_status acpi_ns_initialize_devices(void)
 		goto error_exit;
 	}
 
+	/*
+	 * Execute the "global" _INI method that may appear at the root. This
+	 * support is provided for Windows compatibility (Vista+) and is not
+	 * part of the ACPI specification.
+	 */
+	info.evaluate_info->prefix_node = acpi_gbl_root_node;
+	info.evaluate_info->pathname = METHOD_NAME__INI;
+	info.evaluate_info->parameters = NULL;
+	info.evaluate_info->flags = ACPI_IGNORE_RETURN_VALUE;
+
+	status = acpi_ns_evaluate(info.evaluate_info);
+	if (ACPI_SUCCESS(status)) {
+		info.num_INI++;
+	}
+
 	/* Walk namespace to execute all _INIs on present devices */
 
 	status = acpi_ns_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,

>From 96aa7e57da4343345416a48a3d0256ed38c08175 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 4 Sep 2009 08:56:17 +0800
Subject: [PATCH 6/6] ACPICA: Update version to 20090903.

Version 20090903.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index f3b358b..e723b0f 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20090730
+#define ACPI_CA_VERSION                 0x20090903
 
 #include "actypes.h"
 #include "actbl.h"


--=-B4X/sbLNl2UPU/MqjHtP--

