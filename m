From: Petr Vavra <petr-ewvLLG/tgEk@public.gmane.org>
Subject: kernel 2.4.20: 3 bugs in: i387.c; make xconfig; acpi
Date: Sun, 08 Jun 2003 16:07:36 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EE35F48.56A00972@vavra.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: gareth-jCdQPDEk3idBDgjK7y7TUQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mec-WqBc5aa1uDFeoWH0uzbU5w@public.gmane.org, bug-gnu-utils-n5io46ZZ9gDezta1RN11IA@public.gmane.org
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

kernel 2.4.20
I am using linux based on Redhat 5.2, with upgrades and updates from source code libraries:
gcc version pgcc-2.91.60 19981201 (egcs-1.1.1 release)
tcsh-6.07.09-1
make version 3.76.1
---------------------------------------------------------
i387.c:
If I've run make menuconfig and select processor Pentium-MMX family and unselect Math emulation I got:

'gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -march=i586 -nostdinc -iwithprefix include -DKBUILD_BASENAME=i387  -c -o i387.o i387.c'
{standard input}: Assembler messages:
{standard input}:61: Error: no such 386 instruction: fxrstor
{standard input}:85: Error: no such 386 instruction: fxsave
{standard input}:118: Error: no such 386 instruction: fxsave
{standard input}:143: Error: no such 386 instruction: fxrstor
make[1]: *** [i387.o] Error 1
make[1]: Leaving directory /usr/src/linux-2.4.20/arch/i386/kernel
make: *** [_dir_arch/i386/kernel] Error 2
---------------------------------------------------------
make xconfig:
in section 'parallel port support' (menu 12) are two same lines:
'y-m-n Support for PCMCIA management for PC-style ports Help' one is enabled (line #6) and second (line #7) is disabled (gray).
And is not possible change anything in any of these rows.

support of PCMCIA I've enabled

look for variable CONFIG_PARPORT_PC_PCMCIA in scripts/kconfig.tk rows 3043 and 3044 are same (except one parameter)
dep_tristate $w.config.f 12 5 "    Support for PCMCIA management for PC-style ports" CONFIG_PARPORT_PC_PCMCIA
dep_tristate $w.config.f 12 6 "    Support for PCMCIA management for PC-style ports" CONFIG_PARPORT_PC_PCMCIA

if I select exit and save i got message:
ERROR - Attempting to write value for unconfigured variable (CONFIG_PARPORT_PC_PCMCIA).

if I run 'make menuconfig' this part of menu is OK
---------------------------------------------------------
drivers/acpi:
In this section in the time of compilation (make dep) is problem with $CURDIR.
compilation gives many errors,
I think that $CURDIR is empty string - is not possible to find any include libraries from acpi/include.

I've modified all rows in all Makefiles in acpi directory that contain $CURDIR and changed it to directory where the files resides. After that
make dep
make modules
make bzImage
are running well through acpi section...
---------------------------------------------------------
Have a nice day

Petr




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
