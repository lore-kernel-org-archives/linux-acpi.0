From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Subject: Re: ACPI for 2.4
Date: Thu, 25 Mar 2004 16:01:50 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040325160150.06b0ac39.vsu@altlinux.ru>
References: <1080038602.21688.317.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__25_Mar_2004_16_01_50_+0300_ic2.AP_VCr.BybCg"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--Signature=_Thu__25_Mar_2004_16_01_50_+0300_ic2.AP_VCr.BybCg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 23 Mar 2004 05:43:22 -0500 Len Brown wrote:

> 	Several key fixes.
> 	SCI polarity/trigger fix
> 	cardbus bridge interrupt fix
> 	maxcpus=N/2 can now be used (like NR_CPUS) to disable HT
> 
> thanks,
> -Len
> 
> ps. a plain patch is also available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.26/acpi-20040311-2.4.26.diff.gz

Patch for 2.4.25 seems to be updated too; however, it gives several
rejects when applied to a fresh 2.4.25 tree:

./arch/i386/kernel/acpi.c.rej
./arch/x86_64/kernel/acpi.c.rej
./arch/x86_64/kernel/e820.c.rej
./drivers/acpi/system.c.rej
./include/acpi/acconfig.h.rej
./include/asm-x86_64/acpi.h.rej
./include/asm-i386/acpi.h.rej
./include/asm-ia64/acpi.h.rej

--Signature=_Thu__25_Mar_2004_16_01_50_+0300_ic2.AP_VCr.BybCg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAYthBW82GfkQfsqIRAj8nAJ92/ZoiJy+SFtPTGKI6UjedyW/inACeIv89
VfxXiaAn8On/6NZJcmk47wo=
=/wqe
-----END PGP SIGNATURE-----

--Signature=_Thu__25_Mar_2004_16_01_50_+0300_ic2.AP_VCr.BybCg--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
