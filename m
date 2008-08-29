From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ACPI: no more users of acpi_is_child_device
Date: Sat, 30 Aug 2008 02:01:59 +0400
Message-ID: <20080829220159.GA1257@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:13979 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYH2WCJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Aug 2008 18:02:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so650401fgg.17
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2008 15:02:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, yakui.zhao@intel.com, shaohua.li@intel.com, rui.zhang@intel.com


 The only use of acpi_is_child_device() was removed by
 ba2058572ac27e3a8a0ca570dab0cf70b210cdb1
 (ACPI : Load device driver according to the status of acpi device)

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 drivers/acpi/scan.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78e164f..ca23f10 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1131,20 +1131,6 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 }
 
 static int
-acpi_is_child_device(struct acpi_device *device,
-			int (*matcher)(struct acpi_device *))
-{
-	int result = -ENODEV;
-
-	do {
-		if (ACPI_SUCCESS(matcher(device)))
-			return AE_OK;
-	} while ((device = device->parent));
-
-	return result;
-}
-
-static int
 acpi_add_single_object(struct acpi_device **child,
 		       struct acpi_device *parent, acpi_handle handle, int type,
 			struct acpi_bus_ops *ops)
