From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: parse 2nd MADT by default
Date: Sun, 11 Mar 2007 21:24:21 -0400
Message-ID: <1173662663486-git-send-email-lenb@kernel.org>
References: <11736626612135-git-send-email-lenb@kernel.org> <11736626621682-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:40297 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751034AbXCLBYb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Mar 2007 21:24:31 -0400
In-Reply-To: <11736626621682-git-send-email-lenb@kernel.org>
Message-Id: <60367f94b0f1c6678e559191af6b0c6aab8ce4e6.1173661284.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1173661284.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1173661284.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7465

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    2 +-
 drivers/acpi/tables.c               |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22c6b8c..f0b7a5e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -142,7 +142,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			Format: <int>
 			2: use 2nd APIC table, if available
 			1,0: use 1st APIC table
-			default: 0
+			default: 2
 
 	acpi_sleep=	[HW,ACPI] Sleep options
 			Format: { s3_bios, s3_mode }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index c341918..6d5515a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -42,7 +42,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance = 2; __initdata;
 
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
-- 
1.5.0.3.316.gbd1fc
