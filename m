From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ACPI regression? Was Re: Ethernet chip disappeared from lspci
Date: Sat, 20 Jun 2015 01:13:10 +0200
Message-ID: <12950452.K8inU2UIYe@vostro.rjw.lan>
References: <55841815.5000701@pr.hu> <558419B2.7010703@pr.hu> <55841D48.8080809@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55841D48.8080809@pr.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Friday, June 19, 2015 03:46:48 PM Boszormenyi Zoltan wrote:
> Hi,
>=20
> so after the network card came alive again, I tried kernels
> 3.18.16, 4.0.5 and 4.1.0-rc8. With the last two kernels, when
> loading the r8169 driver, I experience the symptoms described
> below. Also, after booting 4.0.5 and then 4.1.0-rc8, the network
> card disappeared from the PCI devices again, neither PXE shows up
> nor the device in lspci.
>=20
> It seems I will have to wait again until the battery loses its
> capacity since the last testing to get the network chip back.
>=20
> I would be happy to test patches that may fix this behavior.
>=20
> With 3.18.16 and the device in lspci, the network works with r8169.

The only think I can suggest is to try this patch:

https://patchwork.kernel.org/patch/6628061/

and see if it makes any difference.


> 2015-06-19 15:31 keltez=C3=A9ssel, Boszormenyi Zoltan =C3=ADrta:
> > Nevermind, this is a POS machine with a big battery inside.
> > When I allowed it to discharge, the network card came back
> > with PXE boot. There might have been some bad state kept
> > by the battery.
> >
> > Sorry for the noise.
> >
> > 2015-06-19 15:24 keltez=C3=A9ssel, Boszormenyi Zoltan =C3=ADrta:
> >> Hi,
> >>
> >> I have a problem on a special POS mainboard that has
> >> a Realtek RTL8111/8168/8411 chip. I use mainline kernel 4.0.5.
> >>
> >> The initial problem was that when r8169 was not blacklisted,
> >> as soon as this driver loaded, a lot of IRQ problems popped up,
> >> like pressing keys on the USB keyboard made the keys duplicated
> >> and the system was sluggish. Upon powering off the system,
> >> the r8169 driver compained about "rtl_eriar_cond =3D 1 loop 100"
> >> or something like that and the system couldn't even reboot or
> >> get powered down properly.
> >>
> >> It was impossible to get dmesg or other diagnostics info out of
> >> the system in this state.
> >>
> >> When I blacklisted r8169, everything was OK except there was
> >> no network, obviously.
> >>
> >> I also noticed that with kernel 4.0.5, there are memory range conf=
licts, like
> >>
> >> pci 0000:00:02.0: can't claim BAR 0 [mem ....]: address conflict w=
ith PCI Bus 0000:00 [mem
> >> ... window]
> >>
> >> I also tried to load the r8168 driver from Realtek, with the
> >> same results as with r8169.
> >>
> >> I don't know what happened, was it the "official" Realtek driver
> >> that disabled the chip, or that I toggled the PXE boot in the BIOS=
,
> >> but now lspci doesn't list the ethernet chip anymore and not even
> >> the PXE boot messages show up, despite it being enabled in the BIO=
S.
> >> I tried kernels 3.18.16, 4.0.5 again and 4.1.0-rc8.
> >>
> >> I have this in dmesg:
> >>
> >> [    0.136171] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 *7 10=
 11 12 14 15)
> >> [    0.136323] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 =
11 12 *14 15)
> >> [    0.136466] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 =
11 12 14 *15)
> >> [    0.136609] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 =
11 12 14 *15)
> >> [    0.136751] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 =
11 12 14 15) *0, disabled.
> >> [    0.136894] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 =
11 12 14 15) *0, disabled.
> >> [    0.137050] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 =
11 12 14 15) *0, disabled.
> >> [    0.137195] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 *6 7 10=
 11 12 14 15)
> >>
> >> and
> >>
> >> [    0.139098] PCI: Using ACPI for IRQ routing
> >> [    0.139098] PCI: pci_cache_line_size set to 64 bytes
> >> [    0.139098] pci 0000:00:02.0: can't claim BAR 0 [mem 0xfeb00000=
-0xfeb7ffff]: address
> >> conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff window]
> >> [    0.139098] pci 0000:00:02.0: can't claim BAR 2 [mem 0xd0000000=
-0xdfffffff pref]:
> >> address conflict with PCI Bus 0000:00 [mem 0x7f700000-0xdfffffff w=
indow]
> >> [    0.139104] pci 0000:00:02.0: can't claim BAR 3 [mem 0xfea00000=
-0xfeafffff]: address
> >> conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff window]
> >> [    0.139113] pci 0000:00:02.1: can't claim BAR 0 [mem 0xfeb80000=
-0xfebfffff]: address
> >> conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff window]
> >> [    0.139123] pci 0000:00:1b.0: can't claim BAR 0 [mem 0xfe9f8000=
-0xfe9fbfff 64bit]:
> >> address conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff w=
indow]
> >> [    0.139146] pci 0000:00:1d.7: can't claim BAR 0 [mem 0xfe9f7c00=
-0xfe9f7fff]: address
> >> conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff window]
> >> [    0.139161] pci 0000:00:1f.2: can't claim BAR 5 [mem 0xfe9f7800=
-0xfe9f7bff]: address
> >> conflict with PCI Bus 0000:00 [mem 0xf0000000-0xfed8ffff window]
> >> [    0.139190] Expanded resource reserved due to conflict with PCI=
 Bus 0000:00
> >>
> >> Full dmesg for 4.0.5 is attached.
> >>
> >> Can anyone help me re-enable the network card?
> >>
> >> Thanks in advance,
> >> Zolt=C3=A1n B=C3=B6sz=C3=B6rm=C3=A9nyi
> >>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
