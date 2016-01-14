From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] Revert "thinkpad_acpi: Use acpi_video_handles_brightness_key_presses()"
Date: Thu, 14 Jan 2016 09:41:48 +0100
Message-ID: <1452760908-15965-4-git-send-email-hdegoede@redhat.com>
References: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbcANImM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 03:42:12 -0500
In-Reply-To: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Adrien Schildknecht <adrien+dev@schischi.me>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

acpi_video_handles_brightness_key_presses()'s may return false if the i915
driver is not loaded yet when thinkpad_acpi loads, and then return true
after the i915 driver has loaded. This means that thinkpad_acpi cannot
use it as is since thinkpad_acpi caches the return value.

This reverts commit 7714687a2b2d ("thinkpad_acpi: Use
acpi_video_handles_brightness_key_presses()").

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f453d5d..0bed473 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3488,7 +3488,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* Do not issue duplicate brightness change events to
 	 * userspace. tpacpi_detect_brightness_capabilities() must have
 	 * been called before this point  */
-	if (acpi_video_handles_brightness_key_presses()) {
+	if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
 		pr_info("This ThinkPad has standard ACPI backlight "
 			"brightness control, supported by the ACPI "
 			"video driver\n");
-- 
2.5.0

