From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: setting powernow-k7 conflicting on laptop.
Date: Wed, 31 Mar 2004 18:59:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040331165931.GA4762@dominikbrodowski.de>
References: <20040331144001.GC4474@gaia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040331144001.GC4474-Zd7+qHgBxRI@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Geotronix <mail-list-na2r7Jod8xleoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2004 at 04:40:01PM +0200, Geotronix wrote:
>=20
> Hi.
>=20
> I have a Presario 710EA with Debian 2.6.4-k7 kernel image installed.
> With modconf I tried to install the PowerNow-k7 module but I get a
> message that tells me that the device is in use.
> As a matter of fact I have activated and loaded all ACPI modules and
> another module freq_table that is used by ACPI and that modconf dowsn't
> let me unload. I'm not able to understand who is conficting with
> powernow module and why it isn't loading.
>=20
> WHich are the modules that mustn't be loaded in memory so that I can
> install powernow for my DUron 900 processor?

rmmod acpi

it's the cpufreq-acpi module which doesn't work on most (all?) powernow
systems. Then, powernow-k7 should function properly. A patch which will
fix this behaviour and let you register powernow-k7 independently of whether
the non-working cpufreq-acpi module is loaded is in the queue to Linus
already.

	Dominik


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAavjzZ8MDCHJbN8YRApnCAJ47nB82Bg0ZhW6sZiGg0pmxA192XACeNrGC
S0/11Dre1eyhME2GJcDzq8k=
=ezex
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
