From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / scan: Correct error return value of create_modalias()
Date: Fri, 12 Sep 2014 11:33:10 +0300
Message-ID: <1410510790-21251-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21876 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbaILIdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Sep 2014 04:33:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

There is a typo, it should be negative -errno instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3bf7764659a4..d5e6ac5042d8 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -130,7 +130,7 @@ static int create_modalias(struct acpi_device *acpi_dev, char *modalias,
 	list_for_each_entry(id, &acpi_dev->pnp.ids, list) {
 		count = snprintf(&modalias[len], size, "%s:", id->id);
 		if (count < 0)
-			return EINVAL;
+			return -EINVAL;
 		if (count >= size)
 			return -ENOMEM;
 		len += count;
-- 
2.1.0

