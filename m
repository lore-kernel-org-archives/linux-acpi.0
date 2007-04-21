From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 05/20] ACPI: thinkpad-acpi: update fan firmware documentation
Date: Sat, 21 Apr 2007 11:08:29 -0300
Message-ID: <1177164526290-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:59031 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031225AbXDUOJE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Apr 2007 10:09:04 -0400
In-Reply-To: <11771645253042-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update some stuff in the in-code text describing the ThinkPad fan
firmware.  This patch has no code changes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 1683bfe..4131a78 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1852,16 +1852,17 @@ static int volume_write(char *buf)
  * 	ACPI GFAN method: returns fan level
  *
  * 	see TPACPI_FAN_WR_ACPI_SFAN
- * 	EC 0x2f not available if GFAN exists
+ * 	EC 0x2f (HFSP) not available if GFAN exists
  *
  * TPACPI_FAN_WR_ACPI_SFAN:
  * 	ACPI SFAN method: sets fan level, 0 (stop) to 7 (max)
  *
- * 	EC 0x2f might be available *for reading*, but never for writing.
+ * 	EC 0x2f (HFSP) might be available *for reading*, but do not use
+ * 	it for writing.
  *
  * TPACPI_FAN_WR_TPEC:
- * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode Supported
- * 	on almost all ThinkPads
+ * 	ThinkPad EC register 0x2f (HFSP): fan control loop mode
+ * 	Supported on almost all ThinkPads
  *
  * 	Fan speed changes of any sort (including those caused by the
  * 	disengaged mode) are usually done slowly by the firmware as the
@@ -1875,12 +1876,13 @@ static int volume_write(char *buf)
  *	 7	automatic mode engaged;
  *  		(default operation mode of the ThinkPad)
  * 		fan level is ignored in this mode.
- *	 6	disengage mode (takes precedence over bit 7);
+ *	 6	full speed mode (takes precedence over bit 7);
  *		not available on all thinkpads.  May disable
- *		the tachometer, and speeds up fan to 100% duty-cycle,
- *		which speeds it up far above the standard RPM
- *		levels.  It is not impossible that it could cause
- *		hardware damage.
+ *		the tachometer while the fan controller ramps up
+ *		the speed (which can take up to a few *minutes*).
+ *		Speeds up fan to 100% duty-cycle, which is far above
+ *		the standard RPM levels.  It is not impossible that
+ *		it could cause hardware damage.
  *	5-3	unused in some models.  Extra bits for fan level
  *		in others, but still useless as all values above
  *		7 map to the same speed as level 7 in these models.
@@ -1916,9 +1918,8 @@ static int volume_write(char *buf)
  *	FIRMWARE BUG: always read 0x84 first, otherwise incorrect readings
  *	might result.
  *
- *	FIRMWARE BUG: when EC 0x2f bit 6 is set (disengaged mode), this
- *	register is not invalidated in ThinkPads that disable tachometer
- *	readings.  Thus, the tachometer readings go stale.
+ *	FIRMWARE BUG: may go stale while the EC is switching to full speed
+ *	mode.
  *
  *	For firmware bugs, refer to:
  *	http://thinkwiki.org/wiki/Embedded_Controller_Firmware#Firmware_Issues
@@ -2283,9 +2284,6 @@ static int fan_read(char *p)
 		len += sprintf(p + len, "status:\t\t%s\n",
 			       (status != 0) ? "enabled" : "disabled");
 
-		/* No ThinkPad boots on disengaged mode, we can safely
-		 * assume the tachometer is online if fan control status
-		 * was unknown */
 		if ((rc = fan_get_speed(&speed)) < 0)
 			return rc;
 
-- 
1.5.1

