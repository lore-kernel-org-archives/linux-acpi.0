From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
Subject: Re: Linux/ACPI 2.4 release status and cpufreq
Date: Mon, 15 Dec 2003 18:11:53 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031215161153.GD5898@luna.mooo.com>
References: <C386328088ED7F4E9F81AFBABDDF60DA0378C85A@wdmyexch02.my.asia.wdc.com> <20031215112626.GB5898@luna.mooo.com> <3FDD9E37.2090307@pca.it> <20031215125917.0eca2dc1.subscript@free.fr> <3FDDC047.9070105@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FDDC047.9070105-wlebWZzHoyE@public.gmane.org>
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

On Mon, Dec 15, 2003 at 03:08:07PM +0100, Luca Capello wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on 12/15/03 12:59, wwp wrote:
> | Using cpufreq-LINUX_2_4-20031215.tar.bz2, patching manually
> | w/ `patch -p1 --dry-run < patch` against a 2.4.33+acpi+ieee1394+
> | other-various-patches:
> this sounds quite strange, because here:
> 
> | gismo:/usr/src/linux-2.4.23# patch -p1 --dry-run <
> cpufreq-LINUX_2_4-20031215.tar.bz2
> | patch unexpectedly ends in middle of line
> | patch: **** Only garbage was found in the patch input.
> | gismo:/usr/src/linux-2.4.23#
> 
> of the same
> 
> | gismo:/usr/src/linux-2.4.23# patch -p1 --dry-run <
> cpufreq-LINUX_2_4-20031215.tar
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
> Anyway, I made some tests:
> - - I've always the problem above if I use the command
> 	bunzip2/gunzip -c [patch].bz2/gz | patch -p1
> 
> - - if I bunzip2/gunzip + untar (so 'tar xvf[j|z]') and then I use the
> manual patching script present in the 'cpufreq' package, all goes well
> 

Thats because if you just bunzip2/gunzip -c [patch].bz2/gz | patch -p1
you get the raw tar file piped into patch and of course patch can't
handle that.
When you untar there is a patch file in the top directory which is the
patch that should be applied and some files that are linked to.

> As this is the only patch which doesn't work on my system, I think
> there's a problem in the patch, but maybe as I'm on Debian unstable,
> there could be some bugs on my machine.
> 

Don't think that its debian unstable since I am using debian unstable
and my system is rock solid (There are the occasional problematic
programs but very rare. Most of the problem is the occasional
dependencies that get update with a delay and require manually resolving
the broken packages on update).
Using the debian kernel with external patches can cause problems though
as there are all sorts of patches added by debian that may collide.
I am using vanilla kernel from www.kernel.org for years now without any
problems.

> Thx, bye,
> Gismo / Luca
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> Comment: Using GnuPG with Debian - http://enigmail.mozdev.org
> 
> iD8DBQE/3cBGVAp7Xm10JmkRAgqeAJ42124ybVwEjgiXy0VBpYVP7T8ieACffhZZ
> hMhWLK57AiBrqz5vLTE/Qfw=
> =ta8/
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
