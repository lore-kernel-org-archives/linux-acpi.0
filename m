From: Alistair John Strachan <alistair@devzero.co.uk>
Subject: [PATCH] ACPI 2.6.26-rc2: Add missing newline to DSDT/SSDT warning message
Date: Mon, 12 May 2008 19:13:09 +0100
Message-ID: <200805121913.09502.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757083AbYELSNZ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

As of recently (probably 2.6.26-rc1) I've been getting the following mangling
in the kernel log:

[4294014.568167] ACPI: DSDT override uses original SSDTs unless "acpi_no_auto_ssdt"<6>CPU0: Intel(R) Pentium(R) Dual  CPU  E2160  @ 1.80GHz stepping 0d

This is due to a missing newline character in the first message. The following
patch against 2.6.26-rc2 fixes it. Please apply.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
---

diff --git a/drivers/acpi/tables/tbxface.c b/drivers/acpi/tables/tbxface.c
index fb57b93..0e31960 100644
--- a/drivers/acpi/tables/tbxface.c
+++ b/drivers/acpi/tables/tbxface.c
@@ -540,7 +540,7 @@ static acpi_status acpi_tb_load_namespace(void)
 		acpi_tb_print_table_header(0, table);
 
 		if (no_auto_ssdt == 0) {
-			printk(KERN_WARNING "ACPI: DSDT override uses original SSDTs unless \"acpi_no_auto_ssdt\"");
+			printk(KERN_WARNING "ACPI: DSDT override uses original SSDTs unless \"acpi_no_auto_ssdt\"\n");
 		}
 	}
 
-- 
Cheers,
Alistair.

137/1 Warrender Park Road, Edinburgh, UK.
