From: Len Brown <len.brown@intel.com>
Subject: [PATCH 074/105] ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
Date: Sun, 29 Apr 2007 00:51:14 -0400
Message-ID: <11778223732286-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42357 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756161AbXD2Ewy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:54 -0400
In-Reply-To: <11778223721984-git-send-email-len.brown@intel.com>
Message-Id: <eaa7571b2d1a08873e4bdd8e6db3431df61cd9ad.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The Linux ThinkPad community is not positive that all ThinkPads that do
HFSP EC fan control do implement full-speed and auto modes, some of the
earlier ones supporting HFSP might not.

If the EC ignores the AUTO or FULL-SPEED bits, it will pay attention to the
lower three bits that set the fan level.  And as thinkpad-acpi was leaving
these set to zero, it would stop(!) the fan, which is Not A Good Thing.

So, as a safety net, we now make sure to also set the fan level part of the
HFSP register to speed 7 for full-speed, and a minimum of speed 4 for auto
mode.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index a4d7ee4..79abc68 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3185,6 +3185,13 @@ static int fan_set_level(int level)
 		    ((level < 0) || (level > 7)))
 			return -EINVAL;
 
+		/* safety net should the EC not support AUTO
+		 * or FULLSPEED mode bits and just ignore them */
+		if (level & TP_EC_FAN_FULLSPEED)
+			level |= 7;	/* safety min speed 7 */
+		else if (level & TP_EC_FAN_FULLSPEED)
+			level |= 4;	/* safety min speed 4 */
+
 		if (!acpi_ec_write(fan_status_offset, level))
 			return -EIO;
 		else
@@ -3233,8 +3240,10 @@ static int fan_set_enable(void)
 			break;
 
 		/* Don't go out of emergency fan mode */
-		if (s != 7)
-			s = TP_EC_FAN_AUTO;
+		if (s != 7) {
+			s &= 0x07;
+			s |= TP_EC_FAN_AUTO | 4; /* min fan speed 4 */
+		}
 
 		if (!acpi_ec_write(fan_status_offset, s))
 			rc = -EIO;
@@ -3252,8 +3261,7 @@ static int fan_set_enable(void)
 		s &= 0x07;
 
 		/* Set fan to at least level 4 */
-		if (s < 4)
-			s = 4;
+		s |= 4;
 
 		if (!acpi_evalf(sfan_handle, NULL, NULL, "vd", s))
 			rc= -EIO;
-- 
1.5.2.rc0.34.gda94
