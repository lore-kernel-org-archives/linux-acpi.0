From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] PNPACPI: check return value of pnp_add_device()
Date: Thu, 4 Nov 2010 10:39:30 -0700
Message-ID: <20101104173929.GA11251@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49196 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0KDRjk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Nov 2010 13:39:40 -0400
Received: by gxk23 with SMTP id 23so1617586gxk.19
        for <linux-acpi@vger.kernel.org>; Thu, 04 Nov 2010 10:39:39 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>

pnp_add_device() may fail so we need to handle errors and avoid leaking
memory. Also, do not use ACPI-specific return codes (AE_OK) but rather
standard ones.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/pnp/pnpacpi/core.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)


diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 2d73dfc..06ee06c 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -194,8 +194,9 @@ static char *pnpacpi_get_id(struct acpi_device *device)
 
 static int __init pnpacpi_add_device(struct acpi_device *device)
 {
-	acpi_handle temp = NULL;
+	acpi_handle temp;
 	acpi_status status;
+	int error;
 	struct pnp_dev *dev;
 	char *pnpid;
 	struct acpi_hardware_id *id;
@@ -256,10 +257,16 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	/* clear out the damaged flags */
 	if (!dev->active)
 		pnp_init_resources(dev);
-	pnp_add_device(dev);
+
+	error = pnp_add_device(dev);
+	if (error) {
+		put_device(&dev->dev);
+		return error;
+	}
+
 	num++;
 
-	return AE_OK;
+	return 0;
 }
 
 static acpi_status __init pnpacpi_add_device_handler(acpi_handle handle,
-- 
Dmitry
