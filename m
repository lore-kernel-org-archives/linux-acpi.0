From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] acpi-video: Add quirks for the Dell Vostro V131
Date: Tue, 22 Dec 2015 19:09:52 +0100
Message-ID: <1450807792-4980-6-git-send-email-hdegoede@redhat.com>
References: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbbLVSKl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2015 13:10:41 -0500
In-Reply-To: <1450807792-4980-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Darren Hart <dvhart@infradead.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

The Dell Vostro V131 has an especially broken acpi-video implementation=
=2E

The backlight control bits work, but when the brightness is changed via
the acpi-video interface the backlight flickers annoyingly before settl=
ing
at the new brightness, switching to using the native interface fixes th=
e
flickering so add a quirk for this (the vendor interface has the same
problem).

Brightness keypresses reported through the acpi-video-bus are also brok=
en,
they get reported one event delayed, so if you press the brightness-up
hotkey on the keyboard nothing happens, then if you press brightness-do=
wn,
the previous brightness-up event gets reported. Since the keypresses ar=
e
also reported via wmi (if active) and via atkbd (when wmi is not active=
)
add a quirk to simply filter out the delayed (broken) events.

Reported-and-tested-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl=
>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c   | 25 +++++++++++++++++++++++++
 drivers/acpi/video_detect.c |  8 ++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 2971154..80b13d4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -419,6 +419,13 @@ static int video_enable_only_lcd(const struct dmi_=
system_id *d)
 	return 0;
 }
=20
+static int video_set_report_key_events(const struct dmi_system_id *id)
+{
+	if (report_key_events =3D=3D -1)
+		report_key_events =3D (uintptr_t)id->driver_data;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] =3D {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=3D=
13121
@@ -507,6 +514,24 @@ static struct dmi_system_id video_dmi_table[] =3D =
{
 		DMI_MATCH(DMI_PRODUCT_NAME, "ESPRIMO Mobile M9410"),
 		},
 	},
+	/*
+	 * Some machines report wrong key events on the acpi-bus, suppress
+	 * key event reporting on these.  Note this is only intended to work
+	 * around events which are plain wrong. In some cases we get double
+	 * events, in this case acpi-video is considered the canonical source
+	 * and the events from the other source should be filtered. E.g.
+	 * by calling acpi_video_handles_brightness_key_presses() from the
+	 * vendor acpi/wmi driver or by using /lib/udev/hwdb.d/60-keyboard.hw=
db
+	 */
+	{
+	 .callback =3D video_set_report_key_events,
+	 .driver_data =3D (void *)((uintptr_t)REPORT_OUTPUT_KEY_EVENTS),
+	 .ident =3D "Dell Vostro V131",
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
+		},
+	},
 	{}
 };
=20
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index daaf1c4..8fe2682 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -279,6 +279,14 @@ static const struct dmi_system_id video_detect_dmi=
_table[] =3D {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
 		},
 	},
+	{
+	 .callback =3D video_detect_force_native,
+	 .ident =3D "Dell Vostro V131",
+	 .matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
+		},
+	},
 	{ },
 };
=20
--=20
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
