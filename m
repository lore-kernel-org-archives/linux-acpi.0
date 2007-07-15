From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/7] sony-laptop: map wireless switch events to KEY_WLAN
Date: Mon, 16 Jul 2007 02:34:34 +0900
Message-ID: <11845208793336-git-send-email-malattia@linux.it>
References: <1184520879452-git-send-email-malattia@linux.it>
 <1184520879991-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:37808 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbXGORe6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:34:58 -0400
In-Reply-To: <1184520879991-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 2063de7..9e27616 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -177,6 +177,8 @@ static struct {
 	{ SONYPI_EVENT_BACK_PRESSED, 		KEY_BACK },
 	{ SONYPI_EVENT_HELP_PRESSED, 		KEY_HELP },
 	{ SONYPI_EVENT_ZOOM_PRESSED, 		KEY_ZOOM },
+	{ SONYPI_EVENT_WIRELESS_ON, 		KEY_WLAN },
+	{ SONYPI_EVENT_WIRELESS_OFF, 		KEY_WLAN },
 	{ SONYPI_EVENT_THUMBPHRASE_PRESSED, 	BTN_THUMB },
 	{ 0, 0 },
 };
-- 
1.5.2.3

