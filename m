From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: 2.6.0-pre4 hangs if acpi enabled
Date: Mon, 25 Aug 2003 13:33:13 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030825113313.GA10691@lps.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: Linux Kernel mailing list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

When booting 2.6.0-pre4 on my intel P4 with a shuttle motherboard, the
computer hangs after printing

	hda: max request size: 128KiB
	hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=3D65535/16/63,=
 UDMA(100)
	 hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
	mice: PS/2 mouse device common for all mice

No scroll from the keyboard, no sys-rq, Caps-lock doesn't lit the led o=
n
the keyboard. The computer is completely frozen.

On a normal boot, the following lines are

	serio: i8042 AUX port at 0x60,0x64 irq 12
	input: AT Set 2 keyboard on isa0060/serio0
	serio: i8042 KBD port at 0x60,0x64 irq 1

2.6.0-pre1 was working nicely. I haven't tried 2.6.0-pre2 or -pre3.
2.6.0-pre4 works if I append acpi=3Doff of pci=3Dnoacpi at the boot
commandline.

You will find on <http://perso.nerim.net/~tudia/bug-reports/> the
complete boot messages, the configuration of the kernel, the dsdt, the
output of lspci -vv, etc. Please tell me if some relevant information i=
s
missing.

Regards,

	=C9ric Brunet
