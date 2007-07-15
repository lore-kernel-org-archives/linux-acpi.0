From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/7] Add Vaio FE to the special init sequence
Date: Mon, 16 Jul 2007 02:34:38 +0900
Message-ID: <11845208801817-git-send-email-malattia@linux.it>
References: <1184520879452-git-send-email-malattia@linux.it>
 <1184520879991-git-send-email-malattia@linux.it>
 <11845208793336-git-send-email-malattia@linux.it>
 <11845208793678-git-send-email-malattia@linux.it>
 <11845208794064-git-send-email-malattia@linux.it>
 <11845208791511-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi11.ns.itscom.net ([219.110.2.181]:57540 "EHLO
	mtoichi11.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758792AbXGORfE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:35:04 -0400
In-Reply-To: <11845208791511-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

The Vaio FE series uses the same sequence as Vaio C series

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 916b477..6909714 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -791,6 +791,15 @@ static struct sony_nc_event sony_C_events[] = {
 /* SNC-only model map */
 struct dmi_system_id sony_nc_ids[] = {
 		{
+			.ident = "Sony Vaio FE Series",
+			.callback = sony_nc_C_enable,
+			.driver_data = sony_C_events,
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FE"),
+			},
+		},
+		{
 			.ident = "Sony Vaio C Series",
 			.callback = sony_nc_C_enable,
 			.driver_data = sony_C_events,
-- 
1.5.2.3

