From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 5/5] eeepc-laptop: disable wireless hotplug for 1201N
Date: Wed,  6 Jan 2010 22:07:41 +0100
Message-ID: <1262812061-4119-6-git-send-email-corentincj@iksaif.net>
References: <1262812061-4119-1-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-2-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-3-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-4-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-5-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:34107 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932820Ab0AFVHs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jan 2010 16:07:48 -0500
In-Reply-To: <1262812061-4119-5-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 8ee0cd1..a0bad0f 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1277,7 +1277,7 @@ static void eeepc_dmi_check(struct eeepc_laptop *eeepc)
 	 * hotplug code. In fact, current hotplug code seems to unplug another
 	 * device...
 	 */
-	if (strcmp(model, "1005HA") == 0) {
+	if (strcmp(model, "1005HA") == 0 || strcmp(model, "1201N") == 0) {
 		eeepc->hotplug_disabled = true;
 		pr_info("wlan hotplug disabled\n");
 	}
-- 
1.6.6

