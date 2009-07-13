From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] eeepc-laptop: Update the backlight state when we change brightness
Date: Mon, 13 Jul 2009 21:41:25 +0100
Message-ID: <1247517685-7719-3-git-send-email-mjg@redhat.com>
References: <1247517685-7719-1-git-send-email-mjg@redhat.com>
 <1247517685-7719-2-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58755 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbZGMUlf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jul 2009 16:41:35 -0400
In-Reply-To: <1247517685-7719-2-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net, Matthew Garrett <mjg@redhat.com>

Trigger a status update when the user hits a brightness key, allowing
userspace to present appropriate UI.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/eeepc-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ec560f1..832db81 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -641,7 +641,7 @@ static int notify_brn(void)
 	struct backlight_device *bd = eeepc_backlight_device;
 	if (bd) {
 		int old = bd->props.brightness;
-		bd->props.brightness = read_brightness(bd);
+		backlight_force_update(bd);
 		return old;
 	}
 	return -1;
-- 
1.6.2.5

