From: Len Brown <lenb@kernel.org>
Subject: [PATCH 029/103] eeepc-laptop: fix value of pwm1_enable to match
 documentation
Date: Wed, 16 Dec 2009 03:35:40 -0500
Message-ID: <487186880d31821eaaba0cc1f27d5a581c56981d.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760929AbZLPKGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:06:06 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:56 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Documentation/hwmon/sysfs-interface tells us that automatic fan speed
control should be represented by a value of 2 or above for pwm1_enable.
Fix eeepc_get_fan_ctrl() to return 2 for automatic fan control.

Setting "1" for manual control is already consistent with the
documentation, so this remains unchanged.

Let's preserve the ABI for this specific driver, so that writing "0"
will still invoke automatic control.

(The documentation says setting "0" should leave the fan at full speed
all the time.  This mode is not directly supported by our hardware. Full
speed is rather noisy on my 701 and the automatic control has never used
it.  If you really want this e.g. to prolong the life of an EeePC used
as a server, you can always use manual mode.  hwmon has always been
fairly machine-specific, and you're in a tiny minority (or elite :-).
I'm sure you're smart enough to notice that the fan doesn't turn on to
full speed when you try this mode, either by ear or checking
fan_input1.

We could even claim to be honouring the spirit of the documentation.
"0" really means "safe mode".  EeePCs default to automatic mode, ie that
is what Asus will actually test.  Since we do not provide any way to
tamper with the temperature threshold, automatic mode _is_ the safe
option).

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 1c04c87..6c982d6 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -935,7 +935,10 @@ static int eeepc_get_fan_ctrl(void)
 	int value = 0;
 
 	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
-	return ((value & 0x02 ? 1 : 0));
+	if (value & 0x02)
+		return 1; /* manual */
+	else
+		return 2; /* automatic */
 }
 
 static void eeepc_set_fan_ctrl(int manual)
@@ -943,7 +946,7 @@ static void eeepc_set_fan_ctrl(int manual)
 	int value = 0;
 
 	read_acpi_int(NULL, EEEPC_EC_FAN_CTRL, &value);
-	if (manual)
+	if (manual == 1)
 		value |= 0x02;
 	else
 		value &= ~0x02;
-- 
1.6.0.6

