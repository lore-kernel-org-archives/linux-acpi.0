From: valvoline <valvoline-KGm45+8e4WzOeuqD6ShaSA@public.gmane.org>
Subject: Re: ACPI and APM
Date: Mon, 26 Aug 2002 17:28:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020826172837.456c21f2.valvoline@tiscalinet.it>
References: <20020825120034.4f3ce5b4.valvoline@tiscalinet.it>
	<Pine.LNX.4.44.0208261203070.3643-100000@flyby>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="XP6DdZAEG=.1l8A/"
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

--XP6DdZAEG=.1l8A/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2002 12:19:27 +0200 (CEST)
marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org wrote:

> I tried enabling both APM and ACPI. I patched a clean 2.4.19 kernel
> using acpi-20020821-2.4.19 and then I commented out PM_IS_ACTIVE()
> control in arch/i386/kernel/apm.c around 1902 line (is your kernel hack
> limited to this only?).

nop. u've to patch correctly the (HZ) suspend factor, if you don't the system
can't handle correctly the suspend/standby requests. on the 2.4.19 clean apm.c, 
there's a 3*(HZ) timeout define, mod' it to 5*(HZ). and set a default timeout
to 2*(HZ). 

later, you've to mod the PM part: if you use the suspend and standby function
of APM, you've to disable the SLEEP part of ACPI, to avoid conflicts between them.

you've tried my first patch ?, i've make a diff -ruN under a clean and a patched
kernel tree...do u have problems ?...please, let me know.


> My kernel as Local APIC disabled because, enabling it, acpi doesn't
> shitch off my pc on halt and either hsf driver for soft modem doesn't work.

me too. local APIC disabled. try to make all the changes, that i've suggested,
later, compile both ACPI and APM inside kernel (not module).
Under APM, enable ONLY: Enable PM at Boot Time, and Enable Console Blanking using APM.
Under ACPI, enable: Button, Fan, Processor, Thermal Zone. Skip the Rest.

let' me know.
-- 
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]


--XP6DdZAEG=.1l8A/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9akkrB2olYR1ntN0RAjb/AKC/vAX9Zov+cuV89rwRyR6ayNx4VgCfYwEv
qVJ3SsU2Jd/TsR4VSlV7q58=
=QbhU
-----END PGP SIGNATURE-----

--XP6DdZAEG=.1l8A/--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
