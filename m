From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] acpi4asus update
Date: Tue, 23 Mar 2004 10:46:28 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040323094627.GA3413@fuchi>
References: <20040323000143.GA13711@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040323000143.GA13711-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello..

* Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org> [2004-03-23 09:05 +0100]:

> The attached patch updates the acpi4asus driver to version 0.28 through t=
he
> following changes:
> - Added support for Samsung P30
> - Fixed an oops triggered by non-standard hardware (Samsung P30)
> - Added support for L4400L and M6800N

since i am currently working on a M6800N...
seems to work, although i do not see any difference to the unsupported
default values before, perhaps brightness. :)
what still does not work is the the display switch. when i cat
/proc/acpi/asus/disp i get random values like:
-583194208
-583193696
-1007965376
-588481760

the key strokes on Fn+F8 are recognized by acpid.

info shows:
Asus Laptop ACPI Extras Driver 0.28
Model reference: xxN
SFUN value: 0x0877
DSDT length: 22331
DSDT checksum: 191
DSDT revision: 1
OEM id: 1ABSP
OEM table id: 1ABSP001
ASL comp vendor id: INTL
ASL comp revision: 0x20030918

this is not the original DSDT but the one from
http://www.isis.de/members/~messersch/files/asus_m6800n_dsdt_table_with_wor=
king_battery.dsl.gz

thanks,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYAdzreHfL3pi+bQRAs2oAJ9ymLQSvz2OMFxlZ3RWiVDPB9P4BgCfThZY
FAv+Y0yheh+ER9qUi0wg5Qc=
=QmrP
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
