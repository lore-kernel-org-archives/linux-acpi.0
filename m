From: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 3/3] Add ACPI bindings for the EHCI platform driver.
Date: Wed, 12 Aug 2015 16:51:30 -0500
Message-ID: <1439416290-21228-4-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439416290-21228-1-git-send-email-jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This enables USB on the ARM juno board when booted with
an ACPI kernel. The PNP id comes from the PNP/ACPI registry
and describes a EHCI controller without debug.

Signed-off-by: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
---
 drivers/usb/host/ehci-platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platf=
orm.c
index 82e396f..1807baa 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
@@ -382,6 +383,13 @@ static const struct of_device_id vt8500_ehci_ids[] =3D=
 {
 };
 MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
=20
+static const struct acpi_device_id ehci_acpi_match[] =3D {
+=09{ "PNP0D20", 0 },
+=09{ }
+};
+MODULE_DEVICE_TABLE(acpi, ehci_acpi_match);
+
+
 static const struct platform_device_id ehci_platform_table[] =3D {
 =09{ "ehci-platform", 0 },
 =09{ }
@@ -400,6 +408,7 @@ static struct platform_driver ehci_platform_driver =3D =
{
 =09=09.name=09=3D "ehci-platform",
 =09=09.pm=09=3D &ehci_platform_pm_ops,
 =09=09.of_match_table =3D vt8500_ehci_ids,
+=09=09.acpi_match_table =3D ACPI_PTR(ehci_acpi_match),
 =09}
 };
=20
--=20
2.4.3


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
