From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 12/33] eeepc-laptop: fix value of pwm1_enable to match documentation
Date: Thu,  3 Dec 2009 08:44:56 +0100
Message-ID: <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44224 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbZLCHoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:34 -0500
In-Reply-To: <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

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
1.6.5.3

