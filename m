From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/23] thinkpad-acpi: fix LED handling on older ThinkPads
Date: Wed, 11 Jun 2008 03:59:08 -0400
Message-ID: <e0e91ceada6c48546ad124ff2a964db0a0545d8f.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:65151 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbYFKH7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:38 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00DTBGV4Y9R4@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:29 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The less tested codepaths for LED handling, used on ThinkPads 570, 600e/x,
770e, 770x, A21e, A2xm/p, T20-22, X20 and maybe a few others, would write
data to kernel memory it had no business touching, for leds number 3 and
above.  If one is lucky, that illegal write would cause an OOPS, but
chances are it would silently corrupt a byte.

The problem was introduced in commit af116101, "ACPI: thinkpad-acpi: add
sysfs led class support to thinkpad leds (v3.2)".

Fix the bug by refactoring the entire code to be far more obvious on what
it wants to do.  Also do some defensive "constification".

Issue reported by Karol Lewandowski <lmctlx@gmail.com> (he's an lucky guy
and got an OOPS instead of silent corruption :-) ).

Root cause of the OOPS identified by Adrian Bunk <bunk@kernel.org>.
Thanks, Adrian!

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Tested-by: Karol Lewandowski <lmctlx@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   55 +++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 58973da..b596929 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3853,7 +3853,7 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
 	"tpacpi::standby",
 };
 
-static int led_get_status(unsigned int led)
+static int led_get_status(const unsigned int led)
 {
 	int status;
 	enum led_status_t led_s;
@@ -3877,41 +3877,42 @@ static int led_get_status(unsigned int led)
 	/* not reached */
 }
 
-static int led_set_status(unsigned int led, enum led_status_t ledstatus)
+static int led_set_status(const unsigned int led,
+			  const enum led_status_t ledstatus)
 {
 	/* off, on, blink. Index is led_status_t */
-	static const int led_sled_arg1[] = { 0, 1, 3 };
-	static const int led_exp_hlbl[] = { 0, 0, 1 };	/* led# * */
-	static const int led_exp_hlcl[] = { 0, 1, 1 };	/* led# * */
-	static const int led_led_arg1[] = { 0, 0x80, 0xc0 };
+	static const unsigned int led_sled_arg1[] = { 0, 1, 3 };
+	static const unsigned int led_led_arg1[] = { 0, 0x80, 0xc0 };
 
 	int rc = 0;
 
 	switch (led_supported) {
 	case TPACPI_LED_570:
-			/* 570 */
-			led = 1 << led;
-			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
-					led, led_sled_arg1[ledstatus]))
-				rc = -EIO;
-			break;
+		/* 570 */
+		if (led > 7)
+			return -EINVAL;
+		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
+				(1 << led), led_sled_arg1[ledstatus]))
+			rc = -EIO;
+		break;
 	case TPACPI_LED_OLD:
-			/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
-			led = 1 << led;
-			rc = ec_write(TPACPI_LED_EC_HLMS, led);
-			if (rc >= 0)
-				rc = ec_write(TPACPI_LED_EC_HLBL,
-					      led * led_exp_hlbl[ledstatus]);
-			if (rc >= 0)
-				rc = ec_write(TPACPI_LED_EC_HLCL,
-					      led * led_exp_hlcl[ledstatus]);
-			break;
+		/* 600e/x, 770e, 770x, A21e, A2xm/p, T20-22, X20 */
+		if (led > 7)
+			return -EINVAL;
+		rc = ec_write(TPACPI_LED_EC_HLMS, (1 << led));
+		if (rc >= 0)
+			rc = ec_write(TPACPI_LED_EC_HLBL,
+				      (ledstatus == TPACPI_LED_BLINK) << led);
+		if (rc >= 0)
+			rc = ec_write(TPACPI_LED_EC_HLCL,
+				      (ledstatus != TPACPI_LED_OFF) << led);
+		break;
 	case TPACPI_LED_NEW:
-			/* all others */
-			if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
-					led, led_led_arg1[ledstatus]))
-				rc = -EIO;
-			break;
+		/* all others */
+		if (!acpi_evalf(led_handle, NULL, NULL, "vdd",
+				led, led_led_arg1[ledstatus]))
+			rc = -EIO;
+		break;
 	default:
 		rc = -ENXIO;
 	}
-- 
1.5.6.rc2.23.gea81e

