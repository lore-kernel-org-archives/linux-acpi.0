From: Len Brown <len.brown@intel.com>
Subject: [PATCH 60/77] ACPI: thinkpad-acpi: make sure DSDT TMPx readings don't return +128
Date: Sun, 22 Jul 2007 05:14:45 -0400
Message-ID: <11850957651127-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
 <11850957181201-git-send-email-len.brown@intel.com>
 <11850957192175-git-send-email-len.brown@intel.com>
 <1185095721166-git-send-email-len.brown@intel.com>
 <1185095721760-git-send-email-len.brown@intel.com>
 <11850957232745-git-send-email-len.brown@intel.com>
 <11850957242656-git-send-email-len.brown@intel.com>
 <11850957252722-git-send-email-len.brown@intel.com>
 <11850957262869-git-send-email-len.brown@intel.com>
 <11850957272369-git-send-email-len.brown@intel.com>
 <11850957282082-git-send-email-len.brown@intel.com>
 <11850957292555-git-send-email-len.brown@intel.com>
 <11850957302782-git-send-email-len.brown@intel.com>
 <11850957311269-git-send-email-len.brown@intel.com>
 <11850957323059-git-send-email-len.brown@intel.com>
 <11850957332171-git-send-email-len.brown@intel.com>
 <11850957342584-git-send-email-len.brown@intel.com>
 <11850957362476-git-send-email-len.brown@intel.com>
 <11850957361736-git-send-email-len.brown@intel.com>
 <1185095737422-git-send-email-len.brown@intel.com>
 <11850957384004-git-send-email-len.brown@intel.com>
 <1185095739370-git-send-email-len.brown@intel.com>
 <11850957403722-git-send-email-len.brown@intel.com>
 <11850957413607-git-send-email-len.brown@intel.com>
 <11850957432095-git-send-email-len.brown@intel.com>
 <11850957443711-git-send-email-len.brown@intel.com>
 <11850957451942-git-send-email-len.brown@intel.com>
 <11850957462109-git-send-email-len.brown@intel.com>
 <11850957471828-git-send-email-len.brown@intel.com>
 <11850957482671-git-send-email-len.brown@intel.com>
 <11850957491254-git-send-email-len.brown@intel.com>
 <11850957503243-git-send-email-len.brown@intel.com>
 <1185095751279-git-send-email-len.brown@intel.com>
 <11850957522609-git-send-email-len.brown@intel.com>
 <11850957531914-git-send-email-len.brown@intel.com>
 <11850957541879-git-send-email-len.brown@intel.com>
 <11850957552824-git-send-email-len.brown@intel.com>
 <11850957561003-git-send-email-len.brown@intel.com>
 <11850957571080-git-send-email-len.brown@intel.com>
 <11850957591101-git-send-email-len.brown@intel.com>
 <11850957601664-git-send-email-len.brown@intel.com>
 <1185095761326-git-send-email-len.brown@intel.com>
 <11850957621605-git-send-email-len.brown@intel.com>
 <11850957633613-git-send-email-len.brown@intel.com>
 <11850957641697-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45627 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764380AbXGVJQH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:16:07 -0400
In-Reply-To: <11850957641697-git-send-email-len.brown@intel.com>
Message-Id: <a8fba3da3d11d808137be7ebeb3b6938a42f011f.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Michael Olbrich <michael.olbrich@gmx.net>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We get +128 instead of -128 from the DSDT TMPx methods, due to errors when
converting a EC byte return that is a s8 to an ACPI handler return that is
an int.

Fix it once and for all, by clamping acceptable temperature readings from
DSDT TMPx so that anything outside the [-127,+127] range is converted to
TP_EC_THERMAL_TMP_NA (-128).

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Michael Olbrich <michael.olbrich@gmx.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 623d36f..f74d7d6 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2853,6 +2853,8 @@ static int thermal_get_sensor(int idx, s32 *value)
 			snprintf(tmpi, sizeof(tmpi), "TMP%c", '0' + idx);
 			if (!acpi_evalf(ec_handle, &t, tmpi, "d"))
 				return -EIO;
+			if (t > 127 || t < -127)
+				t = TP_EC_THERMAL_TMP_NA;
 			*value = t * 1000;
 			return 0;
 		}
-- 
1.5.3.rc2.22.g69a9b
