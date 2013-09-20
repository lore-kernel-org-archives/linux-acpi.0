From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 2/3] ACPI / video: seperate backlight
 control and event interface
Date: Fri, 20 Sep 2013 15:01:39 +0200
Message-ID: <1379682099.9746.5.camel@oban>
References: <1379409796-29350-1-git-send-email-aaron.lu@intel.com>
	<1379409796-29350-3-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1764355913=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1379409796-29350-3-git-send-email-aaron.lu@intel.com>
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


--===============1764355913==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-f7eTPuUuyk+b0QmhFQTv"


--=-f7eTPuUuyk+b0QmhFQTv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On mar., 2013-09-17 at 17:23 +0800, Aaron Lu wrote:
> The backlight control and event delivery functionality provided by
> ACPI
> video module is mixed together and registered all during video device
> enumeration time. As a result, the two functionality are also removed
> together on module unload time or by the acpi_video_unregister
> function.
> The two functionalities are actually independent and one may be useful
> while the other one may be broken, so it is desirable to seperate the
> two functionalities such that it is clear and easy to disable one
> functionality without affecting the other one.
>=20
> APIs to selectively remove backlight control interface and/or event
> delivery functionality can be easily added once needed.
>=20
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Tested-by: Yves-Alexis Perez <corsac@debian.org>
--=20
Yves-Alexis

--=-f7eTPuUuyk+b0QmhFQTv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQEcBAABCAAGBQJSPEczAAoJEG3bU/KmdcClY8AIAKONX1Vy4r/BxLo1L6CMqbt2
S1d4Mdkhua5mejGYSdYLWdQku554nJpnQ4uSWAHwuJNW21i4GqNhqsNzlADYIYba
KxHtQnL8K2GOaVLMQHf+2O4i1lmWc/yvvOcLGEktGnUHYYCxOJBCTwCuzHuFG14E
XUngsESoWgBrrJGrzL/k9i8CmdtzjMase9wJOU73rT1ujme746qYyF8rLfw7BFOt
2l+PLBwNvTNslu71s5WnUnG/si7HpanSPZhoR/60bbxUNUx/KFhHVFQV4s8EvC+J
yIK50jfNnx+o5iO9lVyLIzcDRzlhDqVvsvMRQXEyK+j5y1/9cSX/LWjmN5ya+Go=
=juvk
-----END PGP SIGNATURE-----

--=-f7eTPuUuyk+b0QmhFQTv--


--===============1764355913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1764355913==--
