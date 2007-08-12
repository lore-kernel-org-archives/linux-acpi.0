From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/3] sony-laptop: enable Vaio FZ events
Date: Sun, 12 Aug 2007 16:20:26 +0900
Message-ID: <11869032283577-git-send-email-malattia@linux.it>
References: <11869032283795-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:36175 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbXHLHUp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 03:20:45 -0400
In-Reply-To: <11869032283795-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 99f48c7..7e621c6 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -856,6 +856,15 @@ static struct dmi_system_id sony_nc_ids[] = {
 			},
 		},
 		{
+			.ident = "Sony Vaio FZ Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ"),
+			},
+		},
+		{
 			.ident = "Sony Vaio C Series",
 			.callback = sony_nc_C_enable,
 			.driver_data = sony_C_events,
-- 
1.5.2.4

