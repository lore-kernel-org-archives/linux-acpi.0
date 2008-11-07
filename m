From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/21] ACPI: fan: Delete the strict check in power transition
Date: Thu, 06 Nov 2008 23:39:09 -0500
Message-ID: <676962dac6e267ce7c13f73962208f9124a084bb.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:37227 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYKGEj3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00LLQ4XTOZP0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:29 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops the Fan device is turned on/off by controlling the
corresponding power resource. For example: If the power resource
defined in _PR0 object is turned off, it indicates that the FAN device
is in off state(the ACPI state is in D3 state).

Maybe the device is already in D3 state and expected to be transited to
D3 state. As there is no _PR3 object, the power transition can't be
finished and it will be switched to the Unknown state.

Maybe it is more reasonable that the strick check in power transistion
is deleted.

http://bugzilla.kernel.org/show_bug.cgi?id=9485

Signed-off-by: yakui.zhao@intel.com
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 30d4a52..89111cd 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -517,11 +517,6 @@ int acpi_power_transition(struct acpi_device *device, int state)
 	cl = &device->power.states[device->power.state].resources;
 	tl = &device->power.states[state].resources;
 
-	if (!cl->count && !tl->count) {
-		result = -ENODEV;
-		goto end;
-	}
-
 	/* TBD: Resources must be ordered. */
 
 	/*
-- 
1.5.6.5

