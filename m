From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: [PATCH] sony-laptop: no need to unblock rfkill on load
Date: Tue, 9 Jun 2009 07:49:15 +0900
Message-ID: <20090608224915.GA4583@kamineko.org>
References: <4A2CE86F.9040209@tuffmail.co.uk> <1244457418.18863.8.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1244457418.18863.8.camel-YfaajirXv2244ywRPIzf9A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johannes Berg <johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org>
Cc: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2009 at 12:36:58PM +0200, Johannes Berg wrote:
> On Mon, 2009-06-08 at 11:31 +0100, Alan Jenkins wrote:
> > The re-written rfkill core ensures rfkill devices are initialized to
> > the system default state.  The core calls set_block after registration
> > so the driver shouldn't need to.
> >=20
> > Signed-off-by: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
>=20
> Good catch, thanks.

Just to confirm, is this patch going to sit in the wireless-testing tree
and you will submit it for inclusion together with the rfkill work
right?
=20
> > ---
> >=20
> > This patch applies on top of the rfkill rewrite in the wireless-testing=
 tree.
> >=20
> > diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/=
sony-laptop.c
> > index aec0b27..c1b21a4 100644
> > --- a/drivers/platform/x86/sony-laptop.c
> > +++ b/drivers/platform/x86/sony-laptop.c
> > @@ -1114,7 +1114,6 @@ static int sony_nc_setup_rfkill(struct acpi_devic=
e *device,
> >  		return err;
> >  	}
> >  	sony_rfkill_devices[nc_type] =3D rfk;
> > -	sony_nc_rfkill_set((void *)nc_type, false);
> >  	return err;
> >  }
> > =20
> >=20
> >=20

thanks
--=20
mattia
:wq!

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkotlWsACgkQgpRPaOotLEG8iACgsvpH3LJR9/cITzKSuG4cvHTi
G+oAoMXpl3iQzVWVZXHSIKfbAYUMmPiV
=B97G
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
