From: simon-Ji7FXtOmRLs@public.gmane.org (Simon Fowler)
Subject: Re: Battery rate on Acer TM 292
Date: Sat, 18 Sep 2004 01:15:09 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040917151509.GA7756@himi.org>
References: <16A54BF5D6E14E4D916CE26C9AD305751B66D5@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305751B66D5-4yWAQGcml66iAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2004 at 09:20:53AM +0800, Li, Shaohua wrote:
> Please don't trust 'present rate'. In many systems, 'present rate' are
> always 0. If you want to estimate the power of the battery, please use
> remaining capacity. I'd like the user daemon use 'remaining capacity' to
> calculate the rate.
>=20
If present rate is reported, it's probably best to use it - the only
other alternative, sampling the remaining capacity over time,
is very error prone.=20

On my Fujitsu LifeBook p2120 present rate reliably reflects the
remaining battery life, even to the point of closely tracking
changes in power usage.=20

If I sample the remaining capacity every few seconds, however, it
becomes obvious that it simply doesn't update the reported value
often enough to be of much use - the smallest change in capacity
reported is around 30mAH, which is too coarse grained to allow a
good estimate. Even with averaging over a number of samples the
present rate calculated this way jumps around too much.

Probably the best approach would be to let the user choose which
approach to use, which is what I've done with wmacpi
(http://himi.org/wmacpi).=20

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBSv98QPlfmRRKmRwRAgCLAJ9yccyvKZWRIznQVkiUXxlgm66iqgCfRNsb
S/jMCeEZ6BoMmMsONm2wTVs=
=024p
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
