From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/27] ACPICA: Add option to disable method return value
 validation and repair
Date: Tue, 02 Aug 2011 16:53:06 -0400
Message-ID: <d57b23ad0ca7a46931e4d98eb6b4b73b112f0969.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:49219 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab1HBUx6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:53:58 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB005UMJDHO7H3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:53:47 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Runtime option can be used to disable return value repair if this
is causing a problem on a particular machine.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
-- 
1.7.6.396.ge0613

