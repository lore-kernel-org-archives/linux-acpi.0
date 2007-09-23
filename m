From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/7] ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
Date: Sat, 22 Sep 2007 22:10:36 -0300
Message-ID: <11905098421004-git-send-email-hmh@hmh.eng.br>
References: <11905098422303-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54635 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683AbXIWBKs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Sep 2007 21:10:48 -0400
In-Reply-To: <11905098422303-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Increase tp_features to 32 bits.  It is too close to running out of room.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.h |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 082a1cb..fa64ded 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -233,22 +233,22 @@ struct ibm_init_struct {
 
 static struct {
 #ifdef CONFIG_THINKPAD_ACPI_BAY
-	u16 bay_status:1;
-	u16 bay_eject:1;
-	u16 bay_status2:1;
-	u16 bay_eject2:1;
+	u32 bay_status:1;
+	u32 bay_eject:1;
+	u32 bay_status2:1;
+	u32 bay_eject2:1;
 #endif
-	u16 bluetooth:1;
-	u16 hotkey:1;
-	u16 hotkey_mask:1;
-	u16 hotkey_wlsw:1;
-	u16 light:1;
-	u16 light_status:1;
-	u16 wan:1;
-	u16 fan_ctrl_status_undef:1;
-	u16 input_device_registered:1;
-	u16 platform_drv_registered:1;
-	u16 platform_drv_attrs_registered:1;
+	u32 bluetooth:1;
+	u32 hotkey:1;
+	u32 hotkey_mask:1;
+	u32 hotkey_wlsw:1;
+	u32 light:1;
+	u32 light_status:1;
+	u32 wan:1;
+	u32 fan_ctrl_status_undef:1;
+	u32 input_device_registered:1;
+	u32 platform_drv_registered:1;
+	u32 platform_drv_attrs_registered:1;
 } tp_features;
 
 struct thinkpad_id_data {
-- 
1.5.3.1

