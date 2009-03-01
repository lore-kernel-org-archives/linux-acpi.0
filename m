From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 7/9] [sony-laptop] Add FW specific hotkey events and DMI
Date: Sun,  1 Mar 2009 13:40:43 +0900
Message-ID: <1235882445-2404-8-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48643
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbZCAEuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:17 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Anton Veretenenko <anton@veretenenko.ru>, Mattia Dongili <malattia@linux.it>

From: Anton Veretenenko <anton@veretenenko.ru>

From: Anton Veretenenko <anton@veretenenko.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 8568d1e..576c9c2 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -843,16 +843,25 @@ static int sony_nc_C_enable(const struct dmi_system_id *id)
 static struct sony_nc_event sony_C_events[] = {
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x82, SONYPI_EVENT_FNKEY_F2 },
+	{ 0x02, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
 	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
 	{ 0x86, SONYPI_EVENT_FNKEY_F6 },
 	{ 0x06, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x87, SONYPI_EVENT_FNKEY_F7 },
 	{ 0x07, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x89, SONYPI_EVENT_FNKEY_F9 },
+	{ 0x09, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8A, SONYPI_EVENT_FNKEY_F10 },
 	{ 0x0A, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x8C, SONYPI_EVENT_FNKEY_F12 },
 	{ 0x0C, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x90, SONYPI_EVENT_PKEY_P1 },
+	{ 0x10, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0xA1, SONYPI_EVENT_PKEY_P2 },
+	{ 0x21, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0, 0 },
 };
 
@@ -868,6 +877,15 @@ static const struct dmi_system_id sony_nc_ids[] = {
 			},
 		},
 		{
+			.ident = "Sony Vaio FW Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW"),
+			},
+		},
+		{
 			.ident = "Sony Vaio FZ Series",
 			.callback = sony_nc_C_enable,
 			.driver_data = sony_C_events,
-- 
1.6.1.3

