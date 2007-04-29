From: Len Brown <len.brown@intel.com>
Subject: [PATCH 050/105] ACPI: thinkpad-acpi: update fan firmware documentation
Date: Sun, 29 Apr 2007 00:50:50 -0400
Message-ID: <1177822352591-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9417 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756121AbXD2Ewg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:36 -0400
In-Reply-To: <11778223512990-git-send-email-len.brown@intel.com>
Message-Id: <f51d1a39840ae5e8678d702ab57377c611fc3826.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Update some stuff in the in-code text describing the ThinkPad fan
firmware.  This patch has no code changes.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.2.rc0.34.gda94
