From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 1/6] sony-laptop: Duplicate SNC 127 Event Fix
Date: Sun, 12 Apr 2009 20:26:26 +0900
Message-ID: <1239535591-15514-2-git-send-email-malattia@linux.it>
References: <1239535591-15514-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:41445
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759574AbZDLL0f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Apr 2009 07:26:35 -0400
In-Reply-To: <1239535591-15514-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes a duplicate mapping in the SNC sony_127_events structure.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a90ec5c..a537467 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -905,7 +905,6 @@ static struct sony_nc_event sony_127_events[] = {
 	{ 0x05, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x86, SONYPI_EVENT_PKEY_P5 },
 	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
-	{ 0x06, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x87, SONYPI_EVENT_SETTINGKEY_PRESSED },
 	{ 0x07, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0, 0 },
-- 
1.6.2.2

