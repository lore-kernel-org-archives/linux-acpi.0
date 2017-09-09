From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v9 00/23] Unified fwnode endpoint parser, async
 sub-device notifier support, N9 flash DTS
Date: Sat, 9 Sep 2017 11:34:13 +0200
Message-ID: <20170909093413.GN27428@amd>
References: <20170908131235.30294-1-sakari.ailus@linux.intel.com>
 <20170908132507.nqofkw2g43m7ydux@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oIlomvtVtXAVxSKT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170908132507.nqofkw2g43m7ydux-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--oIlomvtVtXAVxSKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-09-08 16:25:07, Sakari Ailus wrote:
> On Fri, Sep 08, 2017 at 04:11:51PM +0300, Sakari Ailus wrote:
> > With this, the as3645a driver successfully registers a sub-device to the
> > media device created by the omap3isp driver. The kernel also has the
> > information it's related to the sensor driven by the smiapp driver but =
we
> > don't have a way to expose that information yet.
>=20
> The patches are also available here:
>=20
> <URL:https://git.linuxtv.org/sailus/media_tree.git/log/?h=3Dfwnode-parse>

I merged the series on top of v4.14-rc0, and it does not break
anything. So:

Tested-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oIlomvtVtXAVxSKT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlmztZUACgkQMOfwapXb+vJ5ZQCbB+Kd6+IE3UvHH0N7OsXocWzr
z6oAn0mbhHs4hFc/5Nc/3drIARmxU04A
=F+zo
-----END PGP SIGNATURE-----

--oIlomvtVtXAVxSKT--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
