From: Lan Tianyu <tianyu.lan@intel.com>
Subject: =?UTF-8?q?=5BFIX=20PATCH=5D=20ACPI=20/=20PM=3A=20Add=20Sony=20Vaio=20VPCEB1S1E=20to=20nonvs=20blacklist=2E?=
Date: Thu,  8 Nov 2012 09:33:45 +0800
Message-ID: <1352338425-4830-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50378 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363Ab2KHBhm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 20:37:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, swilmet@gnome.org, stable@vger.kernel.org

Sony Vaio VPCEB1S1E does not resume correctly without
acpi_sleep=3Dnonvs, so add it to the ACPI sleep blacklist.

https://bugzilla.kernel.org/show_bug.cgi?id=3D48781

Reported-by: S=C3=A9bastien Wilmet <swilmet@gnome.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sleep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index fdcdbb6..847ed55 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -519,6 +519,14 @@ static struct dmi_system_id __initdata acpisleep_d=
mi_table[] =3D {
 	},
 	{
 	.callback =3D init_nvs_nosave,
+	.ident =3D "Sony Vaio VPCEB1S1E",
+	.matches =3D {
+		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEB1S1E"),
+		},
+	},
+	{
+	.callback =3D init_nvs_nosave,
 	.ident =3D "Sony Vaio VGN-FW520F",
 	.matches =3D {
 		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
