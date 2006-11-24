From: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/65] ACPICA: Fix unalignment in acpi_ut_repair_name
Date: Fri, 24 Nov 2006 02:18:30 -0500
Message-ID: <11643527821346-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757627AbWKXHPo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:44 -0500
In-Reply-To: <11643527812144-git-send-email-len.brown@intel.com>
Message-Id: <fca6a1e6bd5f675d123948f9a4ca07defe24fad5.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Update interface to acpi_ut_repair_name() to avoid
alignment issues on IA64

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsdump.c   |    2 +-
 drivers/acpi/namespace/nssearch.c |    3 ++-
 drivers/acpi/utilities/utglobal.c |    2 +-
 drivers/acpi/utilities/utmisc.c   |   11 +++++------
 include/acpi/acutils.h            |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/namespace/nsdump.c b/drivers/acpi/namespace/nsdump.c
index d72df66..da88834 100644
--- a/drivers/acpi/namespace/nsdump.c
+++ b/drivers/acpi/namespace/nsdump.c
@@ -205,7 +205,7 @@ acpi_ns_dump_one_object(acpi_handle obj_
 
 		if (!acpi_ut_valid_acpi_name(this_node->name.integer)) {
 			this_node->name.integer =
-			    acpi_ut_repair_name(this_node->name.integer);
+			    acpi_ut_repair_name(this_node->name.ascii);
 
 			ACPI_WARNING((AE_INFO, "Invalid ACPI Name %08X",
 				      this_node->name.integer));
diff --git a/drivers/acpi/namespace/nssearch.c b/drivers/acpi/namespace/nssearch.c
index 500e2bb..566f0a4 100644
--- a/drivers/acpi/namespace/nssearch.c
+++ b/drivers/acpi/namespace/nssearch.c
@@ -321,7 +321,8 @@ acpi_ns_search_and_enter(u32 target_name
 	 * even though there are a few bad names.
 	 */
 	if (!acpi_ut_valid_acpi_name(target_name)) {
-		target_name = acpi_ut_repair_name(target_name);
+		target_name =
+		    acpi_ut_repair_name(ACPI_CAST_PTR(char, &target_name));
 
 		/* Report warning only if in strict mode or debug mode */
 
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index a524e75..855bc8f 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -566,7 +566,7 @@ char *acpi_ut_get_node_name(void *object
 	/* Name must be a valid ACPI name */
 
 	if (!acpi_ut_valid_acpi_name(node->name.integer)) {
-		node->name.integer = acpi_ut_repair_name(node->name.integer);
+		node->name.integer = acpi_ut_repair_name(node->name.ascii);
 	}
 
 	/* Return the name */
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index 4b03051..36d8815 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -582,26 +582,25 @@ u8 acpi_ut_valid_acpi_name(u32 name)
  *
  ******************************************************************************/
 
-acpi_name acpi_ut_repair_name(acpi_name name)
+acpi_name acpi_ut_repair_name(char *name)
 {
-	char *name_ptr = ACPI_CAST_PTR(char, &name);
-	char new_name[ACPI_NAME_SIZE];
 	acpi_native_uint i;
+	char new_name[ACPI_NAME_SIZE];
 
 	for (i = 0; i < ACPI_NAME_SIZE; i++) {
-		new_name[i] = name_ptr[i];
+		new_name[i] = name[i];
 
 		/*
 		 * Replace a bad character with something printable, yet technically
 		 * still invalid. This prevents any collisions with existing "good"
 		 * names in the namespace.
 		 */
-		if (!acpi_ut_valid_acpi_char(name_ptr[i], i)) {
+		if (!acpi_ut_valid_acpi_char(name[i], i)) {
 			new_name[i] = '*';
 		}
 	}
 
-	return (*ACPI_CAST_PTR(u32, new_name));
+	return (*(u32 *) new_name);
 }
 
 /*******************************************************************************
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index ba039ea..beb07ac 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -470,7 +470,7 @@ void acpi_ut_print_string(char *string,
 
 u8 acpi_ut_valid_acpi_name(u32 name);
 
-acpi_name acpi_ut_repair_name(acpi_name name);
+acpi_name acpi_ut_repair_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, acpi_native_uint position);
 
-- 
1.4.4.1
