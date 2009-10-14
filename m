From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v2 0/9] PCI, PNP: print resources consistently
Date: Wed, 14 Oct 2009 09:52:01 -0600
Message-ID: <200910140952.02879.bjorn.helgaas@hp.com>
References: <20091013192040.22336.84876.stgit@bob.kio> <86802c440910132347x1913d2a1taf35f385af50e17c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <86802c440910132347x1913d2a1taf35f385af50e17c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Joe Perches <joe@perches.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 14 October 2009 12:47:33 am Yinghai Lu wrote:
> On Tue, Oct 13, 2009 at 12:21 PM, Bjorn Helgaas <bjorn.helgaas@hp.com=
> wrote:
> > These enhance %pR so we can print resource types and flags more eas=
ily.
> > This doesn't really add anything (other than a couple new messages
> > about host bridge apertures), but hopefully it will make things mor=
e
> > consistent and a bit easier to debug. =A0Sample change (with "pci=3D=
use_crs"):
> >
> > =A0 =A0-pci 0000:00:03.0: reg 10 32bit mmio: [0xf6000000-0xf6ffffff=
]
> > =A0 =A0-pci 0000:00:03.0: reg 14 io port: [0x2400-0x24ff]
> > =A0 =A0-pci 0000:00:03.0: reg 18 32bit mmio: [0xf5ff0000-0xf5ff0fff=
]
> > =A0 =A0-pci 0000:00:03.0: reg 30 32bit mmio pref: [0x000000-0x01fff=
f]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x0000-0x0cf=
f]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x0000-0x2cf=
e]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x03b0-0x03b=
b]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [io =A00x03c0-0x03d=
f]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [mem 0xf5d00000-0xf=
6ffffff]
> > =A0 =A0+pci_root PNP0A03:00: host bridge window [mem 0x000a0000-0x0=
00bffff]
> > =A0 =A0+pci 0000:00:03.0: reg 10: [mem 0xf6000000-0xf6ffffff]
> > =A0 =A0+pci 0000:00:03.0: reg 14: [io =A00x2400-0x24ff]
> > =A0 =A0+pci 0000:00:03.0: reg 18: [mem 0xf5ff0000-0xf5ff0fff]
> > =A0 =A0+pci 0000:00:03.0: reg 30: [mem 0x00000000-0x0001ffff pref]
>=20
> can you keep "io port" and "mmio" ?
> so we can use
> grep "io port" dmesg.txt or grep "mmio" dmesg.txt

I don't think that's necessary.  If you want to see only
resource stuff, these greps will work perfectly:

  # dmesg | grep "\[io "
  # dmesg | grep "\[mem "

(This is much better than what's in the current tree, where
resources are labelled with a hodge-podge of mem, mmio, MEM,
io, I/O, io port, IO, or even nothing at all, so you really
can't do the grep at all.)

> also put "io" and "mmio" "pref' in the [  ], looks strange.
> [0xf5ff0000-0xf5ff0fff] is correct range expression.

I could be convinced otherwise, but right now, I don't see a
correctness issue here -- it's just a matter of what the most
convenient format for human readers is.  And I personally like
the fact that everything inside the brackets is an attribute of
the struct resource.

If these are the alternatives:

  bridge window [io  0x0000-0x0cff]
  bridge window io  [0x0000-0x0cff]

one nice thing about the first is that the brackets give a clue
that you should grep for "bridge window", not "bridge window io",
to find the source of the message.

Bjorn
