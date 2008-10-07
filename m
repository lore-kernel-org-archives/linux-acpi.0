From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [Resend] [PATCH 2/2]  ACPI : Delete the strick check in ACPI power
	transistion
Date: Tue, 07 Oct 2008 09:26:42 +0800
Message-ID: <1223342802.4023.297.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44370 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754263AbYJGBVp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 6 Oct 2008 21:21:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject: ACPI : Delete the strick check in power transistion
From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops the Fan device is turned on/off by controlling the
corresponding power resource. For example: If the power resource
defined in _PR0 object is turned off, it indicates that the FAN device
is in off state(the ACPI state is in D3 state). 

Maybe the device is already in D3 state and expected to be transited to 
D3 state. As there is no _PR3 object, the power transition can't be
finished and it will be switched to the Unknow state.

Maybe it is more reasonable that the strick check in power transistion
is deleted. 

http://bugzilla.kernel.org/show_bug.cgi?id=9485

Signed-off-by: yakui.zhao@intel.com
---
 drivers/acpi/power.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -517,11 +517,6 @@ int acpi_power_transition(struct acpi_de
 	cl = &device->power.states[device->power.state].resources;
 	tl = &device->power.states[state].resources;
 
-	if (!cl->count && !tl->count) {
-		result = -ENODEV;
-		goto end;
-	}
-
 	/* TBD: Resources must be ordered. */
 
 	/*


