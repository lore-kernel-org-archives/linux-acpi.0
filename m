From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Mon, 03 Jul 2006 10:19:07 +0200
Message-ID: <20060703081907.175040@gmx.net>
References: <8BF50482CE9EE245902340E0724784D59B95F2@pdsmsx411.ccr.corp.intel.com>
 <20060630090451.89100@gmx.net> <200606301003.58107.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.21]:48786 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750853AbWGCITI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2006 04:19:08 -0400
In-Reply-To: <200606301003.58107.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com, castet.matthieu@free.fr, shaohua.li@intel.com


-------- Original-Nachricht --------
Datum: Fri, 30 Jun 2006 10:03:57 -0600
Von: Bjorn Helgaas <bjorn.helgaas@hp.com>
An: Uwe Bugla <uwe.bugla@gmx.de>
Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources

> On Friday 30 June 2006 03:04, Uwe Bugla wrote:
> > First of all, what is a root bridge please? I know what a PCI-ISA
> > bridge is, but I stumbled across the expression "root bridge."
>=20
> A PCI root bridge is a device that sits between the processor and
> a PCI bus.  On the upstream side (closer to the processor), it has
> some platform-specific interface.  The downstream side is a standard
> PCI bus.
>=20
> Most PNP devices have some registers that control them.  For example,
> a UART has a receive buffer, a transmit buffer, an interrupt enable
> register, etc.  These appear at specific I/O port or MMIO addresses.
> Those addresses are the resources consumed by the UART.  If you acces=
s
> those resources, the UART responds by doing something.
>=20
> Bridges are different.  They also consume I/O port and/or MMIO addres=
s
> space.  But some of that address space is passed through to the other
> side of the bridge, to the devices on the downstream bus.  In ACPI,
> the resources that are passed to the downstream side are "consumed"
> by the bridge and also "produced" on the downstream side.
>=20
> The UART has no downstream side.  It "consumes" resources but
> doesn't produce any.  (It does produce RS-232 signals on the
> other side, but that's a completely different protocol and outside
> the scope of ACPI.)
>=20
> > As a consequence I do not understand in how far this "root bridge"
> > should be blacklisted.  As far as I have received the issue the
> > decision of blacklisting or rejecting ACPI_PRODUCER is a EITHER-OR
> > one, but NOT a ALSO-THIS and ALSO-THAT one.
>=20
> My opinion is that we must change PNPACPI to either understand or
> ignore the producer resources.  Matthieu posted a patch to ignore
> them.  If we don't do this, we will have the maintenance burden of
> updating a blacklist whenever anybody invents a new device with
> producer resources.
>=20
> We could blacklist PNP0A03 in addition to changing PNPACPI.  For the
> specific bug you tripped over, there's no reason to do both, but I
> think Shaohua is worried about other problems.  For example, if the
> BIOS reported that the PNP0A03 device consumed I/O port 0x3f8, which
> is really consumed by the COM1 UART, that conflict might prevent the
> serial driver from using the UART.
>=20
> Or, somebody could make a PNP driver that claimed PNP0A03 PCI root
> bridges, which would conflict with the existing ACPI driver that
> claims PNP0A03 devices.  Blacklisting PNP0A03 in PNPACPI would preven=
t
> a PNP driver from claiming it.
>=20
> Bjorn

Hi Bjorn,
lots of thanks for your explanations.
What is the path (or strategy) for a PNPACPI concept that handles all d=
evices in a specific box without any IO or interrupt conflicts?
Is BIOS flashing a necessary part of this strategy?

Thanks
Uwe

--=20


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
