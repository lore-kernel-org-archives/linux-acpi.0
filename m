From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH] ACPI: acpi_driver_data could only be applied to acpi_device
Date: Wed, 10 Sep 2008 14:33:43 +0400
Message-ID: <20080910103342.20391.81647.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:33985 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbYIJKdr (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 10 Sep 2008 06:33:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: LenBrown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
CC: Hannes Reinecke <hare@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f6f52c1..e7b8853 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -384,7 +384,7 @@ static int acpi_device_remove(struct device * dev)
 			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
 	}
 	acpi_dev->driver = NULL;
-	acpi_driver_data(dev) = NULL;
+	acpi_driver_data(acpi_dev) = NULL;
 
 	put_device(dev);
 	return 0;

