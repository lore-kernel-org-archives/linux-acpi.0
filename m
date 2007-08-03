From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/3] sony-laptop: sony_nc_ids[] can become static.
Date: Sat,  4 Aug 2007 00:22:31 +0900
Message-ID: <11861545523738-git-send-email-malattia@linux.it>
References: <118615455219-git-send-email-malattia@linux.it>
 <1186154552588-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:62358 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762352AbXHCPXK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Aug 2007 11:23:10 -0400
In-Reply-To: <1186154552588-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Adrian Bunk <bunk@stusta.de>, Mattia Dongili <malattia@linux.it>

From: Adrian Bunk <bunk@stusta.de>

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index a1be82e..99f48c7 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -845,7 +845,7 @@ static struct sony_nc_event sony_C_events[] = {
 };
 
 /* SNC-only model map */
-struct dmi_system_id sony_nc_ids[] = {
+static struct dmi_system_id sony_nc_ids[] = {
 		{
 			.ident = "Sony Vaio FE Series",
 			.callback = sony_nc_C_enable,
-- 
1.5.2.4

