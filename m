From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH] ACPI: ibm-acpi: do not use / in driver names
Date: Sat, 25 Nov 2006 09:02:14 +0800
Message-ID: <58A36151585E4047913F40517D307BAE0171A5@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45720 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S935105AbWKYBCR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 20:02:17 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net

Yes, that's exactly what I want to change. :)
Thanks.

Best regards,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]=20
Sent: 2006=C4=EA11=D4=C224=C8=D5 22:38
To: Zhang, Rui; Len Brown
Cc: linux-acpi@vger; ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH] ACPI: ibm-acpi: do not use / in driver names

ACPI: ibm-acpi: do not use / in driver names

ibm-acpi uses sub-device names like ibm/hotkey, which get in the way of
a sysfs conversion.  Fix it to use ibm_hotkey instead.  Thanks to Zhang
Rui for noticing this.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

 drivers/acpi/ibm_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 9658253..9baae34 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1854,7 +1854,7 @@ static int __init register_driver(struct
 	}
=20
 	memset(ibm->driver, 0, sizeof(struct acpi_driver));
-	sprintf(ibm->driver->name, "%s/%s", IBM_NAME, ibm->name);
+	sprintf(ibm->driver->name, "%s_%s", IBM_NAME, ibm->name);
 	ibm->driver->ids =3D ibm->hid;
 	ibm->driver->ops.add =3D &ibm_device_add;
=20
--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
