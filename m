From: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/3] Display a DMA error message
Date: Wed, 12 Aug 2015 16:51:29 -0500
Message-ID: <1439416290-21228-3-git-send-email-jeremy.linton@arm.com>
References: <1439416290-21228-1-git-send-email-jeremy.linton@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439416290-21228-1-git-send-email-jeremy.linton-5wv7dgnIgG8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

If the ehci driver fails to configure the dma settings then display
a dev error instead of simply failing. This is triggered in an
ACPI world if the user fails to set the _CCA on the device.

Signed-off-by: Jeremy Linton <jeremy.linton-5wv7dgnIgG8@public.gmane.org>
---
 drivers/usb/host/ehci-platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platf=
orm.c
index 2593def..82e396f 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -162,8 +162,10 @@ static int ehci_platform_probe(struct platform_device =
*dev)
=20
 =09err =3D dma_coerce_mask_and_coherent(&dev->dev,
 =09=09pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
-=09if (err)
+=09if (err) {
+=09=09dev_err(&dev->dev, "Error: DMA setup failed\n");
 =09=09return err;
+=09}
=20
 =09irq =3D platform_get_irq(dev, 0);
 =09if (irq < 0) {
--=20
2.4.3


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
