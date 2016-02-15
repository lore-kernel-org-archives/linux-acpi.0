From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / video: remove unused device_decode
Date: Mon, 15 Feb 2016 22:40:04 +0000
Message-ID: <1455576004-11839-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

=46rom: Colin Ian King <colin.king@canonical.com>

device_decode is now no longer used, so we may as well remove it.
=46ixes gcc 6 warning:

drivers/acpi/acpi_video.c:221:19: warning: =E2=80=98device_decode=E2=80=
=99 defined
 but not used [-Wunused-const-variable]
 static const char device_decode[][30] =3D {
                   ^~~~~~~~~~~~~

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/acpi_video.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index a76f8be..4361bc9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -218,13 +218,6 @@ struct acpi_video_device {
 	struct thermal_cooling_device *cooling_dev;
 };
=20
-static const char device_decode[][30] =3D {
-	"motherboard VGA device",
-	"PCI VGA device",
-	"AGP VGA device",
-	"UNKNOWN",
-};
-
 static void acpi_video_device_notify(acpi_handle handle, u32 event, vo=
id *data);
 static void acpi_video_device_rebind(struct acpi_video_bus *video);
 static void acpi_video_device_bind(struct acpi_video_bus *video,
--=20
2.7.0
