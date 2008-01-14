From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/6] sony-laptop: fix scancode decode
Date: Mon, 14 Jan 2008 18:05:46 +0900
Message-ID: <1200301546-6079-7-git-send-email-malattia@linux.it>
References: <1200301546-6079-1-git-send-email-malattia@linux.it>
 <1200301546-6079-2-git-send-email-malattia@linux.it>
 <1200301546-6079-3-git-send-email-malattia@linux.it>
 <1200301546-6079-4-git-send-email-malattia@linux.it>
 <1200301546-6079-5-git-send-email-malattia@linux.it>
 <1200301546-6079-6-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:56292 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYANJMc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jan 2008 04:12:32 -0500
In-Reply-To: <1200301546-6079-6-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

compare against the sony_laptop specific event list index
to decode the input scancode to send.

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 70d5cc5..899e3f7 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -315,7 +315,7 @@ static void sony_laptop_report_input_event(u8 event)
 		break;
 
 	default:
-		if (event > ARRAY_SIZE (sony_laptop_input_keycode_map)) {
+		if (event > ARRAY_SIZE(sony_laptop_input_index)) {
 			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
 			break;
 		}
-- 
1.5.3.7

