From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Linux/ACPI 2.4 release status and cpufreq
Date: Mon, 15 Dec 2003 12:42:47 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3FDD9E37.2090307@pca.it>
References: <C386328088ED7F4E9F81AFBABDDF60DA0378C85A@wdmyexch02.my.asia.wdc.com> <20031215112626.GB5898@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031215112626.GB5898-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
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

on 12/15/03 12:26, Micha Feigin wrote:
| The cvs version (iirc mentioned earlier in this thread, otherwise
| search the archives) applied cleanly to 2.4.23 last time I checked.
well, I just got an error applying the latest 'cpufreq' from
	http://ftp.linux.org.uk/pub/linux/cpufreq/

Here's the error (I used a fresh 2.4.23 with the latest ACPI patch):
| gismo:/usr/src/linux-2.4.23# bunzip2 -c
../kernel/cpufreq-LINUX_2_4-20031215.tar.bz2 | patch -p1
| missing header for unified diff at line 57 of patch
| patching file Documentation/00-INDEX
| patching file Documentation/Configure.help
| patching file Makefile
| patching file arch/i386/boot/setup.S
| patching file arch/i386/config.in
| patching file arch/i386/kernel/Makefile
| patching file arch/i386/kernel/i386_ksyms.c
| patching file arch/i386/kernel/setup.c
| patching file arch/i386/kernel/time.c
| patching file drivers/Makefile
| patching file include/asm-i386/ist.h
| patching file include/asm-i386/msr.h
| patching file include/asm-i386/smp.h
| patching file include/linux/smp.h
| patch unexpectedly ends in middle of line
| gismo:/usr/src/linux-2.4.23#

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/3Z42VAp7Xm10JmkRAjl6AJ956SUyP5EK5YxIntR9lLdaD3igDQCfYNsw
FH5MhlkTBT/le4358VeqbA4=
=azW0
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
