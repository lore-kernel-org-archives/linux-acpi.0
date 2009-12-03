From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 09/33] eeepc-laptop: Remove redundant NULL checks
Date: Thu,  3 Dec 2009 08:44:53 +0100
Message-ID: <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44223 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887AbZLCHod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:33 -0500
In-Reply-To: <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

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
---
 drivers/platform/x86/eeepc-laptop.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 9130434..7dde47a 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1255,8 +1255,6 @@ static int __devinit eeepc_hotk_add(struct acpi_device *device)
 	struct device *dev;
 	int result;
 
-	if (!device)
-		return -EINVAL;
 	pr_notice(EEEPC_HOTK_NAME "\n");
 	ehotk = kzalloc(sizeof(struct eeepc_hotk), GFP_KERNEL);
 	if (!ehotk)
@@ -1343,9 +1341,6 @@ fail_platform_driver:
 
 static int eeepc_hotk_remove(struct acpi_device *device, int type)
 {
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
-
 	eeepc_backlight_exit();
 	eeepc_rfkill_exit();
 	eeepc_input_exit();
-- 
1.6.5.3

