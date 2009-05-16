From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/19] ACPI: suspend: don't let device _PS3 failure prevent
 suspend
Date: Sat, 16 May 2009 02:02:02 -0400
Message-ID: <19bde778c1fd2574cc020a618d7d576f260271ca.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:30755 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbZEPGCa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:30 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00F3T3FWM00N@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:28 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

6328a57401dc5f5cf9931738eb7268fcd8058c49
"Enable PNPACPI _PSx Support, v3"

added a call to acpi_bus_set_power(handle, ACPI_STATE_D3)
to pnpacpi_disable_resource() before the existing call
to evaluate _DIS on the device.

This caused suspend to fail on the system in
http://bugzilla.kernel.org/show_bug.cgi?id=13243
because the sanity check to verify we entered _PS3
failed on the serial port.

As a work-around, that sanity check can be disabled
system-wide with "acpi.power_nocheck=1"

Or perhaps we should just shrug off the _PS3 failure
and carry on with _DIS like we used to -- which is
what this patch does.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 9a3a682..9496494 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -110,11 +110,9 @@ static int pnpacpi_disable_resources(struct pnp_dev *dev)
 
 	/* acpi_unregister_gsi(pnp_irq(dev, 0)); */
 	ret = 0;
-	if (acpi_bus_power_manageable(handle)) {
-		ret = acpi_bus_set_power(handle, ACPI_STATE_D3);
-		if (ret)
-			return ret;
-	}
+	if (acpi_bus_power_manageable(handle))
+		acpi_bus_set_power(handle, ACPI_STATE_D3);
+		/* continue even if acpi_bus_set_power() fails */
 	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_DIS", NULL, NULL)))
 		ret = -ENODEV;
 	return ret;
-- 
1.6.0.6

