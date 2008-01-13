From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/6] sony-laptop: fix scancode decode
Date: Sun, 13 Jan 2008 13:23:32 +0900
Message-ID: <1200198212-10526-7-git-send-email-malattia@linux.it>
References: <1200198212-10526-1-git-send-email-malattia@linux.it>
 <1200198212-10526-2-git-send-email-malattia@linux.it>
 <1200198212-10526-3-git-send-email-malattia@linux.it>
 <1200198212-10526-4-git-send-email-malattia@linux.it>
 <1200198212-10526-5-git-send-email-malattia@linux.it>
 <1200198212-10526-6-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:35157 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbYAMEXu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 23:23:50 -0500
In-Reply-To: <1200198212-10526-6-git-send-email-malattia@linux.it>
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
index 4089751..96157f7 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -315,7 +315,7 @@ static void sony_laptop_report_input_event(u8 event)
 		break;
 
 	default:
-		if (event > ARRAY_SIZE (sony_laptop_input_keycode_map)) {
+		if (event > ARRAY_SIZE (sony_laptop_input_index)) {
 			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
 			break;
 		}
-- 
1.5.3.7

