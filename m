From: Len Brown <lenb@kernel.org>
Subject: [PATCH 091/112] ACPI: thinkpad-acpi: second TP_EC_FAN_FULLSPEED should be TP_EC_FAN_AUTO
Date: Thu,  7 Feb 2008 04:34:53 -0500
Message-ID: <547266e46cc0b35ce51bd1f37f261d831927431f.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:48010 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758391AbYBGJgv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:51 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Roel Kluin <12o3l@tiscali.nl>, Len Brown <len.brown@intel.com>

From: Roel Kluin <12o3l@tiscali.nl>

fix bug in safety net for TPEC fan control mode
eaa7571b2d1a08873e4bdd8e6db3431df61cd9ad

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 8ef0afc..7ba1aca 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4790,7 +4790,7 @@ static int fan_set_level(int level)
 		 * or FULLSPEED mode bits and just ignore them */
 		if (level & TP_EC_FAN_FULLSPEED)
 			level |= 7;	/* safety min speed 7 */
-		else if (level & TP_EC_FAN_FULLSPEED)
+		else if (level & TP_EC_FAN_AUTO)
 			level |= 4;	/* safety min speed 4 */
 
 		if (!acpi_ec_write(fan_status_offset, level))
-- 
1.5.4.23.gef5b9

