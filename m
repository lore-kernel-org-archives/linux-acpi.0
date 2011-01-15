From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 3/5] radeon: Expose backlight class device for legacy LVDS encoder
Date: Sat, 15 Jan 2011 12:34:52 -0500
Message-ID: <AANLkTikHTnu4OD8PNH+1B8ZcQSm7W1gGq6pAeSWN===q@mail.gmail.com>
References: <1295033065-13450-1-git-send-email-mjg@redhat.com>
	<1295033065-13450-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57557 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab1AORfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jan 2011 12:35:03 -0500
In-Reply-To: <1295033065-13450-3-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: akpm@linux-foundation.org, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, rpurdie@rpsys.net, =?ISO-8859-1?Q?Michel_D=E4nzer?= <daenzer@vmware.com>, intel-gfx@lists.freedesktop.org

On Fri, Jan 14, 2011 at 2:24 PM, Matthew Garrett <mjg@redhat.com> wrote=
:
> From: Michel D=E4nzer <michel@daenzer.net>
>
> Allows e.g. power management daemons to control the backlight level. =
Inspired
> by the corresponding code in radeonfb.
>
> (Updated to add backlight type and make the connector the parent devi=
ce - mjg)
>
> Signed-off-by: Michel D=E4nzer <daenzer@vmware.com>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>

Acked-by: Alex Deucher <alexdeucher@gmail.com>

