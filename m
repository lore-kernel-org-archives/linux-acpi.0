From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/7] sony-laptop: add new SNC handlers
Date: Mon, 16 Jul 2007 02:34:33 +0900
Message-ID: <1184520879991-git-send-email-malattia@linux.it>
References: <1184520879452-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:55007 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759343AbXGORfF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:35:05 -0400
In-Reply-To: <1184520879452-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

- lid state: GLID
- indicator lamp: GILS/SILS
- multimedia bass gain: GMGB/CMGB

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 8ee0321..2063de7 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -487,6 +487,14 @@ SNC_HANDLE_NAMES(audiopower_set, "AZPW");
 SNC_HANDLE_NAMES(lanpower_get, "GLNP");
 SNC_HANDLE_NAMES(lanpower_set, "LNPW");
 
+SNC_HANDLE_NAMES(lidstate_get, "GLID");
+
+SNC_HANDLE_NAMES(indicatorlamp_get, "GILS");
+SNC_HANDLE_NAMES(indicatorlamp_set, "SILS");
+
+SNC_HANDLE_NAMES(gainbass_get, "GMGB");
+SNC_HANDLE_NAMES(gainbass_set, "CMGB");
+
 SNC_HANDLE_NAMES(PID_get, "GPID");
 
 SNC_HANDLE_NAMES(CTR_get, "GCTR");
@@ -507,6 +515,12 @@ static struct sony_nc_value sony_nc_values[] = {
 			boolean_validate, 0),
 	SNC_HANDLE(lanpower, snc_lanpower_get, snc_lanpower_set,
 			boolean_validate, 1),
+	SNC_HANDLE(lidstate, snc_lidstate_get, NULL,
+			boolean_validate, 0),
+	SNC_HANDLE(indicatorlamp, snc_indicatorlamp_get, snc_indicatorlamp_set,
+			boolean_validate, 0),
+	SNC_HANDLE(gainbass, snc_gainbass_get, snc_gainbass_set,
+			boolean_validate, 0),
 	/* unknown methods */
 	SNC_HANDLE(PID, snc_PID_get, NULL, NULL, 1),
 	SNC_HANDLE(CTR, snc_CTR_get, snc_CTR_set, NULL, 1),
-- 
1.5.2.3

