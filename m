From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] acpi/fan: Improve acpi_device_update_power error message
Date: Wed, 13 Jan 2016 14:25:19 -0800
Message-ID: <c2df13cfe6ffd40ebd9d49361b0fe1fc00bd8157.1452723847.git.luto@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40910 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbcAMWZX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jan 2016 17:25:23 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>

On my laptop, I see "Setting initial power state" on boot.  It's a
firmware bug on my laptop, but the message made me think that the
initial power state was bogus and the driver fixed it.  The error
actually means that the driver failed to set the initial power
state.  Fix the message.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/acpi/fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index e297a480e135..6322db64b4a4 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -339,7 +339,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	} else {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
-			dev_err(&device->dev, "Setting initial power state\n");
+			dev_err(&device->dev, "Failed to set initial power state\n");
 			goto end;
 		}
 	}
-- 
2.5.0

