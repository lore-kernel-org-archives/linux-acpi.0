From: "Cintia B. Margi" <cintia-Emgmuai4XwL2fBVCVOL8/A@public.gmane.org>
Subject: Re: question about ACPI & Smart Batteries
Date: Thu, 12 Aug 2004 15:29:36 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040812222936.GD30862@miramar.cse.ucsc.edu>
References: <F760B14C9561B941B89469F59BA3A8470726AFF5@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470726AFF5-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Grover, Andrew (andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org) said:
> Unless you have a Fujitsu Uva, you do not have a smart battery, you have
> a control method battery.

I don't have a smart battery then.
=20
> For a CM battery, the OS can poll the battery state by calling _BST, or
> set a trip point (via _BTP) and the OS will get an interrupt when the
> battery crosses that trip.

I do not want to set a trip point, but I would like to monitor the battery =
discharge
process... I want to characterize the battery discharge behavior under diff=
erent tasks,
so I intend to monitor the battery voltage and the discharge rate (which I =
can obtain
from /proc/acpi/battery/BAT0/state). What I would like to know is how often=
 the state
file is updated and how accurate these values are. Any idea where I can get=
 this info?

Thanks,

Cintia=20

--
Cintia Margi
Graduate Student
SoE - UCSC
http://www.soe.ucsc.edu/~cintia
GPG Public Key: http://www.soe.ucsc.edu/~cintia/cintia.gpg
B4DE 9355 3840 FF72 50F2 ACAC E2EC AA9A 41E2 CD55

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (FreeBSD)

iD4DBQFBG+9Q4uyqmkHizVURAsxdAJ0WCvv3zX6MNI9PaFMVD3T3jliwCwCVEc1b
CSpYdxoPRJ7DpaFyWkoTvA==
=FTi+
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
