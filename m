From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 8/9] [sony-laptop] Rename the SNC callback and events
Date: Sun,  1 Mar 2009 13:40:44 +0900
Message-ID: <1235882445-2404-9-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48644
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZCAEuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:17 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

This two objects are not specific to the C series.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 576c9c2..021c9d2 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -816,10 +816,10 @@ struct sony_nc_event {
 
 static struct sony_nc_event *sony_nc_events;
 
-/* Vaio C* --maybe also FE*, N* and AR* ?-- special init sequence
- * for Fn keys
+/* Some Vaio models require additional steps to enable
+ * Fn keys
  */
-static int sony_nc_C_enable(const struct dmi_system_id *id)
+static int sony_SNC_enable_cb(const struct dmi_system_id *id)
 {
 	int result = 0;
 
@@ -840,7 +840,7 @@ static int sony_nc_C_enable(const struct dmi_system_id *id)
 	return 0;
 }
 
-static struct sony_nc_event sony_C_events[] = {
+static struct sony_nc_event sony_SNC_events[] = {
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x82, SONYPI_EVENT_FNKEY_F2 },
@@ -869,8 +869,8 @@ static struct sony_nc_event sony_C_events[] = {
 static const struct dmi_system_id sony_nc_ids[] = {
 		{
 			.ident = "Sony Vaio FE Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FE"),
@@ -878,8 +878,8 @@ static const struct dmi_system_id sony_nc_ids[] = {
 		},
 		{
 			.ident = "Sony Vaio FW Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW"),
@@ -887,8 +887,8 @@ static const struct dmi_system_id sony_nc_ids[] = {
 		},
 		{
 			.ident = "Sony Vaio FZ Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ"),
@@ -896,8 +896,8 @@ static const struct dmi_system_id sony_nc_ids[] = {
 		},
 		{
 			.ident = "Sony Vaio C Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-C"),
@@ -905,8 +905,8 @@ static const struct dmi_system_id sony_nc_ids[] = {
 		},
 		{
 			.ident = "Sony Vaio N Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-N"),
@@ -914,8 +914,8 @@ static const struct dmi_system_id sony_nc_ids[] = {
 		},
 		{
 			.ident = "Sony Vaio Z Series",
-			.callback = sony_nc_C_enable,
-			.driver_data = sony_C_events,
+			.callback = sony_SNC_enable_cb,
+			.driver_data = sony_SNC_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-Z"),
-- 
1.6.1.3

