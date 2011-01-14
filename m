From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: [PATCH 4/5] nouveau: Change the backlight parent device to the
 connector, not the PCI dev
Date: Fri, 14 Jan 2011 21:30:19 +0200
Message-ID: <AANLkTikLsie3YNQHQR8Boaj22DLuWpqZJ0JkGqf-uCtd@mail.gmail.com>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-4-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45110 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab1ANTaU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Jan 2011 14:30:20 -0500
In-Reply-To: <1295033065-13450-4-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net

On Fri, Jan 14, 2011 at 9:24 PM, Matthew Garrett <mjg@redhat.com> wrote=
:
> We may eventually end up with per-connector backlights, especially wi=
th
> ddcci devices. Make sure that the parent node for the backlight devic=
e is
> the connector rather than the PCI device.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> =A0drivers/gpu/drm/nouveau/nouveau_backlight.c | =A0 24 +++++++++++++=
+----------
> =A0drivers/gpu/drm/nouveau/nouveau_connector.c | =A0 =A09 +++++++++
> =A0drivers/gpu/drm/nouveau/nouveau_drv.h =A0 =A0 =A0 | =A0 =A08 ++++-=
---
> =A0drivers/gpu/drm/nouveau/nouveau_state.c =A0 =A0 | =A0 =A06 ------
> =A04 files changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gp=
u/drm/nouveau/nouveau_backlight.c
> index 18d7bcc..00a55df 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -88,10 +88,11 @@ static const struct backlight_ops nv50_bl_ops =3D=
 {
> =A0 =A0 =A0 =A0.update_status =3D nv50_set_intensity,
> =A0};
>
> -static int nouveau_nv40_backlight_init(struct drm_device *dev)
> +static int nouveau_nv40_backlight_init(struct drm_connector *connect=
or)
> =A0{
> - =A0 =A0 =A0 struct backlight_properties props;
> + =A0 =A0 =A0 struct drm_device *dev =3D connector->dev;
> =A0 =A0 =A0 =A0struct drm_nouveau_private *dev_priv =3D dev->dev_priv=
ate;
> + =A0 =A0 =A0 struct backlight_properties props;
> =A0 =A0 =A0 =A0struct backlight_device *bd;
>
> =A0 =A0 =A0 =A0if (!(nv_rd32(dev, NV40_PMC_BACKLIGHT) & NV40_PMC_BACK=
LIGHT_MASK))
> @@ -100,7 +101,7 @@ static int nouveau_nv40_backlight_init(struct drm=
_device *dev)
> =A0 =A0 =A0 =A0memset(&props, 0, sizeof(struct backlight_properties))=
;
> =A0 =A0 =A0 =A0props.type =3D BACKLIGHT_RAW;
> =A0 =A0 =A0 =A0props.max_brightness =3D 31;
> - =A0 =A0 =A0 bd =3D backlight_device_register("nv_backlight", &dev->=
pdev->dev, dev,
> + =A0 =A0 =A0 bd =3D backlight_device_register("nv_backlight", &conne=
ctor->kdev, dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &nv40_bl_ops, &props);
> =A0 =A0 =A0 =A0if (IS_ERR(bd))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(bd);
> @@ -112,10 +113,11 @@ static int nouveau_nv40_backlight_init(struct d=
rm_device *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int nouveau_nv50_backlight_init(struct drm_device *dev)
> +static int nouveau_nv50_backlight_init(struct drm_connector *connect=
or)
> =A0{
> - =A0 =A0 =A0 struct backlight_properties props;
> + =A0 =A0 =A0 struct drm_device *dev =3D connector->dev;
> =A0 =A0 =A0 =A0struct drm_nouveau_private *dev_priv =3D dev->dev_priv=
ate;
> + =A0 =A0 =A0 struct backlight_properties props;
> =A0 =A0 =A0 =A0struct backlight_device *bd;
>
> =A0 =A0 =A0 =A0if (!nv_rd32(dev, NV50_PDISPLAY_SOR_BACKLIGHT))
> @@ -124,7 +126,7 @@ static int nouveau_nv50_backlight_init(struct drm=
_device *dev)
> =A0 =A0 =A0 =A0memset(&props, 0, sizeof(struct backlight_properties))=
;
> =A0 =A0 =A0 =A0props.type =3D BACKLIGHT_RAW;
> =A0 =A0 =A0 =A0props.max_brightness =3D 1025;
> - =A0 =A0 =A0 bd =3D backlight_device_register("nv_backlight", &dev->=
pdev->dev, dev,
> + =A0 =A0 =A0 bd =3D backlight_device_register("nv_backlight", &conne=
ctor->kdev, dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &nv50_bl_ops, &props);
> =A0 =A0 =A0 =A0if (IS_ERR(bd))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTR_ERR(bd);
> @@ -135,8 +137,9 @@ static int nouveau_nv50_backlight_init(struct drm=
_device *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -int nouveau_backlight_init(struct drm_device *dev)
> +int nouveau_backlight_init(struct drm_connector *connector)
> =A0{
> + =A0 =A0 =A0 struct drm_device *dev =3D connector->dev;
> =A0 =A0 =A0 =A0struct drm_nouveau_private *dev_priv =3D dev->dev_priv=
ate;
>
> =A0#ifdef CONFIG_ACPI
> @@ -149,9 +152,9 @@ int nouveau_backlight_init(struct drm_device *dev=
)
>
> =A0 =A0 =A0 =A0switch (dev_priv->card_type) {
> =A0 =A0 =A0 =A0case NV_40:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return nouveau_nv40_backlight_init(dev)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return nouveau_nv40_backlight_init(conn=
ector);
> =A0 =A0 =A0 =A0case NV_50:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return nouveau_nv50_backlight_init(dev)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return nouveau_nv50_backlight_init(conn=
ector);
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> @@ -159,8 +162,9 @@ int nouveau_backlight_init(struct drm_device *dev=
)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -void nouveau_backlight_exit(struct drm_device *dev)
> +void nouveau_backlight_exit(struct drm_connector *connector)
> =A0{
> + =A0 =A0 =A0 struct drm_device *dev =3D connector->dev;
> =A0 =A0 =A0 =A0struct drm_nouveau_private *dev_priv =3D dev->dev_priv=
ate;
>
> =A0 =A0 =A0 =A0if (dev_priv->backlight) {
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gp=
u/drm/nouveau/nouveau_connector.c
> index a21e000..3a1ecc7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -116,6 +116,10 @@ nouveau_connector_destroy(struct drm_connector *=
connector)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0nouveau_connector_hotplug, connector);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR=
_LVDS ||
> + =A0 =A0 =A0 =A0 =A0 connector->connector_type =3D=3D DRM_MODE_CONNE=
CTOR_eDP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nouveau_backlight_exit(connector);
> +
> =A0 =A0 =A0 =A0kfree(nv_connector->edid);
> =A0 =A0 =A0 =A0drm_sysfs_connector_remove(connector);
> =A0 =A0 =A0 =A0drm_connector_cleanup(connector);
> @@ -893,6 +897,11 @@ nouveau_connector_create(struct drm_device *dev,=
 int index)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0drm_sysfs_connector_add(connector);
> +
> + =A0 =A0 =A0 if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR=
_LVDS ||
> + =A0 =A0 =A0 =A0 =A0 connector->connector_type =3D=3D DRM_MODE_CONNE=
CTOR_eDP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 nouveau_backlight_init(connector);
> +
> =A0 =A0 =A0 =A0dcb->drm =3D connector;
> =A0 =A0 =A0 =A0return dcb->drm;
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/=
nouveau/nouveau_drv.h
> index 46e3257..1918ed1 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_drv.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
> @@ -999,15 +999,15 @@ static inline int nouveau_acpi_edid(struct drm_=
device *dev, struct drm_connector
>
> =A0/* nouveau_backlight.c */
> =A0#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> -extern int nouveau_backlight_init(struct drm_device *);
> -extern void nouveau_backlight_exit(struct drm_device *);
> +extern int nouveau_backlight_init(struct drm_connector *);
> +extern void nouveau_backlight_exit(struct drm_connector *);
> =A0#else
> -static inline int nouveau_backlight_init(struct drm_device *dev)
> +static inline int nouveau_backlight_init(struct drm_connector *dev)
> =A0{
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static inline void nouveau_backlight_exit(struct drm_device *dev) { =
}
> +static inline void nouveau_backlight_exit(struct drm_connector *dev)=
 { }
> =A0#endif
>
> =A0/* nouveau_bios.c */
> diff --git a/drivers/gpu/drm/nouveau/nouveau_state.c b/drivers/gpu/dr=
m/nouveau/nouveau_state.c
> index a54fc43..f688f04 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_state.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_state.c
> @@ -738,10 +738,6 @@ nouveau_card_init(struct drm_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_fence;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D nouveau_backlight_init(dev);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 NV_ERROR(dev, "Error %d registering bac=
klight\n", ret);
> -
> =A0 =A0 =A0 =A0nouveau_fbcon_init(dev);
> =A0 =A0 =A0 =A0drm_kms_helper_poll_init(dev);
> =A0 =A0 =A0 =A0return 0;
> @@ -793,8 +789,6 @@ static void nouveau_card_takedown(struct drm_devi=
ce *dev)
> =A0 =A0 =A0 =A0struct drm_nouveau_private *dev_priv =3D dev->dev_priv=
ate;
> =A0 =A0 =A0 =A0struct nouveau_engine *engine =3D &dev_priv->engine;
>
> - =A0 =A0 =A0 nouveau_backlight_exit(dev);
> -
> =A0 =A0 =A0 =A0if (!engine->graph.accel_blocked) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nouveau_fence_fini(dev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nouveau_channel_put_unlocked(&dev_priv=
->channel);
> --
> 1.7.3.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

Hi Matthew Garrett,
I have problems with nouveau.
Do you know ?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
