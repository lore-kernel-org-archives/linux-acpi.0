From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 4/4] thinkpad-acpi: wrong thermal attribute_group removed in thermal_exit()
Date: Sat,  6 Feb 2010 13:30:30 -0200
Message-ID: <1265470230-30797-5-git-send-email-hmh@hmh.eng.br>
References: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:37381 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753014Ab0BFPai (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:30:38 -0500
In-Reply-To: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Roel Kluin <roel.kluin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

From: Roel Kluin <roel.kluin@gmail.com>

sysfs_remove_group() removed the wrong attribute_group for
thermal_read_mode TPEC_8, ACPI_TMP07 and ACPI_UPDT

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f2dee94..933bcc4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5772,7 +5772,7 @@ static void thermal_exit(void)
 	case TPACPI_THERMAL_ACPI_TMP07:
 	case TPACPI_THERMAL_ACPI_UPDT:
 		sysfs_remove_group(&tpacpi_sensors_pdev->dev.kobj,
-				   &thermal_temp_input16_group);
+				   &thermal_temp_input8_group);
 		break;
 	case TPACPI_THERMAL_NONE:
 	default:
-- 
1.6.5.7

