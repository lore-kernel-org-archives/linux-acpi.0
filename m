From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Wed, 29 Apr 2009 17:08:51 -0600
Message-ID: <200904291708.52830.bjorn.helgaas@hp.com>
References: <49ED22EC.2040204@kernel.org> <200904271624.17295.bjorn.helgaas@hp.com> <86802c440904271907r335f7834p8f03aa13bc6515e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <86802c440904271907r335f7834p8f03aa13bc6515e8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-acpi@vger.kernel.org

On Monday 27 April 2009 08:07:01 pm Yinghai Lu wrote:
> On Mon, Apr 27, 2009 at 3:24 PM, Bjorn Helgaas <bjorn.helgaas@hp.com>=
 wrote:
> > On Monday 27 April 2009 03:00:16 pm Yinghai Lu wrote:
> >> On Mon, Apr 27, 2009 at 1:39 PM, Bjorn Helgaas <bjorn.helgaas@hp.c=
om> wrote:
> >> >> other system may have broken _CRS.
> >> >
> >> > Do you have examples of problems here, or are you just worried t=
hat
> >> > there *may* be problems?
> >> one system with three chains... with pci=3Duse_crs
> >> [ =A0 =A09.365669] pci_bus 0000:00: resource 0 io: =A0[0x00-0x3af]
> >> [ =A0 =A09.371065] pci_bus 0000:00: resource 1 io: =A0[0x3e0-0xcf7=
]
> >> [ =A0 =A09.376551] pci_bus 0000:00: resource 2 io: =A0[0x3b0-0x3bb=
]
> >> [ =A0 =A09.382028] pci_bus 0000:00: resource 3 io: =A0[0x3c0-0x3df=
]
> >> [ =A0 =A09.387513] pci_bus 0000:00: resource 4 io: =A0[0xd00-0xeff=
f]
> >> [ =A0 =A09.393077] pci_bus 0000:00: resource 5 mem: [0x0a0000-0x0b=
ffff]
> >> [ =A0 =A09.399084] pci_bus 0000:00: resource 6 mem: [0x0d0000-0x0d=
ffff]
> >> [ =A0 =A09.405089] pci_bus 0000:00: resource 7 mem: [0xdd000000-0x=
dfffffff]
> >> [ =A0 =A09.505332] pci_bus 0000:40: resource 0 io: =A0[0x5000-0x8f=
ff]
> >> [ =A0 =A09.510991] pci_bus 0000:40: resource 1 mem: [0xdb000000-0x=
dcffffff]
> >> [ =A0 =A09.553378] pci_bus 0000:80: resource 0 io: =A0[0x1000-0x4f=
ff]
> >> [ =A0 =A09.559036] pci_bus 0000:80: resource 1 mem: [0xda000000-0x=
daffffff]
> >>
> >> without that: amd_bus.c will read that from pci conf space
> >> [ =A0 =A09.310965] pci_bus 0000:00: resource 0 io: =A0[0x9000-0xef=
ff]
> >> [ =A0 =A09.316621] pci_bus 0000:00: resource 1 io: =A0[0x00-0xfff]
> >> [ =A0 =A09.322020] pci_bus 0000:00: resource 2 mem: [0xdd000000-0x=
dfffffff]
> >> [ =A0 =A09.328373] pci_bus 0000:00: resource 3 mem: [0x0a0000-0x0b=
ffff]
> >> [ =A0 =A09.334378] pci_bus 0000:00: resource 4 mem: [0xc0000000-0x=
d9ffffff]
> >> [ =A0 =A09.340731] pci_bus 0000:00: resource 5 mem: [0xf0000000-0x=
ffffffff]
> >> [ =A0 =A09.347084] pci_bus 0000:00: resource 6 mem: [0x840000000-0=
xfcffffffff]
> >> [ =A0 =A09.444440] pci_bus 0000:40: resource 0 io: =A0[0x5000-0x8f=
ff]
> >> [ =A0 =A09.450099] pci_bus 0000:40: resource 1 io: =A0[0xf000-0xff=
ff]
> >> [ =A0 =A09.455757] pci_bus 0000:40: resource 2 mem: [0xdb000000-0x=
dcffffff]
> >> [ =A0 =A09.498118] pci_bus 0000:80: resource 0 io: =A0[0x1000-0x4f=
ff]
> >> [ =A0 =A09.503777] pci_bus 0000:80: resource 1 mem: [0xda000000-0x=
daffffff]
> >
> > It's interesting that many of the differences involve the legacy
> > VGA I/O ports in the 0x3b0-0x3df range. =A0My guess is that the AMD
> > chipset has special routing for those ranges. =A0If it didn't, it
> > would be difficult to support VGA devices under the other two
> > root bridges. =A0Maybe that VGA routing doesn't show up in the
> > bridge's PCI config space. =A0Can you tell from the ASL whether the
> > root bridge _SRS/_PRS/_CRS methods handle the VGA ranges specially?
> >
> > One of the differences is that PCI config space shows a 64-bit regi=
on
> > (bus 0000:00 mem 0x840000000-0xfcffffffff) that doesn't show up in
> > the _CRS info. =A0But the _CRS parsing depends on acpi_resource_to_=
address64(),
> > which doesn't know about the ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64
> > descriptors added in ACPI 3.0. =A0So this difference could be a res=
ult
> > of that Linux bug. =A0It'd be interesting to see whether the test p=
atch
> > below makes a difference.
> will check it.

Did you learn anything about this?  I have a PNPACPI patch to parse
these new descriptors, but I don't have any machines where I can test
it.  If your box uses that descriptor, it'd be nice to test the patch
there.

> > The PCI config space region 0xf0000000-0xffffffff, also on bus 0000=
:00,
> > looks suspicious to me. =A0I thought that area contained a bunch of
> > BIOS-y things like reset vectors and local APICs.
>=20
> in the amd_bus.c, will put left over resource to def HT chain.
>=20
> YH
>=20
