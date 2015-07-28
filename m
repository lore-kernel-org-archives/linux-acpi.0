From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / PM: Use target_state to set the device power state
Date: Tue, 28 Jul 2015 13:51:21 +0300
Message-ID: <1438080681-3364-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6176 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbbG1Kv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jul 2015 06:51:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 20dacb71ad28 ("ACPI / PM: Rework device power management to follow
ACPI 6") changed the device power management to use D3hot if the device
in question does not have _PR3 method even if D3cold was requested by the
caller.

However, if the device has _PR3 device->power.state is also set to D3hot
instead of D3Cold after power resources have been turned off because
device->power.state will be assigned from "state" instead of
"target_state".

Next time the device is transitioned to D0, acpi_power_transition() will
find that the current power state of the device is D3hot instead of D3cold
which causes it to power down all resources required for the current
(wrong) state D3hot.

Below is a simplified ASL example of a real touch panel device which
triggers the problem:

  Scope (TPL1)
  {
      Name (_PR0, Package (1) { \_SB.PCI0.I2C1.PXTC })
      Name (_PR3, Package (1) { \_SB.PCI0.I2C1.PXTC })
      ...
  }

In both D0 and D3hot the same power resource is required. However, when
acpi_power_transition() turns off power resources required for D3hot (as
the device is transitioned to D0) it powers down PXTC which then makes the
device to lose its power.

Fix this by assigning "target_state" to the device power state instead of
"state" that is always D3hot even for devices with valid _PR3.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/device_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 08dc3ec7e892..337e8118836d 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -231,7 +231,7 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 		dev_warn(&device->dev, "Failed to change power state to %s\n",
 			 acpi_power_state_string(state));
 	} else {
-		device->power.state = state;
+		device->power.state = target_state;
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Device [%s] transitioned to %s\n",
 				  device->pnp.bus_id,
-- 
2.4.6

