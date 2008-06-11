From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/23] ACPI 2.6.26-rc2: Add missing newline to DSDT/SSDT
 warning message
Date: Wed, 11 Jun 2008 03:59:10 -0400
Message-ID: <78813ca35846b8ac1dc76d09e1ba2da5a65d7794.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:57809 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbYFKH7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A00KUBGV7ESV2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:32 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alistair John Strachan <alistair@devzero.co.uk>, Len Brown <len.brown@intel.com>

From: Alistair John Strachan <alistair@devzero.co.uk>

As of recently (probably 2.6.26-rc1) I've been getting the following mangling
in the kernel log:

[4294014.568167] ACPI: DSDT override uses original SSDTs unless "acpi_no_auto_ssdt"<6>CPU0: Intel(R) Pentium(R) Dual  CPU  E2160  @ 1.80GHz stepping 0d

This is due to a missing newline character in the first message. The following
patch against 2.6.26-rc2 fixes it. Please apply.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbxface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.5.6.rc2.23.gea81e

