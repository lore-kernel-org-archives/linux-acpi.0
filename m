From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] acpi-video: Add use native backlight quirk for the ThinkPad W530
Date: Thu, 15 May 2014 20:34:26 +0200
Message-ID: <1400178866-3659-5-git-send-email-hdegoede@redhat.com>
References: <1400178866-3659-1-git-send-email-hdegoede@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1400178866-3659-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Like all of the other *30 ThinkPad models, the W530 has a broken acpi-video
backlight control. Note in order for this to actually fix things on the
ThinkPad W530 the commit titled:
"nouveau: Don't check acpi_video_backlight_support() before registering backlight"
is also needed.

https://bugzilla.redhat.com/show_bug.cgi?id=1093171

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 123f919..0fec70d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -523,6 +523,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		},
 	},
 	{
+	 .callback = video_set_use_native_backlight,
+	 .ident = "ThinkPad W530",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad W530"),
+		},
+	},
+	{
 	.callback = video_set_use_native_backlight,
 	.ident = "ThinkPad X1 Carbon",
 	.matches = {
-- 
1.9.0
