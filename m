From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Can't poweroff anymore.
Date: Sat, 06 Mar 2004 21:12:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <404A30A5.6070802@pca.it>
References: <20040304180301.GA1754@conectiva.com.br> <Pine.LNX.4.58.0403050113230.3779@frog.athome> <Pine.LNX.4.58.0403061054120.1146@frog.athome> <4049E76D.4030000@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4049E76D.4030000-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/06/04 15:59, Luca Capello wrote:
> ? are you sure it applys cleanly on 2.6.3? This isn't the case for me:
after having tried on 2.4.25 with the same error:
=====
gismo:/usr/src/linux-2.4.25-hwsleep2# patch -p1 < ../kernel/v2.6/hwsleep.c2-patch
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 FAILED at 249.
1 out of 1 hunk FAILED -- saving rejects to file drivers/acpi/hardware/hwsleep.c.rej
=====

I found the problem: the patch Hartwig attached lacks the first line of
comparison, while the same patch on http://bugme.osdl.org/show_bug.cgi?id=2109
is correct:
=====
gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleep# patch -p1 <
/home/luca/download/hwsleep.bug.diff
patching file drivers/acpi/hardware/hwsleep.c
Hunk #1 succeeded at 284 (offset 35 lines).
gismo:/usr/src/linux-2.6.3-acpi.initrd-processor.cst-hwsleep#
=====

With this latest patch, kernel 2.6.3 compiles correctly, but anyway I get the
same problem: 2.6.3 doesn't shutdown.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFASjCkVAp7Xm10JmkRAmbBAJwN0RXYkrZFd4eREPgAq8HeemyP2ACffFjo
oYh5IaHxLHn3UGLZpEqI8OU=
=mK6q
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
