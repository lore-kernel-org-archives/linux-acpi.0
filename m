From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Tue, 02 Mar 2004 13:43:21 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40448169.6090507@pca.it>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040302110946.GF2869-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

on 03/02/04 12:09, Bruno Ducrot wrote:
> Perhaps
> http://bugzilla.kernel.org/show_bug.cgi?id=1958
> may help you.
the patch at that bug failed on 2.6.4-rc1 + ACPI 20040220:
=====
gismo:/usr/src/linux-2.6.4-rc1-test# patch -p1 <
../kernel/v2.6/bug1958-20040127.processor.c.diff
patching file drivers/acpi/processor.c
Hunk #1 FAILED at 3.
Hunk #2 succeeded at 299 (offset 1 line).
Hunk #3 succeeded at 407 (offset 1 line).
Hunk #4 succeeded at 424 (offset 1 line).
Hunk #5 succeeded at 441 (offset 1 line).
Hunk #6 succeeded at 517 (offset 1 line).
Hunk #7 succeeded at 546 (offset 1 line).
Hunk #8 succeeded at 851 (offset 1 line).
Hunk #9 succeeded at 890 (offset 1 line).
Hunk #10 succeeded at 949 (offset 1 line).
Hunk #11 succeeded at 1016 (offset 1 line).
Hunk #12 succeeded at 2145 (offset 595 lines).
Hunk #13 succeeded at 2601 (offset 581 lines).
1 out of 13 hunks FAILED -- saving rejects to file drivers/acpi/processor.c.rej
gismo:/usr/src/linux-2.6.4-rc1-test#
=====

This is not a big problem, the FAILED is cause by the fact that in the new
'processor.c' at line 3 there's even the
	*  Copyright (C) 2004       Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>
which wasn't present in 2.6.1.

On the other hand, I got these error when compiling:
======
  CC [M]  drivers/acpi/processor.o
drivers/acpi/processor.c: In function `acpi_processor_power_activate':
drivers/acpi/processor.c:311: error: structure has no member named `type'
drivers/acpi/processor.c:315: error: structure has no member named `type'
drivers/acpi/processor.c:321: error: structure has no member named `type'
drivers/acpi/processor.c: In function `acpi_processor_idle':
drivers/acpi/processor.c:409: error: structure has no member named `type'
drivers/acpi/processor.c: In function `acpi_processor_set_power_policy':
drivers/acpi/processor.c:548: error: structure has no member named `count'
drivers/acpi/processor.c:549: error: structure has no member named `type'
drivers/acpi/processor.c: In function `acpi_processor_get_power_info_cst':
drivers/acpi/processor.c:668: error: structure has no member named `count'
drivers/acpi/processor.c:691: error: dereferencing pointer to incomplete type
drivers/acpi/processor.c:692: error: dereferencing pointer to incomplete type
drivers/acpi/processor.c:695: error: dereferencing pointer to incomplete type
drivers/acpi/processor.c:696: error: dereferencing pointer to incomplete type
drivers/acpi/processor.c:703: error: structure has no member named `type'
drivers/acpi/processor.c:718: error: structure has no member named `type'
drivers/acpi/processor.c:818: error: structure has no member named `count'
drivers/acpi/processor.c:818: error: structure has no member named `count'
drivers/acpi/processor.c:819: error: structure has no member named `count'
drivers/acpi/processor.c:823: error: structure has no member named `count'
drivers/acpi/processor.c:825: error: structure has no member named `count'
drivers/acpi/processor.c:828: error: structure has no member named `count'
drivers/acpi/processor.c: In function `acpi_processor_get_power_info_fadt':
drivers/acpi/processor.c:892: error: structure has no member named `type'
drivers/acpi/processor.c:895: error: structure has no member named `count'
drivers/acpi/processor.c:951: error: structure has no member named `type'
drivers/acpi/processor.c:955: error: structure has no member named `count'
drivers/acpi/processor.c: In function `acpi_processor_get_power_info':
drivers/acpi/processor.c:979: error: structure has no member named `type'
drivers/acpi/processor.c:991: error: structure has no member named `type'
drivers/acpi/processor.c:992: error: structure has no member named `count'
drivers/acpi/processor.c:1018: error: structure has no member named `count'
drivers/acpi/processor.c: In function `acpi_processor_power_seq_show':
drivers/acpi/processor.c:2147: error: structure has no member named `count'
drivers/acpi/processor.c:2150: error: structure has no member named `type'
drivers/acpi/processor.c: In function `acpi_processor_add':
drivers/acpi/processor.c:2603: error: structure has no member named `count'
make[3]: *** [drivers/acpi/processor.o] Error 1
make[2]: *** [drivers/acpi] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.4-rc1-test'
make: *** [stamp-build] Error 2
gismo:/usr/src/linux-2.6.4-rc1-test#
=====

Should I wait for a patch against 2.6.4 + latest ACPI or should I try the old 2.6.1?

BTW, 2.6.4 + ACPI 20040220 has the same problem as the older one, I mean, same
error on ACPI and only C1 :-(

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFARIFpVAp7Xm10JmkRAp+LAJ9xUd96H62JjkIRropA0XCjVMTebACbBqil
qa7YtCuawPalRAehnh3hHDs=
=oKSv
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
