From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Tue, 02 Mar 2004 15:43:26 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40449D8E.4060402@pca.it>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40448169.6090507-wlebWZzHoyE@public.gmane.org>
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

on 03/02/04 13:43, Luca Capello wrote:
> On the other hand, I got these error when compiling:
> ======
>   CC [M]  drivers/acpi/processor.o
> drivers/acpi/processor.c: In function `acpi_processor_power_activate':
> drivers/acpi/processor.c:311: error: structure has no member named `type'
> drivers/acpi/processor.c:315: error: structure has no member named `type'
> drivers/acpi/processor.c:321: error: structure has no member named `type'
> drivers/acpi/processor.c: In function `acpi_processor_idle':
> drivers/acpi/processor.c:409: error: structure has no member named `type'
> drivers/acpi/processor.c: In function `acpi_processor_set_power_policy':
> drivers/acpi/processor.c:548: error: structure has no member named `count'
> drivers/acpi/processor.c:549: error: structure has no member named `type'
> drivers/acpi/processor.c: In function `acpi_processor_get_power_info_cst':
> drivers/acpi/processor.c:668: error: structure has no member named `count'
> drivers/acpi/processor.c:691: error: dereferencing pointer to incomplete type
> drivers/acpi/processor.c:692: error: dereferencing pointer to incomplete type
> drivers/acpi/processor.c:695: error: dereferencing pointer to incomplete type
> drivers/acpi/processor.c:696: error: dereferencing pointer to incomplete type
> drivers/acpi/processor.c:703: error: structure has no member named `type'
> drivers/acpi/processor.c:718: error: structure has no member named `type'
> drivers/acpi/processor.c:818: error: structure has no member named `count'
> drivers/acpi/processor.c:818: error: structure has no member named `count'
> drivers/acpi/processor.c:819: error: structure has no member named `count'
> drivers/acpi/processor.c:823: error: structure has no member named `count'
> drivers/acpi/processor.c:825: error: structure has no member named `count'
> drivers/acpi/processor.c:828: error: structure has no member named `count'
> drivers/acpi/processor.c: In function `acpi_processor_get_power_info_fadt':
> drivers/acpi/processor.c:892: error: structure has no member named `type'
> drivers/acpi/processor.c:895: error: structure has no member named `count'
> drivers/acpi/processor.c:951: error: structure has no member named `type'
> drivers/acpi/processor.c:955: error: structure has no member named `count'
> drivers/acpi/processor.c: In function `acpi_processor_get_power_info':
> drivers/acpi/processor.c:979: error: structure has no member named `type'
> drivers/acpi/processor.c:991: error: structure has no member named `type'
> drivers/acpi/processor.c:992: error: structure has no member named `count'
> drivers/acpi/processor.c:1018: error: structure has no member named `count'
> drivers/acpi/processor.c: In function `acpi_processor_power_seq_show':
> drivers/acpi/processor.c:2147: error: structure has no member named `count'
> drivers/acpi/processor.c:2150: error: structure has no member named `type'
> drivers/acpi/processor.c: In function `acpi_processor_add':
> drivers/acpi/processor.c:2603: error: structure has no member named `count'
> make[3]: *** [drivers/acpi/processor.o] Error 1
> make[2]: *** [drivers/acpi] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.4-rc1-test'
> make: *** [stamp-build] Error 2
> gismo:/usr/src/linux-2.6.4-rc1-test#
> =====
>
> Should I wait for a patch against 2.6.4 + latest ACPI or should I try the old
> 2.6.1?
well, I've tried on the old 2.6.1 (w/o any ACPI patches, as I don't know where I
could find them) and I got the same errors:
=====
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
drivers/acpi/processor.c:1553: error: structure has no member named `count'
drivers/acpi/processor.c:1556: error: structure has no member named `type'
drivers/acpi/processor.c: In function `acpi_processor_add':
drivers/acpi/processor.c:2023: error: structure has no member named `count'
make[3]: *** [drivers/acpi/processor.o] Error 1
make[2]: *** [drivers/acpi] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.1'
make: *** [stamp-build] Error 2
gismo:/usr/src/linux-2.6.1#
=====

So I can suppose this is not a kernel 2.6.1 or 2.6.4 problem, but something
other: am I right?

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFARJ2NVAp7Xm10JmkRApIIAJ47/P1I3b+aJvWBiHOwD/naXGhLUwCfSUPb
194T+dov+lgpkxq+Ly2g3Kk=
=JBCN
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
