From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] acpi-video: Add a disable_native_backlight quirk
Date: Thu, 28 Aug 2014 10:20:46 +0200
Message-ID: <1409214048-7331-2-git-send-email-hdegoede@redhat.com>
References: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1409214048-7331-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, =?UTF-8?q?Andre=20M=C3=BCller?= <andre.muller@web.de>, Hohahiu <rakothedin@gmail.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.3.16
List-Id: linux-acpi@vger.kernel.org

Some laptops have a working acpi_video backlight control, and using nat=
ive
backlight on these causes a regression where backlight control does not=
 work
when userspace is not handling brightness key events. Disable native_ba=
cklight
on these to fix this.

https://bugzilla.kernel.org/show_bug.cgi?id=3D81691

Reported-and-tested-by: Andre M=C3=BCller <andre.muller@web.de>
Cc: stable@vger.kernel.org # 3.16
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 58bcf7a..dd5c302 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -417,6 +417,12 @@ static int __init video_set_use_native_backlight(c=
onst struct dmi_system_id *d)
 	return 0;
 }
=20
+static int __init video_disable_native_backlight(const struct dmi_syst=
em_id *d)
+{
+	use_native_backlight_dmi =3D false;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] __initdata =3D {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=3D=
13121
@@ -720,6 +726,30 @@ static struct dmi_system_id video_dmi_table[] __in=
itdata =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8780w"),
 		},
 	},
+
+	/*
+	 * These models have a working acpi_video backlight control, and usin=
g
+	 * native backlight causes a regression where backlight does not work
+	 * when userspace is not handling brightness key events. Disable
+	 * native_backlight on these to fix this:
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=3D81691
+	 */
+	{
+	 .callback =3D video_disable_native_backlight,
+	 .ident =3D "ThinkPad T420",
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T420"),
+		},
+	},
+	{
+	 .callback =3D video_disable_native_backlight,
+	 .ident =3D "ThinkPad T520",
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
+		},
+	},
 	{}
 };
=20
--=20
2.1.0
