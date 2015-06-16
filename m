From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 12/35] drm: i915: Port to new backlight interface selection API
Date: Tue, 16 Jun 2015 16:27:50 +0200
Message-ID: <1434464893-3529-13-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

This results in a nice cleanup, as we can replace the complicated logic
from should_ignore_backlight_request() with a simple check for the type
being native.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/intel_opregion.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_opregion.c b/drivers/gpu/drm/i915/intel_opregion.c
index 71e87ab..4813374 100644
--- a/drivers/gpu/drm/i915/intel_opregion.c
+++ b/drivers/gpu/drm/i915/intel_opregion.c
@@ -396,16 +396,6 @@ int intel_opregion_notify_adapter(struct drm_device *dev, pci_power_t state)
 	return -EINVAL;
 }
 
-/*
- * If the vendor backlight interface is not in use and ACPI backlight interface
- * is broken, do not bother processing backlight change requests from firmware.
- */
-static bool should_ignore_backlight_request(void)
-{
-	return acpi_video_backlight_support() &&
-	       !acpi_video_verify_backlight_support();
-}
-
 static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
@@ -414,7 +404,7 @@ static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
 
 	DRM_DEBUG_DRIVER("bclp = 0x%08x\n", bclp);
 
-	if (should_ignore_backlight_request()) {
+	if (acpi_video_get_backlight_type() == acpi_backlight_native) {
 		DRM_DEBUG_KMS("opregion backlight request ignored\n");
 		return 0;
 	}
-- 
2.3.6
