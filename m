From: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: Re: ACPI and APM
Date: Mon, 26 Aug 2002 17:33:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020826173328.085fb200.valvoline@tiscalinet.it>
References: <20020825120034.4f3ce5b4.valvoline@tiscalinet.it>
	<Pine.LNX.4.44.0208261203070.3643-100000@flyby>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.OATtzZ9Vu+4m:x"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0208261203070.3643-100000-iFUwJ2qmV1I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=.OATtzZ9Vu+4m:x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2002 12:19:27 +0200 (CEST)
marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:


> using acpi-20020821-2.4.19 and then I commented out PM_IS_ACTIVE()
> control in arch/i386/kernel/apm.c around 1902 line (is your kernel hack
> limited to this only?).

also, u've to patch drivers/acpi, to avoid PM-acpi vs PM-apm conflicts...

-- 
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

--=.OATtzZ9Vu+4m:x
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9akpKB2olYR1ntN0RAvawAKCh4RXhsDf7ENpl5oONvyyuB446iACfU6zo
5QO/V9DX16D/nz0BU9nYAWI=
=w6Ey
-----END PGP SIGNATURE-----

--=.OATtzZ9Vu+4m:x--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
