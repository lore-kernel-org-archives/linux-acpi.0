From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Linux/ACPI 2.4 release status and cpufreq
Date: Mon, 15 Dec 2003 18:06:40 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031215160640.GC5898@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA0378C85A@wdmyexch02.my.asia.wdc.com> <20031215112626.GB5898@luna.mooo.com> <3FDD9E37.2090307@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FDD9E37.2090307-wlebWZzHoyE@public.gmane.org>
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

On Mon, Dec 15, 2003 at 12:42:47PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 12/15/03 12:26, Micha Feigin wrote:
> | The cvs version (iirc mentioned earlier in this thread, otherwise
> | search the archives) applied cleanly to 2.4.23 last time I checked.
> well, I just got an error applying the latest 'cpufreq' from
> 	http://ftp.linux.org.uk/pub/linux/cpufreq/
> 
> Here's the error (I used a fresh 2.4.23 with the latest ACPI patch):
> | gismo:/usr/src/linux-2.4.23# bunzip2 -c
> ../kernel/cpufreq-LINUX_2_4-20031215.tar.bz2 | patch -p1

If you'll notice the file is a tar.bz2 and not just bz2.
What you need to do is
tar -xjf cpufreq-LINUX_2_4-20031215.tar.bz2
cd cpufreq
./patchin.sh <kernel-dir>
This will patch you're kernel and add links to the cpufreq files.

> | missing header for unified diff at line 57 of patch
> | patching file Documentation/00-INDEX
> | patching file Documentation/Configure.help
> | patching file Makefile
> | patching file arch/i386/boot/setup.S
> | patching file arch/i386/config.in
> | patching file arch/i386/kernel/Makefile
> | patching file arch/i386/kernel/i386_ksyms.c
> | patching file arch/i386/kernel/setup.c
> | patching file arch/i386/kernel/time.c
> | patching file drivers/Makefile
> | patching file include/asm-i386/ist.h
> | patching file include/asm-i386/msr.h
> | patching file include/asm-i386/smp.h
> | patching file include/linux/smp.h
> | patch unexpectedly ends in middle of line
> | gismo:/usr/src/linux-2.4.23#
> 
> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQE/3Z42VAp7Xm10JmkRAjl6AJ956SUyP5EK5YxIntR9lLdaD3igDQCfYNsw
> FH5MhlkTBT/le4358VeqbA4=
> =azW0
> -----END PGP SIGNATURE-----
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
