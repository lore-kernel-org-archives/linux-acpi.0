From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 3/3] ACPI / video: Do not register
 backlight if win8 and native interface exists
Date: Fri, 20 Sep 2013 15:02:12 +0200
Message-ID: <1379682132.9746.6.camel@oban>
References: <1379409796-29350-1-git-send-email-aaron.lu@intel.com>
	<1379409796-29350-4-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1331478613=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1379409796-29350-4-git-send-email-aaron.lu@intel.com>
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


--===============1331478613==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-tewwTmGUp+Pausd/MBrU"


--=-tewwTmGUp+Pausd/MBrU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On mar., 2013-09-17 at 17:23 +0800, Aaron Lu wrote:
> According to Matthew Garrett, "Windows 8 leaves backlight control up
> to individual graphics drivers rather than making ACPI calls itself.
> There's plenty of evidence to suggest that the Intel driver for
> Windows 8 doesn't use the ACPI interface, including the fact that
> it's broken on a bunch of machines when the OS claims to support
> Windows 8.  The simplest thing to do appears to be to disable the
> ACPI backlight interface on these systems".
>=20
> So for Win8 systems, if there is native backlight control interface
> registered by GPU driver, ACPI video will not register its own. For
> users who prefer to keep ACPI video's backlight interface, the
> existing
> kernel cmdline option acpi_backlight=3Dvideo can be used.
>=20
> This patch is an evolution from previous work done by Matthew Garrett,
> Chun-Yi Lee, Seth Forshee and Rafael J. Wysocki.
>=20
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Yves-Alexis Perez <corsac@debian.org>
--=20
Yves-Alexis

--=-tewwTmGUp+Pausd/MBrU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAABCAAGBQJSPEdUAAoJEG3bU/KmdcClaAAH/3YwGtv83uQQ77PfJ1cmqADy
bFH4WDtWKptZ6hCZ92ID60lPKVucJHpPWcGcDYmp/wsPtGdCUa0zWJ6Xk0XPPULI
Z1RoVmyni/pXJlPK9zPRrxj2lZX857xYimgI+doISf3frUBFZFVYJIIW26QtpiQ0
WbA+ujp/46DWeGcSN88HW5alzH4pyN1nsPpEoK7KFVNLL6eV1Py3XectVPa8+TKn
15n7G9hc6YtuoJLA4NnptHxyJILXDIigluGfAFTThgBY4CFNpdD1a6F0nYma+oa+
gdP2m8GHGf95/tHwdu4c7O0OQOoyS1tITnzWuj71RO9ehGbsYZAMM1pJJJ6EfL8=
=ph5b
-----END PGP SIGNATURE-----

--=-tewwTmGUp+Pausd/MBrU--


--===============1331478613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1331478613==--
