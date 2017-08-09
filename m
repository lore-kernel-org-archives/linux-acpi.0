From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v2] ACPI / LPSS: Don't abort acpi scan on missing mem resource.
Date: Wed,  9 Aug 2017 01:15:42 -0700
Message-ID: <1502266542-19268-1-git-send-email-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chill.innovation.ch ([216.218.245.220]:35118 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752228AbdHIIPp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2017 04:15:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>

The keyboard and touchpad on MacBook's from 2015 onwards are connected
via an SPI bus. On MacBook8's (2015) the ACPI device for the SPI master
for this bus has _CID "INT33C1", and hence the acpi-lpss handler here is
triggered for it. However, the DSDT lists no memory resources for this
device, resulting in an error being returned by the attach callback and
therefore the SPI master device being ignored. This prevents us from
being able to register the keyboard and touchpad driver.

Furthermore, the controller (a Wildcat Point-LP controller) does not
appear to need the functionality provided by the apci-lpss handler.
Therefore we now just skip the handler if no memory resources are found
and let the ACPI scan complete successfully for this device.

All of this is not an issue on later MacBook(Pro)'s because their ACPI
SPI devices don't have any _CID and therefore no attempt is made to attach
this handler.

Returning an error was introduced in commit d3e13ff3c1aa - this restores
the original behaviour.

Link: https://github.com/cb22/macbook12-spi-driver
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
Changes V2:
  Expanded commit message to give more context and details.

 drivers/acpi/acpi_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index f88caf5aab76..032ae44710e5 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -465,7 +465,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (!pdata->mmio_base) {
-		ret = -ENOMEM;
+		/* Skip the device, but continue the namespace scan. */
+		ret = 0;
 		goto err_out;
 	}
 
-- 
2.13.4

