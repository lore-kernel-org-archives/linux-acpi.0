From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v3 4/4] thinkpad-acpi: fix handle locate for
 video and query of _BCL
Date: Sat, 28 Sep 2013 14:28:02 +0200
Message-ID: <1380371282.1300.11.camel@scapa>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
	<1380016052-15315-5-git-send-email-aaron.lu@intel.com>
	<20130927152035.GB4140@khazad-dum.debian.net>
	<1380295986.16310.19.camel@scapa>
	<20130927180516.GC4140@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1939562673=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130927180516.GC4140@khazad-dum.debian.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: James Hogan <james@albanarts.com>, Martin Steigerwald <Martin@lichtvoll.de>, Felipe Contreras <felipe.contreras@gmail.com>, dri-devel@lists.freedesktop.org, Matthew Garrett <matthew.garrett@nebula.com>, Mike Galbraith <bitbucket@online.de>, Kalle Valo <kvalo@adurom.com>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Ben Jencks <ben@bjencks.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, intel-gfx@lists.freedesktop.org, Joerg Platte <jplatte@naasa.net>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J.
	Wysocki" <rjw@sisk.pl>, Seth Forshee <seth.forshee@canonical.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-acpi@vger.kernel.org


--===============1939562673==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-BcvpZRNaUsmRVhqK2bav"


--=-BcvpZRNaUsmRVhqK2bav
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On ven., 2013-09-27 at 15:05 -0300, Henrique de Moraes Holschuh wrote:
> On Fri, 27 Sep 2013, Yves-Alexis Perez wrote:
> > On ven., 2013-09-27 at 12:20 -0300, Henrique de Moraes Holschuh wrote:
> > > Some testing on a *60 (T60,X60...) would also be best, I cannot test
> > > this on
> > > my T43.
> > >=20
> > > Anyway, the code itself looks fine, so:
> >=20
> > I can test on T61, would that help?
>=20
> I think so.
>=20
Ok, just tested on my T61 with Intel graphics.

I've checked that on Linux 3.12
(6cac446bd37d9381815fe4c2b0e7b1fd1085000c), brightness keys work fine
like they do in 3.2.

Then I've applied the patchset. The brightness keys still work, I still
have 16 levels.

Regards,
--=20
Yves-Alexis

--=-BcvpZRNaUsmRVhqK2bav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABCAAGBQJSRstSAAoJEG3bU/KmdcClWmAH/RTdN6DO3HksGNFlpmalTdNX
Ukg0YqIE96PKfcdeZYafqbarZAM5+7x9bGdJ1dSZQl0SBKaqvRG7uUsJxuVYiyq6
eZWj8XPXM5w6TC8KlOxMc5zuITG2IhdPEc9geQsWpnHyh5ii0gef4LTQ91Pr4QKJ
6CYqW6iZjY9Ld59CvW0A1eWJNeqy6GIH8ZTTe22nkw8OLLqHGkmToYTsx1Gxk7Ei
dO2I75Zazit80qsKJbFQsyekkMJUVP7kBOpVZSNcxCijvJDuCqYjeIGk1nz+MfF/
mpafIzt+6PEX22veTEfIGg1i+FQmBkFONzsXf9OiE3nbTUuyWgsQ6oitpnKR7YI=
=tIPT
-----END PGP SIGNATURE-----

--=-BcvpZRNaUsmRVhqK2bav--

--===============1939562673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1939562673==--
