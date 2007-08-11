From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/2] sony-laptop: enable vaio FZ events
Date: Sat, 11 Aug 2007 10:43:06 +0900
Message-ID: <11867965871757-git-send-email-malattia@linux.it>
References: <1186796587433-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:43674 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbXHKBnl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Aug 2007 21:43:41 -0400
In-Reply-To: <1186796587433-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 99f48c7..1fd84a5 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -847,13 +847,17 @@ static struct sony_nc_event sony_C_events[] = {
 /* SNC-only model map */
 static struct dmi_system_id sony_nc_ids[] = {
 		{
-			.ident = "Sony Vaio FE Series",
+			.ident = "Sony Vaio FE/FZ Series",
 			.callback = sony_nc_C_enable,
 			.driver_data = sony_C_events,
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
 				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FE"),
 			},
+			{
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ"),
+			},
 		},
 		{
 			.ident = "Sony Vaio C Series",
-- 
1.5.2.4

