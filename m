From: Len Brown <len.brown@intel.com>
Subject: [PATCH 08/12] ACPI: EC: Remove noisy debug printk fron EC driver.
Date: Fri,  3 Aug 2007 18:33:41 -0400
Message-ID: <11861804331894-git-send-email-len.brown@intel.com>
References: <11861804251625-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7916 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763673AbXHCWdy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Aug 2007 18:33:54 -0400
In-Reply-To: <11861804251625-git-send-email-len.brown@intel.com>
Message-Id: <f1cd1fe61b96e4312312d42c0a9784dfab12e007.1186180370.git.len.brown@intel.com>
In-Reply-To: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
References: <67effe8fff32f60bdf51cba484766ba6003005bb.1186180370.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

ACPI: EC: Handler for query 0x57 is not found!

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 469f3f5..dd384ec 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -471,7 +471,6 @@ static void acpi_ec_gpe_query(void *ec_cxt)
 		}
 	}
 	mutex_unlock(&ec->lock);
-	printk(KERN_ERR PREFIX "Handler for query 0x%x is not found!\n", value);
 }
 
 static u32 acpi_ec_gpe_handler(void *data)
-- 
1.5.3.rc3.7.gd58e
