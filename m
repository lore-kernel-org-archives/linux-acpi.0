From: Len Brown <len.brown@intel.com>
Subject: [PATCH 5/9] ACPI: parse 2nd MADT by default
Date: Tue, 20 Mar 2007 11:27:07 -0400
Message-ID: <11744044351759-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com> <11744044341614-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34190 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933820AbXCTP1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:33 -0400
In-Reply-To: <11744044341614-git-send-email-len.brown@intel.com>
Message-Id: <09fe58356d148ff66901ddf639e725ca1a48a0af.1174404137.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

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
index c341918..96792a6 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -42,7 +42,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance __initdata = 2;
 
 void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 {
-- 
1.5.0.3.382.g34572
