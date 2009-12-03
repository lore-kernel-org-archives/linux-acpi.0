From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 07/33] asus-laptop: set acpi_driver.owner
Date: Thu,  3 Dec 2009 08:44:51 +0100
Message-ID: <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44220 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753556AbZLCHoc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:32 -0500
In-Reply-To: <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

The owner field provides the link between drivers and modules in sysfs,
but no ACPI driver was setting it.

After setting the owner field, we can see which module provides which
driver and vice versa by looking at /sys/bus/acpi/driver/*/module and
/sys/module/*/drivers/acpi:*.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 drivers/platform/x86/asus-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 4234edb..6c05172 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -232,6 +232,7 @@ static void asus_hotk_notify(struct acpi_device *device, u32 event);
 static struct acpi_driver asus_hotk_driver = {
 	.name = ASUS_HOTK_NAME,
 	.class = ASUS_HOTK_CLASS,
+	.owner = THIS_MODULE,
 	.ids = asus_device_ids,
 	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
-- 
1.6.5.3

