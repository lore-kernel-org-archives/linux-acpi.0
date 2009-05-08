From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent suspend
Date: Fri, 08 May 2009 00:39:38 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905080037240.20287@localhost.localdomain>
References: <bug-13243-10286@http.bugzilla.kernel.org/>
 <20090505150138.92f3ecd6.akpm@linux-foundation.org>
 <4A02000D.9030400@gmx.net>  <200905061616.36707.bjorn.helgaas@hp.com>
 <1241660638.3773.90.camel@localhost.localdomain> <4A0330E3.9060909@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:53845 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZEHEkI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 00:40:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJB002RW6A5J0TN@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 07 May 2009 23:39:47 -0500 (CDT)
In-reply-to: <4A0330E3.9060909@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Cc: yakui_zhao <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, linux-acpi@vger.kernel.org

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
1.6.3

