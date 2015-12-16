From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pnp: respect PNP_DRIVER_RES_DO_NOT_CHANGE when detaching
Date: Wed, 16 Dec 2015 07:33:22 +0100
Message-ID: <567105B2.3080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:32811 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbbLPGdl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2015 01:33:41 -0500
Received: by mail-wm0-f44.google.com with SMTP id n186so126566688wmn.0
        for <linux-acpi@vger.kernel.org>; Tue, 15 Dec 2015 22:33:41 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rafael@kernel.org

I have a device (Nuvoton 6779D Super-IO IR RC with nuvoton-cir driver)
which works after initial boot but not any longer if I unload and
re-load the driver module.

Digging into the issue I found that unloading the driver calls
pnp_disable_dev although the driver has flag PNP_DRIVER_RES_DO_NOT_CHANGE
set. IMHO this is not right.

Let's have a look at the call chain when probing a device:
pnp_device_probe
1. attaches the device
2. if it's not active and PNP_DRIVER_RES_DO_NOT_CHANGE is not set
   it gets activated
3. probes driver

I think pnp_device_remove should do it in reverse order and also
respect PNP_DRIVER_RES_DO_NOT_CHANGE. Therefore:
1. call drivers remove callback
2. if device is active and PNP_DRIVER_RES_DO_NOT_CHANGE is not set
   disable it
3. detach device

The change works for me and sounds logical to me.
However I don't know the pnp driver in detail so I might be wrong.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pnp/driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index 153a493..74b201d 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -74,7 +74,6 @@ void pnp_device_detach(struct pnp_dev *pnp_dev)
 	if (pnp_dev->status == PNP_ATTACHED)
 		pnp_dev->status = PNP_READY;
 	mutex_unlock(&pnp_lock);
-	pnp_disable_dev(pnp_dev);
 }
 
 static int pnp_device_probe(struct device *dev)
@@ -131,6 +130,11 @@ static int pnp_device_remove(struct device *dev)
 			drv->remove(pnp_dev);
 		pnp_dev->driver = NULL;
 	}
+
+	if (pnp_dev->active &&
+	    (!drv || !(drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE)))
+		pnp_disable_dev(pnp_dev);
+
 	pnp_device_detach(pnp_dev);
 	return 0;
 }
-- 
2.6.2


