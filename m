From: Len Brown <lenb@kernel.org>
Subject: [PATCH 104/140] ACPICA: Update debug output routines for data structure changes
Date: Wed,  7 Feb 2007 13:51:58 -0500
Message-ID: <11708745193612-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <77f6a9fca39f4f19d2d9d5fff1ff5c2ccf20629c.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:24742 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422816AbXBGSz1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:27 -0500
In-Reply-To: <1170874518616-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exdump.c |   27 +++++----------------------
 1 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/executer/exdump.c b/drivers/acpi/executer/exdump.c
index 2450943..c9cab16 100644
--- a/drivers/acpi/executer/exdump.c
+++ b/drivers/acpi/executer/exdump.c
@@ -59,8 +59,6 @@ static void acpi_ex_out_string(char *title, char *value);
 
 static void acpi_ex_out_pointer(char *title, void *value);
 
-static void acpi_ex_out_address(char *title, acpi_physical_address value);
-
 static void
 acpi_ex_dump_object(union acpi_operand_object *obj_desc,
 		    struct acpi_exdump_info *info);
@@ -92,10 +90,11 @@ static struct acpi_exdump_info acpi_ex_dump_string[4] = {
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
 
@@ -165,8 +164,8 @@ static struct acpi_exdump_info acpi_ex_dump_power[5] = {
 
 static struct acpi_exdump_info acpi_ex_dump_processor[7] = {
 	{ACPI_EXD_INIT, ACPI_EXD_TABLE_SIZE(acpi_ex_dump_processor), NULL},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(processor.proc_id), "Processor ID"},
-	{ACPI_EXD_UINT32, ACPI_EXD_OFFSET(processor.length), "Length"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(processor.proc_id), "Processor ID"},
+	{ACPI_EXD_UINT8, ACPI_EXD_OFFSET(processor.length), "Length"},
 	{ACPI_EXD_ADDRESS, ACPI_EXD_OFFSET(processor.address), "Address"},
 	{ACPI_EXD_POINTER, ACPI_EXD_OFFSET(processor.system_notify),
 	 "System Notify"},
@@ -379,18 +378,12 @@ acpi_ex_dump_object(union acpi_operand_object *obj_desc,
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
@@ -834,16 +827,6 @@ static void acpi_ex_out_pointer(char *title, void *value)
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
1.5.0.rc3.39.gec804
