From: Len Brown <lenb@kernel.org>
Subject: [PATCH 020/103] asus-acpi: Remove redundant NULL checks
Date: Wed, 16 Dec 2009 03:35:31 -0500
Message-ID: <2d5db0be4ce36b265f9ddd8debab40acd8580403.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760814AbZLPKFy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:54 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:52 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The acpi device callbacks add, start, remove, suspend and resume can
never be called with a NULL acpi_device. Each callsite in acpi/scan.c
has to dereference the device in order to get the ops structure, e.g.

    struct acpi_device *acpi_dev = to_acpi_device(dev);
    struct acpi_driver *acpi_drv = acpi_dev->driver;

    if (acpi_drv && acpi_drv->ops.suspend)
        return acpi_drv->ops.suspend(acpi_dev, state);

Remove all checks for acpi_dev == NULL within these callbacks.

Also remove the checks for acpi_driver_data(acpi_dev) == NULL. None of
these checks could fail unless the driver does something strange
(which none of them do), the acpi core did something terribly wrong,
or we have a memory corruption issue. If this does happen then it's
best to dereference the pointer and crash noisily.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/asus_acpi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index ddf5240..25a7d57 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -1334,9 +1334,6 @@ static int asus_hotk_add(struct acpi_device *device)
 	acpi_status status = AE_OK;
 	int result;
 
-	if (!device)
-		return -EINVAL;
-
 	printk(KERN_NOTICE "Asus Laptop ACPI Extras version %s\n",
 	       ASUS_ACPI_VERSION);
 
@@ -1392,9 +1389,6 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	asus_hotk_remove_fs(device);
 
 	kfree(hotk);
-- 
1.6.0.6

