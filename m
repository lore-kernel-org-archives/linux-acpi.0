From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/4] sony-laptop: new style events typo fixes
Date: Wed,  1 Apr 2009 22:10:45 +0900
Message-ID: <1238591447-13338-3-git-send-email-malattia@linux.it>
References: <1238591447-13338-1-git-send-email-malattia@linux.it>
 <1238591447-13338-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56576
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492AbZDANKu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:10:50 -0400
In-Reply-To: <1238591447-13338-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Matthias Welwarsky <matze@welwarsky.de>, Mattia Dongili <malattia@linux.it>

From: Matthias Welwarsky <matze@welwarsky.de>

Signed-off-by: Matthias Welwarsky <matze@welwarsky.de>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5837156..011c035 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -865,7 +865,7 @@ struct sony_nc_event {
 static struct sony_nc_event sony_100_events[] = {
 	{ 0x90, SONYPI_EVENT_PKEY_P1 },
 	{ 0x10, SONYPI_EVENT_ANYBUTTON_RELEASED },
-	{ 0x91, SONYPI_EVENT_PKEY_P1 },
+	{ 0x91, SONYPI_EVENT_PKEY_P2 },
 	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
@@ -929,7 +929,7 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 		if (sony_find_snc_handle(0x127) == ev)
 			key_handle = 0x127;
 
-		if (handle) {
+		if (key_handle) {
 			struct sony_nc_event *key_event;
 
 			if (sony_call_snc_handle(key_handle, 0x200, &result))
-- 
1.6.2.1

