From: Patrick Dreker <patrick-G8S07CpUG8qzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] ACPI drop back to pic mode -- linux-2.6.0-test2-acpi-picmode.patch
Date: Thu, 31 Jul 2003 02:28:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307310228.35207.patrick@dreker.de>
References: <200307302100.01386.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200307302100.01386.adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 30. Juli 2003 22:00 schrieb Andrew de Quincey=20
<adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org> zum Thema [ACPI] [PATCH] ACPI drop back to pic mode=
=20
=2D -- linux-2.6.0-test2-acpi-picmode.patch:
> Hi, this is my patch which detects problems in APIC mode and drops back to
> PIC mode. I've tested this on my system and my laptop by hacking APIC mode
> to fail. Seems to be fine.
>
> To apply:
> Grab linux-2.6.0-test2
> Apply the latest interim ACPI patch from http://sf.net/projects/acpi
> Apply linux-2.6.0-test2-acpi-picmode.patch
> See if it works!
>
> Any probs, let me know.
OK, here you go...

System: Asus A7N8X-Deluxe (NForce2), AMD Barton 2800+, Kernel 2.6.0-test2,=
=20
patches as indicated above, CONFIG_ACPI=3Dy, CONFIG_ACPI_BOOT=3Dy,=20
CONFIG_X86_UP_APIC=3Dy, CONFIG_X86_UP_IOAPIC=3Dy.

=46irst I noticed something minor during compile:
drivers/acpi/pic_irq.c: In function acpi_pci_irq_init:
drivers/acpi/pic_irq.c:519: warning: implicit declaration of function=20
'pic_parse_prt'
Pretty sure that wasn't there before the patches...

After accidentally booting the patched kernel with acpi=3Doff I got the=20
following oops very early in the boot process (NOTE: handcopied from the=20
screen, no serial console attached):
EIP: acpi_pci_link_penalties+0x8/0x79
Call Trace:
acpi_pci_irq_init+0x8/0x5a
pci_acpi_init+0x22/0x80
do_initcalls+0x2b/0xa0
init_workqueues+0xf/0x30
init+0x2a/0x180
init+0x0/0x180
kernel_thread_helper=3D0x5/0x10

Before patching the kernel with the picmode.patch booting with acpi=3Doff w=
as no=20
problem (aside from some devices not getting an IRQ assigned). Whether I=20
enable or disable the APIC (at compile time, as well as with the "noapic"=20
kernel option) does not matter. If ACPI is enabled all is fine. The APIC is=
=20
enabled and all devices are assigned IRQs (which is not the case without=20
ACPI).

I will now have to watch for more lockups, but I am not even sure they are =
in=20
any way related to ACPI/APIC (though it "feels" like the machine is hung wi=
th=20
all interrupts disabled, and the watchdog does not kick in, Magic SysRq=20
doesn't work either)

Addendum: one reboot later: the machine still randomly locks up hard. The=20
hardware has been tested (memtest, no overclocking, heatsinks, PSU etc.=20
OK...). Any tipps, how I can find out where or when it locks up?

=2D --=20
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
=46ingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc


=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KGKycERm2vzC96cRAh/1AJ9CHXJ6gHOSJvelDmKknLU2PQOVdQCcCl3J
bp+ntHQYMtArLiK8LjpOpQk=3D
=3DFQO4
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