> Cc: dri-devel@lists.freedesktop.org
> ---
> =A0drivers/gpu/drm/radeon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +
> =A0drivers/gpu/drm/radeon/radeon_connectors.c =A0 =A0 =A0| =A0 15 ++
> =A0drivers/gpu/drm/radeon/radeon_legacy_encoders.c | =A0257 +++++++++=
+++++++++++++-
> =A0drivers/gpu/drm/radeon/radeon_mode.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
10 +
> =A04 files changed, 277 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/=
Kconfig
> index 1c02d23..9746fee 100644
> --- a/drivers/gpu/drm/radeon/Kconfig
> +++ b/drivers/gpu/drm/radeon/Kconfig
> @@ -1,6 +1,7 @@
> =A0config DRM_RADEON_KMS
> =A0 =A0 =A0 =A0bool "Enable modesetting on radeon by default - NEW DR=
IVER"
> =A0 =A0 =A0 =A0depends on DRM_RADEON
> + =A0 =A0 =A0 select BACKLIGHT_CLASS_DEVICE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Choose this option if you want kernel modesetting =
enabled by default.
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu=
/drm/radeon/radeon_connectors.c
> index 22b7e3d..e842fb5 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -40,6 +40,10 @@ radeon_atombios_connected_scratch_regs(struct drm_=
connector *connector,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct drm_encoder *encoder,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bool connected);
>
> +extern void
> +radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct drm_c=
onnector *drm_connector);
> +
> =A0void radeon_connector_hotplug(struct drm_connector *connector)
> =A0{
> =A0 =A0 =A0 =A0struct drm_device *dev =3D connector->dev;
> @@ -1517,6 +1521,17 @@ radeon_add_legacy_connector(struct drm_device =
*dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connector->polled =3D DRM_CONNECTOR_PO=
LL_HPD;
> =A0 =A0 =A0 =A0connector->display_info.subpixel_order =3D subpixel_or=
der;
> =A0 =A0 =A0 =A0drm_sysfs_connector_add(connector);
> + =A0 =A0 =A0 if (connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct drm_encoder *drm_encoder;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(drm_encoder, &dev->=
mode_config.encoder_list, head) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder *=
radeon_encoder;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 radeon_encoder =3D to_r=
adeon_encoder(drm_encoder);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (radeon_encoder->enc=
oder_id =3D=3D ENCODER_OBJECT_ID_INTERNAL_LVDS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 radeon_=
legacy_backlight_init(radeon_encoder, connector);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return;
>
> =A0failed:
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/driver=
s/gpu/drm/radeon/radeon_legacy_encoders.c
> index 59f834b..ba7dcc6 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> @@ -28,6 +28,10 @@
> =A0#include "radeon_drm.h"
> =A0#include "radeon.h"
> =A0#include "atom.h"
> +#include <linux/backlight.h>
> +#ifdef CONFIG_PMAC_BACKLIGHT
> +#include <asm/backlight.h>
> +#endif
>
> =A0static void radeon_legacy_encoder_disable(struct drm_encoder *enco=
der)
> =A0{
> @@ -39,7 +43,7 @@ static void radeon_legacy_encoder_disable(struct dr=
m_encoder *encoder)
> =A0 =A0 =A0 =A0radeon_encoder->active_device =3D 0;
> =A0}
>
> -static void radeon_legacy_lvds_dpms(struct drm_encoder *encoder, int=
 mode)
> +static void radeon_legacy_lvds_update(struct drm_encoder *encoder, i=
nt mode)
> =A0{
> =A0 =A0 =A0 =A0struct drm_device *dev =3D encoder->dev;
> =A0 =A0 =A0 =A0struct radeon_device *rdev =3D dev->dev_private;
> @@ -47,15 +51,23 @@ static void radeon_legacy_lvds_dpms(struct drm_en=
coder *encoder, int mode)
> =A0 =A0 =A0 =A0uint32_t lvds_gen_cntl, lvds_pll_cntl, pixclks_cntl, d=
isp_pwr_man;
> =A0 =A0 =A0 =A0int panel_pwr_delay =3D 2000;
> =A0 =A0 =A0 =A0bool is_mac =3D false;
> + =A0 =A0 =A0 uint8_t backlight_level;
> =A0 =A0 =A0 =A0DRM_DEBUG_KMS("\n");
>
> + =A0 =A0 =A0 lvds_gen_cntl =3D RREG32(RADEON_LVDS_GEN_CNTL);
> + =A0 =A0 =A0 backlight_level =3D (lvds_gen_cntl >> RADEON_LVDS_BL_MO=
D_LEVEL_SHIFT) & 0xff;
> +
> =A0 =A0 =A0 =A0if (radeon_encoder->enc_priv) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rdev->is_atom_bios) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct radeon_encoder_=
atom_dig *lvds =3D radeon_encoder->enc_priv;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0panel_pwr_delay =3D lv=
ds->panel_pwr_delay;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lvds->bl_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlig=
ht_level =3D lvds->backlight_level;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct radeon_encoder_=
lvds *lvds =3D radeon_encoder->enc_priv;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0panel_pwr_delay =3D lv=
ds->panel_pwr_delay;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (lvds->bl_dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlig=
ht_level =3D lvds->backlight_level;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -82,11 +94,13 @@ static void radeon_legacy_lvds_dpms(struct drm_en=
coder *encoder, int mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lvds_pll_cntl &=3D ~RADEON_LVDS_PLL_RE=
SET;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WREG32(RADEON_LVDS_PLL_CNTL, lvds_pll_=
cntl);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl =3D RREG32(RADEON_LVDS_GE=
N_CNTL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl |=3D (RADEON_LVDS_ON | RA=
DEON_LVDS_EN | RADEON_LVDS_DIGON | RADEON_LVDS_BLON);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl &=3D ~(RADEON_LVDS_DISPLA=
Y_DIS |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
RADEON_LVDS_BL_MOD_LEVEL_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl |=3D (RADEON_LVDS_ON | RA=
DEON_LVDS_EN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RAD=
EON_LVDS_DIGON | RADEON_LVDS_BLON |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ba=
cklight_level << RADEON_LVDS_BL_MOD_LEVEL_SHIFT));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_mac)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lvds_gen_cntl |=3D RAD=
EON_LVDS_BL_MOD_EN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl &=3D ~(RADEON_LVDS_DISPLA=
Y_DIS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(panel_pwr_delay * 1000);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WREG32(RADEON_LVDS_GEN_CNTL, lvds_gen_=
cntl);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> @@ -95,7 +109,6 @@ static void radeon_legacy_lvds_dpms(struct drm_enc=
oder *encoder, int mode)
> =A0 =A0 =A0 =A0case DRM_MODE_DPMS_OFF:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pixclks_cntl =3D RREG32_PLL(RADEON_PIX=
CLKS_CNTL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WREG32_PLL_P(RADEON_PIXCLKS_CNTL, 0, ~=
RADEON_PIXCLK_LVDS_ALWAYS_ONb);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds_gen_cntl =3D RREG32(RADEON_LVDS_GE=
N_CNTL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lvds_gen_cntl |=3D RADEON_LVDS_DISPLAY=
_DIS;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (is_mac) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lvds_gen_cntl &=3D ~RA=
DEON_LVDS_BL_MOD_EN;
> @@ -119,6 +132,25 @@ static void radeon_legacy_lvds_dpms(struct drm_e=
ncoder *encoder, int mode)
>
> =A0}
>
> +static void radeon_legacy_lvds_dpms(struct drm_encoder *encoder, int=
 mode)
> +{
> + =A0 =A0 =A0 struct radeon_device *rdev =3D encoder->dev->dev_privat=
e;
> + =A0 =A0 =A0 struct radeon_encoder *radeon_encoder =3D to_radeon_enc=
oder(encoder);
> + =A0 =A0 =A0 DRM_DEBUG("\n");
> +
> + =A0 =A0 =A0 if (radeon_encoder->enc_priv) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->is_atom_bios) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_a=
tom_dig *lvds =3D radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->dpms_mode =3D mod=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_l=
vds *lvds =3D radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->dpms_mode =3D mod=
e;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 radeon_legacy_lvds_update(encoder, mode);
> +}
> +
> =A0static void radeon_legacy_lvds_prepare(struct drm_encoder *encoder=
)
> =A0{
> =A0 =A0 =A0 =A0struct radeon_device *rdev =3D encoder->dev->dev_priva=
te;
> @@ -237,9 +269,222 @@ static const struct drm_encoder_helper_funcs ra=
deon_legacy_lvds_helper_funcs =3D {
> =A0 =A0 =A0 =A0.disable =3D radeon_legacy_encoder_disable,
> =A0};
>
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
> +
> +#define MAX_RADEON_LEVEL 0xFF
> +
> +struct radeon_backlight_privdata {
> + =A0 =A0 =A0 struct radeon_encoder *encoder;
> + =A0 =A0 =A0 uint8_t negative;
> +};
> +
> +static uint8_t radeon_legacy_lvds_level(struct backlight_device *bd)
> +{
> + =A0 =A0 =A0 struct radeon_backlight_privdata *pdata =3D bl_get_data=
(bd);
> + =A0 =A0 =A0 uint8_t level;
> +
> + =A0 =A0 =A0 /* Convert brightness to hardware level */
> + =A0 =A0 =A0 if (bd->props.brightness < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 level =3D 0;
> + =A0 =A0 =A0 else if (bd->props.brightness > MAX_RADEON_LEVEL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 level =3D MAX_RADEON_LEVEL;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 level =3D bd->props.brightness;
> +
> + =A0 =A0 =A0 if (pdata->negative)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 level =3D MAX_RADEON_LEVEL - level;
> +
> + =A0 =A0 =A0 return level;
> +}
> +
> +static int radeon_legacy_backlight_update_status(struct backlight_de=
vice *bd)
> +{
> + =A0 =A0 =A0 struct radeon_backlight_privdata *pdata =3D bl_get_data=
(bd);
> + =A0 =A0 =A0 struct radeon_encoder *radeon_encoder =3D pdata->encode=
r;
> + =A0 =A0 =A0 struct drm_device *dev =3D radeon_encoder->base.dev;
> + =A0 =A0 =A0 struct radeon_device *rdev =3D dev->dev_private;
> + =A0 =A0 =A0 int dpms_mode =3D DRM_MODE_DPMS_ON;
> +
> + =A0 =A0 =A0 if (radeon_encoder->enc_priv) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rdev->is_atom_bios) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_a=
tom_dig *lvds =3D radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpms_mode =3D lvds->dpm=
s_mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->backlight_level =3D=
 radeon_legacy_lvds_level(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_l=
vds *lvds =3D radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpms_mode =3D lvds->dpm=
s_mode;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->backlight_level =3D=
 radeon_legacy_lvds_level(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (bd->props.brightness > 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 radeon_legacy_lvds_update(&radeon_encod=
er->base, dpms_mode);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 radeon_legacy_lvds_update(&radeon_encod=
er->base, DRM_MODE_DPMS_OFF);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int radeon_legacy_backlight_get_brightness(struct backlight_d=
evice *bd)
> +{
> + =A0 =A0 =A0 struct radeon_backlight_privdata *pdata =3D bl_get_data=
(bd);
> + =A0 =A0 =A0 struct radeon_encoder *radeon_encoder =3D pdata->encode=
r;
> + =A0 =A0 =A0 struct drm_device *dev =3D radeon_encoder->base.dev;
> + =A0 =A0 =A0 struct radeon_device *rdev =3D dev->dev_private;
> + =A0 =A0 =A0 uint8_t backlight_level;
> +
> + =A0 =A0 =A0 backlight_level =3D (RREG32(RADEON_LVDS_GEN_CNTL) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RADEON_LVDS_BL_M=
OD_LEVEL_SHIFT) & 0xff;
> +
> + =A0 =A0 =A0 return pdata->negative ? MAX_RADEON_LEVEL - backlight_l=
evel : backlight_level;
> +}
> +
> +static const struct backlight_ops radeon_backlight_ops =3D {
> + =A0 =A0 =A0 .get_brightness =3D radeon_legacy_backlight_get_brightn=
ess,
> + =A0 =A0 =A0 .update_status =A0=3D radeon_legacy_backlight_update_st=
atus,
> +};
> +
> +void radeon_legacy_backlight_init(struct radeon_encoder *radeon_enco=
der,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct drm_connector *drm_connector)
> +{
> + =A0 =A0 =A0 struct drm_device *dev =3D radeon_encoder->base.dev;
> + =A0 =A0 =A0 struct radeon_device *rdev =3D dev->dev_private;
> + =A0 =A0 =A0 struct backlight_device *bd;
> + =A0 =A0 =A0 struct backlight_properties props;
> + =A0 =A0 =A0 struct radeon_backlight_privdata *pdata;
> + =A0 =A0 =A0 uint8_t backlight_level;
> +
> + =A0 =A0 =A0 if (!radeon_encoder->enc_priv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> +#ifdef CONFIG_PMAC_BACKLIGHT
> + =A0 =A0 =A0 if (!pmac_has_backlight_type("ati") &&
> + =A0 =A0 =A0 =A0 =A0 !pmac_has_backlight_type("mnca"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +#endif
> +
> + =A0 =A0 =A0 pdata =3D kmalloc(sizeof(struct radeon_backlight_privda=
ta), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_ERROR("Memory allocation failed\n")=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 props.max_brightness =3D MAX_RADEON_LEVEL;
> + =A0 =A0 =A0 props.type =3D BACKLIGHT_RAW;
> + =A0 =A0 =A0 bd =3D backlight_device_register("radeon_bl", &drm_conn=
ector->kdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0pdata, &radeon_backlight_ops, &props);
> + =A0 =A0 =A0 if (IS_ERR(bd)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_ERROR("Backlight registration faile=
d\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdata->encoder =3D radeon_encoder;
> +
> + =A0 =A0 =A0 backlight_level =3D (RREG32(RADEON_LVDS_GEN_CNTL) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RADEON_LVDS_BL_M=
OD_LEVEL_SHIFT) & 0xff;
> +
> + =A0 =A0 =A0 /* First, try to detect backlight level sense based on =
the assumption
> + =A0 =A0 =A0 =A0* that firmware set it up at full brightness
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (backlight_level =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->negative =3D true;
> + =A0 =A0 =A0 else if (backlight_level =3D=3D 0xff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->negative =3D false;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* XXX hack... maybe some day we can fi=
gure out in what direction
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* backlight should work on a given p=
anel?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->negative =3D (rdev->family !=3D =
CHIP_RV200 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
rdev->family !=3D CHIP_RV250 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
rdev->family !=3D CHIP_RV280 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
rdev->family !=3D CHIP_RV350);
> +
> +#ifdef CONFIG_PMAC_BACKLIGHT
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->negative =3D (pdata->negative ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
of_machine_is_compatible("PowerBook4,3") ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
of_machine_is_compatible("PowerBook6,3") ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
of_machine_is_compatible("PowerBook6,5"));
> +#endif
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (rdev->is_atom_bios) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_atom_dig *lvds =3D=
 radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->bl_dev =3D bd;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_lvds *lvds =3D ra=
deon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->bl_dev =3D bd;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bd->props.brightness =3D radeon_legacy_backlight_get_br=
ightness(bd);
> + =A0 =A0 =A0 bd->props.power =3D FB_BLANK_UNBLANK;
> + =A0 =A0 =A0 backlight_update_status(bd);
> +
> + =A0 =A0 =A0 DRM_INFO("radeon legacy LVDS backlight initialized\n");
> +
> + =A0 =A0 =A0 return;
> +
> +error:
> + =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 return;
> +}
> +
> +static void radeon_legacy_backlight_exit(struct radeon_encoder *rade=
on_encoder)
> +{
> + =A0 =A0 =A0 struct drm_device *dev =3D radeon_encoder->base.dev;
> + =A0 =A0 =A0 struct radeon_device *rdev =3D dev->dev_private;
> + =A0 =A0 =A0 struct backlight_device *bd =3D NULL;
> +
> + =A0 =A0 =A0 if (!radeon_encoder->enc_priv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (rdev->is_atom_bios) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_atom_dig *lvds =3D=
 radeon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D lvds->bl_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->bl_dev =3D NULL;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_encoder_lvds *lvds =3D ra=
deon_encoder->enc_priv;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bd =3D lvds->bl_dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lvds->bl_dev =3D NULL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (bd) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct radeon_legacy_backlight_privdata=
 *pdata;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D bl_get_data(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 backlight_device_unregister(bd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(pdata);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRM_INFO("radeon legacy LVDS backlight =
unloaded\n");
> + =A0 =A0 =A0 }
> +}
> +
> +#else /* !CONFIG_BACKLIGHT_CLASS_DEVICE */
> +
> +static void radeon_legacy_backlight_init(struct radeon_encoder *enco=
der)
> +{
> +}
> +
> +static void radeon_legacy_backlight_exit(struct radeon_encoder *enco=
der)
> +{
> +}
> +
> +#endif
> +
> +
> +static void radeon_lvds_enc_destroy(struct drm_encoder *encoder)
> +{
> + =A0 =A0 =A0 struct radeon_encoder *radeon_encoder =3D to_radeon_enc=
oder(encoder);
> +
> + =A0 =A0 =A0 if (radeon_encoder->enc_priv) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 radeon_legacy_backlight_exit(radeon_enc=
oder);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(radeon_encoder->enc_priv);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 drm_encoder_cleanup(encoder);
> + =A0 =A0 =A0 kfree(radeon_encoder);
> +}
>
> =A0static const struct drm_encoder_funcs radeon_legacy_lvds_enc_funcs=
 =3D {
> - =A0 =A0 =A0 .destroy =3D radeon_enc_destroy,
> + =A0 =A0 =A0 .destroy =3D radeon_lvds_enc_destroy,
> =A0};
>
> =A0static void radeon_legacy_primary_dac_dpms(struct drm_encoder *enc=
oder, int mode)
> diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/r=
adeon/radeon_mode.h
> index 12bdeab..32c6257 100644
> --- a/drivers/gpu/drm/radeon/radeon_mode.h
> +++ b/drivers/gpu/drm/radeon/radeon_mode.h
> @@ -300,6 +300,11 @@ struct radeon_encoder_lvds {
> =A0 =A0 =A0 =A0uint32_t lvds_gen_cntl;
> =A0 =A0 =A0 =A0/* panel mode */
> =A0 =A0 =A0 =A0struct drm_display_mode native_mode;
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
> + =A0 =A0 =A0 struct backlight_device *bl_dev;
> + =A0 =A0 =A0 int =A0 =A0 =A0dpms_mode;
> + =A0 =A0 =A0 uint8_t =A0backlight_level;
> +#endif
> =A0};
>
> =A0struct radeon_encoder_tv_dac {
> @@ -353,6 +358,11 @@ struct radeon_encoder_atom_dig {
> =A0 =A0 =A0 =A0uint32_t lcd_ss_id;
> =A0 =A0 =A0 =A0/* panel mode */
> =A0 =A0 =A0 =A0struct drm_display_mode native_mode;
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
> + =A0 =A0 =A0 struct backlight_device *bl_dev;
> + =A0 =A0 =A0 int dpms_mode;
> + =A0 =A0 =A0 uint8_t backlight_level;
> +#endif
> =A0};
>
> =A0struct radeon_encoder_atom_dac {
> --
> 1.7.3.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
