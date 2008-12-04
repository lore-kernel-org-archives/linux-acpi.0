From: Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [Intel-gfx] [intel/acpi] backlight - T61
Date: Thu, 4 Dec 2008 10:50:14 +0800
Message-ID: <20081204025014.GA18597@zhen-devel.sh.intel.com>
References: <1227854824.3477.9.camel@hidalgo> <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain> <1227912656.17845.5.camel@hidalgo> <1228095176.2713.18.camel@rzhang-dt> <alpine.LFD.2.00.0811302158150.3314@localhost.localdomain> <1228108103.2713.27.camel@rzhang-dt> <20081203231455.GA11829@localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63107 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYLDCzX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Dec 2008 21:55:23 -0500
Content-Disposition: inline
In-Reply-To: <20081203231455.GA11829@localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhenyu Wang <zhen78@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Yves-Alexis Perez <corsac@debian.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, Len Brown <lenb@kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2008.12.04 07:14:55 +0800, Zhenyu Wang wrote:
> > > However, testing FC10 with the latest upstream kernel,
> > > including the i915 changes that appeared today...
> > > it seems that GUI mode forgets the brighness when
> > > I switch to console mode.  Eg. If I use /sys or
> > > hotkeys in GUI mode to reduce brightness to 0,
> > > it stays dim when I switch to console mode,
> > > but switches back to max brightness when
> > > I switch back to GUI mode.
> > hah, that's a done by X.
> > ZhenYu pointed out that the graphics driver will set the backlight to
> > maximum if it is 0 =EF=BB=BFwhen =EF=BB=BFswitching to GUI.
> > =EF=BB=BFwhat if reducing the brightness to a lower but not 0 level?
> > it should switch back to the original value, right?
> > cc ZhenYU. :)
>=20
> This depends on the backlight control method used by Xorg
> video driver. We have this comment in the driver from Jesse I think,
>=20
>  /*
>   * If we're going from off->on we may need to turn on the backlight.
>   * We should use the saved value whenever possible, but on some
>   * machines 0 is a valid backlight value (due to an external backlight
>   * controller for example), so on them, when turning LVDS back on,
>   * they'll always re-maximize the brightness.
>   */
> if (!(INREG(PP_CONTROL) & POWER_TARGET_ON) &&
> 	dev_priv->backlight_duty_cycle =3D=3D 0)
> 	dev_priv->backlight_duty_cycle =3D dev_priv->backlight_max;
>=20
> It looks if we're using kernel backlight method, '0' should be a human
> sensible dim level instead of meaningless near-to-black level, right?
>=20
> So how about this patch against current xf86-video-intel?
>=20
> ---
> diff --git a/src/i830_lvds.c b/src/i830_lvds.c
> index 239bc89..1799eab 100644
> --- a/src/i830_lvds.c
> +++ b/src/i830_lvds.c
> @@ -400,7 +400,8 @@ i830SetLVDSPanelPower(xf86OutputPtr output, Bool on)
>  	 * they'll always re-maximize the brightness.
>  	 */
>  	if (!(INREG(PP_CONTROL) & POWER_TARGET_ON) &&
> -	    dev_priv->backlight_duty_cycle =3D=3D 0)
> +	    dev_priv->backlight_duty_cycle =3D=3D 0 &&
> +	    pI830->backlight_control_method < BCM_KERNEL)
>  	    dev_priv->backlight_duty_cycle =3D dev_priv->backlight_max;
> =20
>  	OUTREG(PP_CONTROL, INREG(PP_CONTROL) | POWER_TARGET_ON);
> ---

I've tested this patch on T61 just fine. I push this to
xf86-video-intel master now.

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkk3RWYACgkQsQQaM014GCeAUACdHpUDuE1wTV7J10MRTEfAXPWC
SmIAn2fvFQAxbeUYzk1LEqBHSRraLZCO
=RPML
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
