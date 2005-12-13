From: Stefan Schmidt <stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org>
Subject: Re: Battery cycle count on IBM Thinkpads.
Date: Tue, 13 Dec 2005 11:11:10 +0100
Message-ID: <20051213101110.GI12245@susi>
References: <20051119230734.GA4117@susi> <20051120214624.GC2556@spitz.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x9NlMAausKqHAFUv"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20051120214624.GC2556-/Rtfo+muvtdI+ieYp0uEEg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--x9NlMAausKqHAFUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, 2005-11-20 at 21:46, Pavel Machek wrote:
> >=20
> > Does somebody know, how i can read the cycle counter for battery
> > charge on IBM Thinkpads?
>=20
> You may be able to talk to smartbattery directly (using i2c), and
> get that info... expect to do some programming...

Shem Multinymous wrote the tp_smapi driver to have more support for
the smapi features in Thinkpad. With version 0.09 it is possible to
read the charge cycle count an more information about the battery.

http://tpctl.sourceforge.net/
http://www.thinkwiki.org/wiki/SMAPI_support_for_Linux

regards
Stefan Schmidt

--x9NlMAausKqHAFUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDnp4+bNSsvd31FmURAl1PAJ9ngYoe8olptTyb85ei2BoIT+6GYwCg4AmO
bo17BQaFY9FHQkYqAOIPmEY=
=7h5N
-----END PGP SIGNATURE-----

--x9NlMAausKqHAFUv--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
