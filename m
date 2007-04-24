From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 7/9] ACPI: thinkpad-acpi: add a safety net for TPEC fan control mode
Date: Tue, 24 Apr 2007 11:48:18 -0300
Message-ID: <11774261023730-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:48009 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754170AbXDXOsa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Apr 2007 10:48:30 -0400
In-Reply-To: <11774261003184-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

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
1.5.1

