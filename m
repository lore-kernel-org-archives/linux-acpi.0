From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 3/3] eeepc-laptop: Update the backlight state when we change brightness
Date: Tue, 14 Jul 2009 17:06:04 +0100
Message-ID: <1247587564-27737-3-git-send-email-mjg@redhat.com>
References: <1247587564-27737-1-git-send-email-mjg@redhat.com>
 <1247587564-27737-2-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755302AbZGNQGT@vger.kernel.org>
In-Reply-To: <1247587564-27737-2-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, rpurdie@rpsys.net, lenb@kernel.org, rui.zhang@intel.com, corentincj@iksaif.net, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Trigger a status update when the user hits a brightness key, allowing
userspace to present appropriate UI.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/eeepc-laptop.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index ec560f1..fde86b3 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -641,7 +641,7 @@ static int notify_brn(void)
 	struct backlight_device *bd = eeepc_backlight_device;
 	if (bd) {
 		int old = bd->props.brightness;
-		bd->props.brightness = read_brightness(bd);
+		backlight_force_update(bd, BACKLIGHT_UPDATE_HOTKEY);
 		return old;
 	}
 	return -1;
-- 
1.6.2.5
