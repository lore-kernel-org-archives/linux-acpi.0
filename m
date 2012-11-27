From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI: remove unnecessary INIT_LIST_HEAD
Date: Tue, 27 Nov 2012 11:03:45 +0200
Message-ID: <1354007025-8334-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53240 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758295Ab2K0JD6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2012 04:03:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Westerberg, Mika" <mika.westerberg@intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to initialize the node before appending it to the list.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/resource.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4107c00..a3868f6 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -426,7 +426,6 @@ static acpi_status acpi_dev_new_resource_entry(struct resource *r,
 		c->error = -ENOMEM;
 		return AE_NO_MEMORY;
 	}
-	INIT_LIST_HEAD(&rentry->node);
 	rentry->res = *r;
 	list_add_tail(&rentry->node, c->list);
 	c->count++;
-- 
1.7.10.4

