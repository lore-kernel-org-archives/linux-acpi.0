From: Len Brown <len.brown@intel.com>
Subject: [PATCH 58/65] ACPICA: Update debug output routines for data structure changes
Date: Fri, 24 Nov 2006 02:19:08 -0500
Message-ID: <11643528181927-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com> <11643528161204-git-send-email-len.brown@intel.com> <11643528173586-git-send-email-len.brown@intel.com> <11643528181135-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58137 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934505AbWKXHQU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:20 -0500
In-Reply-To: <11643528181135-git-send-email-len.brown@intel.com>
Message-Id: <23eb8b53020362239d0127b6751fbc5156782240.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c |   27 +++++----------------------
 1 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 2450943..c9cab16 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -59,8 +59,6 @@ static void acpi_ex_out_string(char *tit
 
 static void acpi_ex_out_pointer(char *title, void *value);
 
-static void acpi_ex_out_address(char *title, acpi_physical_address value);
-
 static void
 acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 		    struct acpi_exdump_info *info);
@@ -92,10 +90,11 @@ static struct acpi_exdump_info acpi_ex_d
 	{ACPI_EXD_STRING, 0, NULL}
 };
 
-static struct acpi_exdump_info acpi_ex_dump_buffer[4] = {
+static struct acpi_exdump_info acpi_ex_dump_buffer[5] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_buffer), NULL},
 	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(buffer.length), "Length"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(buffer.pointer), "Pointer"},
+	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(buffer.node), "Parent Node"},
 	{ACPI_EXD_BUFFER, 0, NULL}
 };
 
@@ -165,8 +164,8 @@ static struct acpi_exdump_info acpi_ex_d
 
 static struct acpi_exdump_info acpi_ex_dump_processor[7] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_processor), NULL},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(processor.proc_id), "Processor ID"},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(processor.length), "Length"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(processor.proc_id), "Processor ID"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(processor.length), "Length"},
 	{ACPI_EXD_ADDRESS, ACPI_EXD_OFFSET(processor.address), "Address"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(processor.system_notify),
 	 "System Notify"},
@@ -379,18 +378,12 @@ acpi_ex_dump_object(union acpi_operand_o
 			break;
 
 		case ACPI_EXD_POINTER:
+		case ACPI_EXD_ADDRESS:
 
 			acpi_ex_out_pointer(name,
 					    *ACPI_CAST_PTR(void *, target));
 			break;
 
-		case ACPI_EXD_ADDRESS:
-
-			acpi_ex_out_address(name,
-					    *ACPI_CAST_PTR
-					    (acpi_physical_address, target));
-			break;
-
 		case ACPI_EXD_STRING:
 
 			acpi_ut_print_string(obj_desc->string.pointer,
@@ -834,16 +827,6 @@ static void acpi_ex_out_pointer(char *ti
 	acpi_os_printf("%20s : %p\n", title, value);
 }
 
-static void acpi_ex_out_address(char *title, acpi_physical_address value)
-{
-
-#if ACPI_MACHINE_WIDTH == 16
-	acpi_os_printf("%20s : %p\n", title, value);
-#else
-	acpi_os_printf("%20s : %8.8X%8.8X\n", title, ACPI_FORMAT_UINT64(value));
-#endif
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_dump_namespace_node
-- 
1.4.4.1
