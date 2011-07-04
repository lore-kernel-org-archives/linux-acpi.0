From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20110623 linuxized patches
Date: Mon, 04 Jul 2011 16:51:44 +0800
Message-ID: <1309769504.18875.91.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-taE2F9iXtb0Wv2EcbZv4"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31718 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab1GDIqA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Jul 2011 04:46:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-taE2F9iXtb0Wv2EcbZv4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Len

The linuxized patches for ACPICA release 20110623 attached.

[PATCH 1/3] ACPICA: Add option to disable method return value validation
[PATCH 2/3] ACPICA: Do not repair _TSS return package if _PSS is present
[PATCH 3/3] ACPICA: Update to version 20110623

And would you please also apply the release 20110527 linuxized patches?
http://marc.info/?l=linux-acpi&m=130802022413556&w=2

Thanks,
Lin Ming

--=-taE2F9iXtb0Wv2EcbZv4
Content-Disposition: attachment; filename="acpica-v20110623.patch"
Content-Type: text/x-patch; name="acpica-v20110623.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 13795b46b878be5a7186b415fb0fc0524b4d9b7e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 4 Jul 2011 08:24:03 +0000
Subject: [PATCH 1/3] ACPICA: Add option to disable method return value validation
 and repair

Runtime option can be used to disable return value repair if this
is causing a problem on a particular machine.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    6 ++++++
 drivers/acpi/acpica/nspredef.c |   18 ++++++++++++------
 include/acpi/acpixf.h          |    1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 73863d8..76dc02f 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -126,6 +126,12 @@ u8 ACPI_INIT_GLOBAL(acpi_gbl_copy_dsdt_locally, FALSE);
  */
 u8 ACPI_INIT_GLOBAL(acpi_gbl_truncate_io_addresses, FALSE);
 
+/*
+ * Disable runtime checking and repair of values returned by control methods.
+ * Use only if the repair is causing a problem on a particular machine.
+ */
+u8 ACPI_INIT_GLOBAL(acpi_gbl_disable_auto_repair, FALSE);
+
 /* acpi_gbl_FADT is a local copy of the FADT, converted to a common format. */
 
 struct acpi_table_fadt acpi_gbl_FADT;
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 9fb03fa..607a9a0 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -193,14 +193,20 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
 	/*
-	 * 1) We have a return value, but if one wasn't expected, just exit, this is
-	 * not a problem. For example, if the "Implicit Return" feature is
-	 * enabled, methods will always return a value.
+	 * Return value validation and possible repair.
 	 *
-	 * 2) If the return value can be of any type, then we cannot perform any
-	 * validation, exit.
+	 * 1) Don't perform return value validation/repair if this feature
+	 * has been disabled via a global option.
+	 *
+	 * 2) We have a return value, but if one wasn't expected, just exit,
+	 * this is not a problem. For example, if the "Implicit Return"
+	 * feature is enabled, methods will always return a value.
+	 *
+	 * 3) If the return value can be of any type, then we cannot perform
+	 * any validation, just exit.
 	 */
-	if ((!predefined->info.expected_btypes) ||
+	if (acpi_gbl_disable_auto_repair ||
+	    (!predefined->info.expected_btypes) ||
 	    (predefined->info.expected_btypes == ACPI_RTYPE_ALL)) {
 		goto cleanup;
 	}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 06853f7..d42d7ce 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -69,6 +69,7 @@ extern u32 acpi_gbl_trace_flags;
 extern u32 acpi_gbl_enable_aml_debug_object;
 extern u8 acpi_gbl_copy_dsdt_locally;
 extern u8 acpi_gbl_truncate_io_addresses;
+extern u8 acpi_gbl_disable_auto_repair;
 
 extern u32 acpi_current_gpe_count;
 extern struct acpi_table_fadt acpi_gbl_FADT;

>From f3725b72cf480d149988dd2e42c166727433bc32 Mon Sep 17 00:00:00 2001
From: Fenghua Yu <fenghua.yu@intel.com>
Date: Mon, 4 Jul 2011 08:36:16 +0000
Subject: [PATCH 2/3] ACPICA: Do not repair _TSS return package if _PSS is present

We can only sort the _TSS return package if there is no _PSS
in the same scope. This is because if _PSS is present, the ACPI
specification dictates that the _TSS Power Dissipation field is
to be ignored, and therefore some BIOSs leave garbage values in
the _TSS Power field(s).  In this case, it is best to just return
the _TSS package as-is.

Reported-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/aclocal.h   |    1 +
 drivers/acpi/acpica/nspredef.c  |    1 +
 drivers/acpi/acpica/nsrepair2.c |   15 +++++++++++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index c7f743c..5552125 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -357,6 +357,7 @@ struct acpi_predefined_data {
 	char *pathname;
 	const union acpi_predefined_info *predefined;
 	union acpi_operand_object *parent_package;
+	struct acpi_namespace_node *node;
 	u32 flags;
 	u8 node_flags;
 };
diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index 607a9a0..c845c80 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -218,6 +218,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 		goto cleanup;
 	}
 	data->predefined = predefined;
+	data->node = node;
 	data->node_flags = node->flags;
 	data->pathname = pathname;
 
diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 973883b..024c4f2 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -503,6 +503,21 @@ acpi_ns_repair_TSS(struct acpi_predefined_data *data,
 {
 	union acpi_operand_object *return_object = *return_object_ptr;
 	acpi_status status;
+	struct acpi_namespace_node *node;
+
+	/*
+	 * We can only sort the _TSS return package if there is no _PSS in the
+	 * same scope. This is because if _PSS is present, the ACPI specification
+	 * dictates that the _TSS Power Dissipation field is to be ignored, and
+	 * therefore some BIOSs leave garbage values in the _TSS Power field(s).
+	 * In this case, it is best to just return the _TSS package as-is.
+	 * (May, 2011)
+	 */
+	status =
+	    acpi_ns_get_node(data->node, "^_PSS", ACPI_NS_NO_UPSEARCH, &node);
+	if (ACPI_SUCCESS(status)) {
+		return (AE_OK);
+	}
 
 	status = acpi_ns_check_sorted_list(data, return_object, 5, 1,
 					   ACPI_SORT_DESCENDING,

>From 2764edd174a99e8acb8120aa226432537bf58d24 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Mon, 4 Jul 2011 08:38:51 +0000
Subject: [PATCH 3/3] ACPICA: Update to version 20110623

Version 20110623.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index d42d7ce..f554a93 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20110527
+#define ACPI_CA_VERSION                 0x20110623
 
 #include "actypes.h"
 #include "actbl.h"


--=-taE2F9iXtb0Wv2EcbZv4--

