From: =?UTF-8?q?Ozan=20=C3=87a=C4=9Flayan?= <ozan@pardus.org.tr>
Subject: [PATCH] ACPI: video: DMI workaround broken Acer 5710 BIOS enabling display brightness
Date: Mon, 14 Jun 2010 10:17:44 +0300
Message-ID: <1276499864-7609-1-git-send-email-ozan@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lider.pardus.org.tr ([193.140.100.216]:40233 "EHLO
	lider.pardus.org.tr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab0FNH1R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Jun 2010 03:27:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

Acer Aspire 5710 suffers from a similar ACPI problem reported at:
 http://bugzilla.kernel.org/show_bug.cgi?id=3D13121

like the 5710Z and 7720.

Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozan@pardus.org.tr>
---
 drivers/acpi/video.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9865d46..e2436d1 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -571,6 +571,14 @@ static struct dmi_system_id video_dmi_table[] __in=
itdata =3D {
 	},
 	{
 	 .callback =3D video_set_bqc_offset,
+	 .ident =3D "Acer Aspire 5710",
+	 .matches =3D {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+		},
+	},
+	{
+	 .callback =3D video_set_bqc_offset,
 	 .ident =3D "Acer Aspire 5710Z",
 	 .matches =3D {
 		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
--=20
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
