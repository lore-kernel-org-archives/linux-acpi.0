From: liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Subject: Re: 2.6 won't poweroff
Date: Fri, 28 May 2004 22:25:51 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.60.0405282221200.4440@frog.athome>
References: <20040527235535.GA21670@zimen.sk>
Reply-To: hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040527235535.GA21670-VaXaUECoPuY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mizu <michal-VaXaUECoPuY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Salut Mizu,
  (I sended this reply to you this morning (falsely only to you).
But I also tryed with APIC_UP and IO_APIC compiled in...
the 2.6.6 vanilla-kernel powers off for the TM63x

On Fri, 28 May 2004, mizu wrote:
> and what about this patch ??? : (from bugzilla)
> --- linux/drivers/acpi/hardware/hwsleep.c.orig	2004-03-04 23:10:41.000000000 +0100
> +++ linux/drivers/acpi/hardware/hwsleep.c	2004-03-04 23:11:58.000000000 +0100
This patch against a regression was created by me. But as disabling UP_APIC
did workaround it - and I always said, that I do not understand, what this
code is doing - it is not likely, that it will become part of the
mainline-kernel.
Just to double check, I got a fresh vanilla-2.6.6-kernel and compiled it. 
My TM634 is switching-off, as expected - NO problem!
So a BIOS-upgrade will do the trick for Emma. Her BIOS is no longer
available, whereas there are older versions still available. So it is very
likely, that it has serious issues.

So this patch is obsolet...

Cheers
   hartwig felger

Hartwig Felger informatics

- -- 
1024D/339FD693 Hartwig Felger <hgfelger-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org>
Key fingerprint = FB2F 3EE9 345A D55B 6FF2  0EC1 F5B0 684F 339F D693
For the pulic keys, please visit my page.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAt6BU9bBoTzOf1pMRAgW+AKCvX2kTLZ9Fh72YL9nwaiGSN/TkEgCg38JU
Tku5/rvLzJoUEpmIC6vlDC4=
=owkl
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
