From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 6/6] fix compile time warning in acpi video.c
Date: Thu, 2 Nov 2006 13:32:08 +0000 (UTC)
Message-ID: <200611042130.34677.luming.yu__15364.7646926858$1162474328$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:23917 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752870AbWKBNbZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 08:31:25 -0500
Received: by py-out-1112.google.com with SMTP id a73so103042pye
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 05:30:52 -0800 (PST)
Date: Sat, 4 Nov 2006 21:30:34 +0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>

fix compile time warning in acpi video.c

signed-off-by =A0 Luming.yu@gmail.com
---
[patch 6/6] fix compile time warning
 video.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 4ad109f..4a2520b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -560,13 +560,11 @@ static void acpi_pci_data_handler(acpi_h
=20
 static struct acpi_pci_data * acpi_pci_get (struct acpi_device *device=
)
 {
-	int result =3D 0;
 	acpi_status status =3D AE_OK;
 	struct acpi_pci_data *data =3D NULL;
 	struct acpi_pci_data *pdata =3D NULL;
 	char *pathname =3D NULL;
 	struct acpi_buffer buffer =3D { 0, NULL };
-	acpi_handle handle =3D NULL;
 	struct pci_dev *dev;
 	struct pci_bus *bus;
=20
@@ -576,7 +574,7 @@ static struct acpi_pci_data * acpi_pci_g
=20
 	pathname =3D kmalloc(ACPI_PATHNAME_MAX, GFP_KERNEL);
 	if (!pathname)
-		return -ENOMEM;
+		return NULL;
 	memset(pathname, 0, ACPI_PATHNAME_MAX);
 	buffer.length =3D ACPI_PATHNAME_MAX;
 	buffer.pointer =3D pathname;
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
