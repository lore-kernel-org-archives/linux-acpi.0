From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8
	systems
Date: Tue, 25 Jun 2013 22:43:57 +0200
Message-ID: <1372193037.8189.24.camel@scapa>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
	<1371937599.17761.19.camel@scapa>
	<20130625160848.GA27123@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0227440744=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130625160848.GA27123@srcf.ucam.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, seth.forshee@canonical.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, joeyli.kernel@gmail.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org


--===============0227440744==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-h0qekHEZ+L+n3AONK2yC"


--=-h0qekHEZ+L+n3AONK2yC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On mar., 2013-06-25 at 17:08 +0100, Matthew Garrett wrote:
> On Sat, Jun 22, 2013 at 11:46:39PM +0200, Yves-Alexis Perez wrote:
>=20
> > Before Linux support for acpi_osi("Windows 2012") (and when booting wit=
h
> > acpi_osi=3D"!Windows 2012"), brightness keys were handled by the kernel
> > just fine, whether in console, in the display manager or in my desktop
> > environment (Xfce). xfce4-power-manager just needs to be told that the
> > brightness keys are already handled and it doesn't need to do anything.
>=20
> Right, the kernel has special-casing to hook the backlight keys up to=20
> the ACPI backlight control. This is an awful thing, because there's no=
=20
> way to detect this case other than parsing a single driver-specific=20
> module parameter.

I'm not sure what that means. To detect what case exactly? That the
brightness is handled by video.ko?
>=20
> Could this functionality be duplicated across other backlight drivers?=
=20
> Not easily. The ACPI driver receives keypresses and performs backlight=
=20
> control. The i915 driver doesn't receive keypresses. We could easily tie=
=20
> certain keycodes into backlight events, but which backlight should they=
=20
> control? You're really starting to get into the kind of complex policy=
=20
> decision that's best left to userspace, which is where it should have=20
> been to begin with.
>=20
Well, I get the reasoning, but I'm not sure I agree. That means
userspace behavior is inconsistent depending on who does it
(gnome-power-manager, gnome-setting-daemon, whatever), and it usually
means there's nothing handling the brightness before those are running,
not to mention people not running them because they don't run a full
blown desktop environment (until someone starts thinking it's a good
idea to handle brightness in systemd).

And in the end, the user just want the brightness keys to correctly
handle the brightness, full stop. Having multiple brightness daemons
using different policies on different hardware is a nightmare for the
end user, imho. From a user point of view, having it handled all in the
kernel works really pretty fine and is completely transparent (I have to
admit that from that point of view, it was even better when it was
handled by the EC but those times seem long gone).

Regards,
--=20
Yves-Alexis

--=-h0qekHEZ+L+n3AONK2yC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABCAAGBQJRygENAAoJEG3bU/KmdcCl3PgIAJWjGaTnGC4da9Pb1h4Wtyvu
fGVBCqky+23sKfVovt8BjgU0asnRoZ+4pkz6QSbLlU/hVsD27m+2i0k4/bdrxOzK
2AT+SqcWXE+leObHHe181SnFC9xglXxz8HnzxzUnNoTDWuOzXdNQWNQfh5iLqaq5
Qqiiu6wNZttHzlD0Yb3ym/jtM0OuhZ/K3HHULlqOxLxOuHqDuvbFIW03+MJPrq0L
HYNR5SGb+NQER9h4CCx1pS8VO+86ofB4a7QicjOSWALAG+mgBdOzCbP43q4GJncU
R+IUHtO4piTArTo3ckfI2Yc78jz4kzj7CqyeS+jBpxXtMjvBbA8Z5rHJM8auePk=
=ddvU
-----END PGP SIGNATURE-----

--=-h0qekHEZ+L+n3AONK2yC--

--===============0227440744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0227440744==--
