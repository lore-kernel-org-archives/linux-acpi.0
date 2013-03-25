From: Colin King <colin.king@canonical.com>
Subject: [PATCH 1/2] ACPI / fan: avoid null pointer deference error
Date: Mon, 25 Mar 2013 10:50:05 +0000
Message-ID: <1364208606-8446-2-git-send-email-colin.king@canonical.com>
References: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45572 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab3CYKuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Mar 2013 06:50:13 -0400
In-Reply-To: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix a null pointer deference by acpi_driver_data() if device is
null.  We should only set cdev and check this is OK after we are
sure device is not null.

Smatch analysis:

drivers/acpi/fan.c:179 acpi_fan_remove() warn: variable dereferenced
  before check 'device' (see line 177)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/fan.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index f815da8..8d1c010 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -174,9 +174,13 @@ static int acpi_fan_add(struct acpi_device *device)
 
 static int acpi_fan_remove(struct acpi_device *device)
 {
-	struct thermal_cooling_device *cdev = acpi_driver_data(device);
+	struct thermal_cooling_device *cdev;
+
+	if (!device)
+		return -EINVAL;
 
-	if (!device || !cdev)
+	cdev =  acpi_driver_data(device);
+	if (!cdev)
 		return -EINVAL;
 
 	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
-- 
1.7.9.5

