From: "Jerry CrunchTime" <jerry.c.t-S0/GAf8tV78@public.gmane.org>
Subject: Sleep modes - compile error
Date: Wed, 13 Nov 2002 22:57:57 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <2189.80.144.12.184.1037224677.squirrel@unimail.uni-dortmund.de>
Reply-To: jerry.c.t-S0/GAf8tV78@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

if try to compile the kernel 2.5.47 with the newest acpi patch
(acpi-20021111-2.5.47.diff.gz) and the option "Sleep states" enabled, i
get the follwing error message:
drivers/built-in.o: In function `acpi_system_suspend':
drivers/built-in.o(.text+0x35def): undefined reference to
`do_suspend_lowlevel'

This happens when the linker tries to link vmlinuz:
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o =

init/built-in.o --start-group  usr/built-in.o
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o =

arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o =

fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o =

lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o =

arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux

What did i wrong?

Jerry




-------------------------------------------------------
This sf.net email is sponsored by: Are you worried about 
your web server security? Click here for a FREE Thawte 
Apache SSL Guide and answer your Apache SSL security 
needs: http://www.gothawte.com/rd523.html
