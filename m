From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 1/3] backlight: introduce
	backlight_device_registered
Date: Fri, 20 Sep 2013 15:01:10 +0200
Message-ID: <1379682070.9746.4.camel@oban>
References: <1379409796-29350-1-git-send-email-aaron.lu@intel.com>
	<1379409796-29350-2-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008148233=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1379409796-29350-2-git-send-email-aaron.lu@intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, Seth Forshee <seth.forshee@canonical.com>, intel-gfx@lists.freedesktop.org, Felipe Contreras <felipe.contreras@gmail.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Lee Chun-Yi <joeyli.kernel@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Igor Gnatenko <i.gnatenko.brain@gmail.com>
List-Id: linux-acpi@vger.kernel.org


--===============2008148233==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-58w91WtYPtSbCTQSY6cQ"


--=-58w91WtYPtSbCTQSY6cQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On mar., 2013-09-17 at 17:23 +0800, Aaron Lu wrote:
> Introduce a new API for modules to query if a specific type of
> backlight
> device has been registered. This is useful for some backlight device
> provider module(e.g. ACPI video) to know if a native control
> interface(e.g. the interface created by i915) is available and then do
> things accordingly(e.g. avoid register its own on Win8 systems).
>=20
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Yves-Alexis Perez <corsac@debian.org>
--=20
Yves-Alexis

--=-58w91WtYPtSbCTQSY6cQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAABCAAGBQJSPEcWAAoJEG3bU/KmdcClUQoIAJFa6UA/9Di6bcQ9BxuIwLUI
Khc9PEMmBklJpaVcNSWv+lnkaxv6tRbYkwpM2rFAccjUImMVfKkI/TucD6Ba5ZZi
aYPrd4cG5qNB4RFXLI7XxT6RDKGKPGNQmjXuUuSMHFqfOhFR4lZe21DW4wfsXB8s
qXjVZw2DDt1kuumE4ll9MWez1LboZnuAYobU0cxlWIHHKqdwyNbCS2KiRpZyv1SL
fR0iDdWfSMbZKytMK7GzVf1mIvAXBKH2GxJCI8pKb6dvg0O01HTDMeG32A7YlB2e
inulx+hGbAU2eJWXpbmU8aFe33WP9PNuj6pwvzwRjnjuwjQC9cMsvNUDE2bvKKQ=
=9VgC
-----END PGP SIGNATURE-----

--=-58w91WtYPtSbCTQSY6cQ--


--===============2008148233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============2008148233==--
