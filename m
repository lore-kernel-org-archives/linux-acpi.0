From: Len Brown <lenb@kernel.org>
Subject: [PATCH 61/140] ACPICA: Fix unalignment in acpi_ut_repair_name
Date: Wed,  7 Feb 2007 13:51:15 -0500
Message-ID: <11708744612314-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:33960 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422788AbXBGSyb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:54:31 -0500
In-Reply-To: <11708744603317-git-send-email-lenb@kernel.org>
Message-Id: <3d81b236a82a26fa8bdef9096829675d81890dc9.1170873817.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

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
@@ -205,7 +205,7 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 
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
@@ -321,7 +321,8 @@ acpi_ns_search_and_enter(u32 target_name,
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
@@ -566,7 +566,7 @@ char *acpi_ut_get_node_name(void *object)
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
@@ -470,7 +470,7 @@ void acpi_ut_print_string(char *string, u8 max_length);
 
 u8 acpi_ut_valid_acpi_name(u32 name);
 
-acpi_name acpi_ut_repair_name(acpi_name name);
+acpi_name acpi_ut_repair_name(char *name);
 
 u8 acpi_ut_valid_acpi_char(char character, acpi_native_uint position);
 
-- 
1.5.0.rc3.39.gec804
