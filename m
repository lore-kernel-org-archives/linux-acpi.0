From: <liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Subject: Re: Compaq Presario 2100 (2133AC)
Date: Wed, 2 Jul 2003 20:15:08 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0307022011020.2368-100000@frog.athome>
References: <3F0306B3.4070803@aes-pl.com.au>
Reply-To: <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3F0306B3.4070803-Pm7dQxmfFcgpAS55Wn97og@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Eager <andrew.eager-Pm7dQxmfFcgpAS55Wn97og@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Andrew,
I got this problem too with the acpi-version for 2.4.21-rc1. But I now use
2.4.22-pre2 (linux-kernel), that includes the uptodate 20030619-version of
the ACPI-code. I do no longer have the hwclock hang!

So I would like to hear, if the new kernel will help you.

Regards hartwig :-)

On Thu, 3 Jul 2003, Andrew Eager wrote:
> Just joined this list cos I need some help and probably have something
> to contribute!
>
> I have just got a Compaq Presario 2100 (2133AC or DF975A) and found that
> the 2.4.21 kernel just hung when booting.
> After a day of reading howtos and learning how to use the iasl compiler
> (& language... yuk), I have managed to get the machine to work by:
>  - Getting original DSL, debug & recompile
>  - Removing  the "PTLTD" from blacklist.c (not sure if this is right or not)
>  - Loading the AML code from initrd.
>
> I now have everything working **except** that running hwclock will cause
> the kernel to crash.
> (I have to comment hwclock out of rc.sysinit in order for it to boot)

  hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AyEy9bBoTzOf1pMRAoEnAJ9NaEh+r4XEzE5LrpXGkL7M978uDwCgtSiP
stedbmIIv1ofpBI8Bmycn58=
=7TZ+
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
