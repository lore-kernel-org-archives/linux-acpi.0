From: Zhenyu Wang <zhen78@gmail.com>
Subject: Re: [intel/acpi] backlight - T61
Date: Thu, 4 Dec 2008 07:14:55 +0800
Message-ID: <20081203231455.GA11829@localdomain>
References: <1227854824.3477.9.camel@hidalgo> <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain> <1227912656.17845.5.camel@hidalgo> <1228095176.2713.18.camel@rzhang-dt> <alpine.LFD.2.00.0811302158150.3314@localhost.localdomain> <1228108103.2713.27.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:4720 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbYLCO6s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 09:58:48 -0500
Received: by ti-out-0910.google.com with SMTP id b6so2305216tic.23
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2008 06:58:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228108103.2713.27.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Keith Packard <keithp@keithp.com>, Yves-Alexis Perez <corsac@debian.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, Matthew Garrett <mjg@redhat.com>, intel-gfx@lists.freedesktop.org

On 2008.12.01 13:08:23 +0800, Zhang Rui wrote:
> >=20
> > However, testing FC10 with the latest upstream kernel,
> > including the i915 changes that appeared today...
> > it seems that GUI mode forgets the brighness when
> > I switch to console mode.  Eg. If I use /sys or
> > hotkeys in GUI mode to reduce brightness to 0,
> > it stays dim when I switch to console mode,
> > but switches back to max brightness when
> > I switch back to GUI mode.
> hah, that's a done by X.
> ZhenYu pointed out that the graphics driver will set the backlight to
> maximum if it is 0 =EF=BB=BFwhen =EF=BB=BFswitching to GUI.
> =EF=BB=BFwhat if reducing the brightness to a lower but not 0 level?
> it should switch back to the original value, right?
> cc ZhenYU. :)

This depends on the backlight control method used by Xorg
video driver. We have this comment in the driver from Jesse I think,

 /*
  * If we're going from off->on we may need to turn on the backlight.
  * We should use the saved value whenever possible, but on some
  * machines 0 is a valid backlight value (due to an external backlight
  * controller for example), so on them, when turning LVDS back on,
  * they'll always re-maximize the brightness.
  */
if (!(INREG(PP_CONTROL) & POWER_TARGET_ON) &&
	dev_priv->backlight_duty_cycle =3D=3D 0)
	dev_priv->backlight_duty_cycle =3D dev_priv->backlight_max;

It looks if we're using kernel backlight method, '0' should be a human
sensible dim level instead of meaningless near-to-black level, right?

So how about this patch against current xf86-video-intel?

---
diff --git a/src/i830_lvds.c b/src/i830_lvds.c
index 239bc89..1799eab 100644
--- a/src/i830_lvds.c
+++ b/src/i830_lvds.c
@@ -400,7 +400,8 @@ i830SetLVDSPanelPower(xf86OutputPtr output, Bool on=
)
 	 * they'll always re-maximize the brightness.
 	 */
 	if (!(INREG(PP_CONTROL) & POWER_TARGET_ON) &&
-	    dev_priv->backlight_duty_cycle =3D=3D 0)
+	    dev_priv->backlight_duty_cycle =3D=3D 0 &&
+	    pI830->backlight_control_method < BCM_KERNEL)
 	    dev_priv->backlight_duty_cycle =3D dev_priv->backlight_max;
=20
 	OUTREG(PP_CONTROL, INREG(PP_CONTROL) | POWER_TARGET_ON);
---

p.s Len, if for intel graphics specific issue, we have another
intel-gfx@lists.freedesktop.org for such discuss. Thanks.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
