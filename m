From: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: 2.6.0-pre4 hangs if acpi enabled
Date: Mon, 25 Aug 2003 14:18:33 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1061813912.710.18.camel@teapot.felipe-alfaro.com>
References: <20030825113313.GA10691@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030825113313.GA10691-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
To: =?ISO-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: Linux Kernel mailing list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-08-25 at 13:33, =C9ric Brunet wrote:
> Hi,
>=20
> When booting 2.6.0-pre4 on my intel P4 with a shuttle motherboard, th=
e
> computer hangs after printing
>=20
> 	hda: max request size: 128KiB
> 	hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=3D65535/16/6=
3, UDMA(100)
> 	 hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
> 	mice: PS/2 mouse device common for all mice
>=20
> No scroll from the keyboard, no sys-rq, Caps-lock doesn't lit the led=
 on
> the keyboard. The computer is completely frozen.

Well, if you are using ACPI, then this is a know behaviour with -test4
releases. It's ACPI related. Please, take a look at the following bug
report:

http://bugzilla.kernel.org/show_bug.cgi?id=3D1123

During boot, the kernel checks for i8042 AUX/MUX ports, tries
registering IRQ #12 and then hangs. I fixed the problem on my i845DE
motherboard by flashing a new BIOS with APIC and IOAPIC support. Then, =
I
recompiled 2.6.0-test4 with APIC and IOAPIC support and the hangs went
away.

If you can't use/compile APIC and IOAPIC for your motherboard, try
booting the kernel with "pci=3Dnoacpi" as a workaround. This will preve=
nt
from using ACPI IRQ routing and use standard PCI IRQ routing. Also, if
you have the time, please, attach your "dmidecode" and "acpidmp" to the
bug report at the above URL.

Thanks!
