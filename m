From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] ACPI / LPSS: check the result of ioremap
Date: Thu,  8 Jan 2015 09:57:25 +0200
Message-ID: <1420703845-85859-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37150 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbAHH52 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2015 02:57:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

If it fails we have to skip the device.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 4f3febf..d12f98a 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -340,6 +340,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 				pdata->mmio_size = resource_size(&rentry->res);
 			pdata->mmio_base = ioremap(rentry->res.start,
 						   pdata->mmio_size);
+			if (!pdata->mmio_base)
+				goto err_out;
 			break;
 		}
 
-- 
2.1.4

