From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v3 4/4] thinkpad-acpi: fix handle locate for
 video and query of _BCL
Date: Fri, 27 Sep 2013 17:33:06 +0200
Message-ID: <1380295986.16310.19.camel@scapa>
References: <1380016052-15315-1-git-send-email-aaron.lu@intel.com>
	<1380016052-15315-5-git-send-email-aaron.lu@intel.com>
	<20130927152035.GB4140@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1056424241=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130927152035.GB4140@khazad-dum.debian.net>
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


--===============1056424241==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-+j8p4duVHF2ZP2+D9Bhc"


--=-+j8p4duVHF2ZP2+D9Bhc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On ven., 2013-09-27 at 12:20 -0300, Henrique de Moraes Holschuh wrote:
> Some testing on a *60 (T60,X60...) would also be best, I cannot test
> this on
> my T43.
>=20
> Anyway, the code itself looks fine, so:

I can test on T61, would that help?

Regards,
--=20
Yves-Alexis

--=-+j8p4duVHF2ZP2+D9Bhc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABCAAGBQJSRaUyAAoJEG3bU/KmdcClGfcH/ilpwErStr6ZuonaoV7Vv4Po
auEw+jydVdKblf9SM9cjPI9wuwAweuLF4GJ523iroaddx23zWYe6myH3kygGmUa8
sMU94IS/RgT93zJNdDbHLB7S0wPmq7P33TffVk4v/hhtEll/GqKyvJ1ihsvQYh0U
iw3ABOG4g4IzOxAsSEFoOGzHFMp9ltYuh3JNmh4gG0vPtGbaTyslsRpZqqfi5LK4
2zfZXKcOE8EeWK+CC3sgyM96cHcZNlbw9FC3IHThaPy30aVF4OHQl6r6e1Ug6RyR
9FxDId5db1m2kYVuDweFeO9fI3axgMAE39ztTM2MO8Fhhb8z4U9SW0qBLdKGZgs=
=u2bI
-----END PGP SIGNATURE-----

--=-+j8p4duVHF2ZP2+D9Bhc--

--===============1056424241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1056424241==--
