From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: ASUS M6800N: processor has only C1
Date: Wed, 03 Mar 2004 21:18:08 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40463D80.8040800@pca.it>
References: <404459FD.1000406@pca.it> <20040302110946.GF2869@poupinou.org> <40448169.6090507@pca.it> <40449D8E.4060402@pca.it> <20040303103528.GG2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040303103528.GG2869-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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

on 03/03/04 11:35, Bruno Ducrot wrote:
> Thanks.  Sound like that I send only an half patch, sorry.
nothing changed, well, I got one more error:
=====
acpi_processor-2490 [29] acpi_processor_get_inf: Invalid PBLK length [7]
acpi_processor-0654 [31] acpi_processor_get_pow: Invalid _CST data
ACPI: Processor [CPU1] (supports C1)
=====

I tried this on kernel 2.6.4-rc1 + ACPI 20040220 with the original DSDT.

I tried to compile the same kernel with 'ACPI DSDT in initrd' patch, but after
the patch applied with some hunks (just one failed in a comment section), I got
an error:
=====
  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o(.init.text+0x347f): In function `populate_rootfs':
: undefined reference to `dsdt_start'
init/built-in.o(.init.text+0x3546): In function `populate_rootfs':
: undefined reference to `dsdt_start'
drivers/built-in.o(.text+0x869e): In function `acpi_os_table_override':
: undefined reference to `dsdt_start'
drivers/built-in.o(.text+0x86b0): In function `acpi_os_table_override':
: undefined reference to `dsdt_start'
drivers/built-in.o(.text+0x2933e): In function `acpi_tb_table_override':
: undefined reference to `dsdt_start'
drivers/built-in.o(.text+0x2934f): more undefined references to `dsdt_start' follow
make[1]: *** [.tmp_vmlinux1] Error 1
make[1]: Leaving directory `/usr/src/linux-2.6.4-rc1.processor-cst.acpi-initrd'
make: *** [stamp-build] Error 2
gismo:/usr/src/linux-2.6.4-rc1.processor-cst.acpi-initrd#
=====

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFARj14VAp7Xm10JmkRAnKCAJ0QkEsEPaWW/6K/dPWd2erkzllmeACdEJXg
Jfd//ZiKf50KkgyEQPFRH2A=
=jPlO
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
