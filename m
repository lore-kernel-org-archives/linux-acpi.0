From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/12] ACPI: Fix a duplicate log level
Date: Tue, 11 Mar 2008 02:51:48 -0400
Message-ID: <bd12935f04066df31903eaf74b1cec03319ecd2e.1205217406.git.len.brown@intel.com>
References: <1205218309-19695-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:14880 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754348AbYCKGy4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 02:54:56 -0400
In-Reply-To: <1205218309-19695-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
References: <b95e9e8d94484c2823be67416f25e9756db149dc.1205217406.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>

From: Jean Delvare <khali@linux-fr.org>

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8edba7b..065819b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1237,7 +1237,7 @@ int acpi_check_resource_conflict(struct resource *res)
 
 	if (clash) {
 		if (acpi_enforce_resources != ENFORCE_RESOURCES_NO) {
-			printk(KERN_INFO "%sACPI: %s resource %s [0x%llx-0x%llx]"
+			printk("%sACPI: %s resource %s [0x%llx-0x%llx]"
 			       " conflicts with ACPI region %s"
 			       " [0x%llx-0x%llx]\n",
 			       acpi_enforce_resources == ENFORCE_RESOURCES_LAX
-- 
1.5.4.3.422.g34cd6

