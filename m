From: Len Brown <lenb@kernel.org>
Subject: [PATCH 35/37] ACPI: suppress uninitialized var warning
Date: Wed, 10 Oct 2007 01:06:42 -0400
Message-ID: <1191992804-14965-36-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:19103 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751136AbXJJFHN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:07:13 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <8ab7367f483d1d676d61fca58498a73b194dda82.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@linux-foundation.org>

drivers/acpi/tables/tbutils.c: In function `acpi_tb_parse_root_table':
drivers/acpi/tables/tbutils.c:403: warning: `rsdt_address' may be used uninitialized in this function

Reported-by: Uwe Bugla <uwe.bugla@gmx.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/tables/tbutils.c b/drivers/acpi/tables/tbutils.c
index 8cc9492..5f1d85f 100644
--- a/drivers/acpi/tables/tbutils.c
+++ b/drivers/acpi/tables/tbutils.c
@@ -400,7 +400,7 @@ acpi_tb_parse_root_table(acpi_physical_address rsdp_address, u8 flags)
 	u32 table_count;
 	struct acpi_table_header *table;
 	acpi_physical_address address;
-	acpi_physical_address rsdt_address;
+	acpi_physical_address uninitialized_var(rsdt_address);
 	u32 length;
 	u8 *table_entry;
 	acpi_status status;
-- 
1.5.3.4.206.g58ba4
