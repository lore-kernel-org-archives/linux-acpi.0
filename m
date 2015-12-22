From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] thinkpad_acpi: Use acpi_video_handles_brightness_key_presses()
Date: Tue, 22 Dec 2015 19:09:50 +0100
Message-ID: <1450807792-4980-4-git-send-email-hdegoede@redhat.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Use the new acpi_video_handles_brightness_key_presses function to check
if we should report brightness key-presses.

This makes the code both easier to read and makes it properly report
key-presses when acpi-video is not reporting them for reasons other
then the backlight type being vendor.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 0bed473..f453d5d 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3488,7 +3488,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	/* Do not issue duplicate brightness change events to
 	 * userspace. tpacpi_detect_brightness_capabilities() must have
 	 * been called before this point  */
-	if (acpi_video_get_backlight_type() != acpi_backlight_vendor) {
+	if (acpi_video_handles_brightness_key_presses()) {
 		pr_info("This ThinkPad has standard ACPI backlight "
 			"brightness control, supported by the ACPI "
 			"video driver\n");
-- 
2.5.0
