From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v5 1/2] ACPI / APEI / BERT: Don't clear "block_status" in header
Date: Wed, 21 Jun 2017 10:20:41 -0700
Message-ID: <7a8220935e24693a45137f3fea20b48c6ea47b46.1498065055.git.tony.luck@intel.com>
References: <20170619155854.gtcowx3cityb3gqt@pd.tnic>
 <cover.1498065055.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34723 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752948AbdFURVO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Jun 2017 13:21:14 -0400
In-Reply-To: <cover.1498065055.git.tony.luck@intel.com>
In-Reply-To: <cover.1498065055.git.tony.luck@intel.com>
References: <cover.1498065055.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Although the ACPI specification says this is a "one time polled" error
source, it makes no mention that the OS should stomp on fields in the
error status block to enforce this.

There are user mode BERT harvesting tools that dig into
/sys/firmware/acpi/tables/BERT which might like to see this summary value.

Drop the:
	estatus->block_status = 0;

Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/bert.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 12771fcf0417..9197555dc3c7 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -62,13 +62,6 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 
 		cper_estatus_print(KERN_INFO HW_ERR, estatus);
 
-		/*
-		 * Because the boot error source is "one-time polled" type,
-		 * clear Block Status of current Generic Error Status Block,
-		 * once it's printed.
-		 */
-		estatus->block_status = 0;
-
 		estatus = (void *)estatus + estatus_len;
 		/* No more error records. */
 		if (!estatus->block_status)
-- 
2.11.0

