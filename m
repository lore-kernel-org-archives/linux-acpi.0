From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
Date: Wed, 24 Jun 2015 11:49:16 +0200
Message-ID: <20150624094916.GA5696@gmail.com>
References: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
 <20150624083019.GA26672@gmail.com>
 <558A7824.3090900@pr.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <558A7824.3090900@pr.hu>
Sender: linux-pci-owner@vger.kernel.org
To: Boszormenyi Zoltan <zboszor@pr.hu>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Boszormenyi Zoltan <zboszor@pr.hu> wrote:

> 2015-06-24 10:30 keltez=E9ssel, Ingo Molnar =EDrta:
> > * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> >
> >> Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource=
 interfaces to=20
> >> simplify implementation"), x86 PCI ACPI host bridge driver validat=
es ACPI=20
> >> resources by first converting an ACPI resource to a 'struct resour=
ce' structure=20
> >> and then applying checks against the converted resource structure.=
 The 'start'=20
> >> and 'end' fields in 'struct resource' are defined to be type of re=
source_size_t,=20
> >> which may be 32 bits or 64 bits depending on CONFIG_PHYS_ADDR_T_64=
BIT.
> >>
> >> This may cause incorrect resource validation results with 32 bit k=
ernels because=20
> >> 64bit ACPI resource descriptors may get truncated when converting =
to 32bit=20
> >> 'start' and 'end' fields in 'struct resource'. And eventually affe=
cts PCI=20
> >> resource allocation subsystem and causes some PCI devices unusable=
=2E
> > s/causes some PCI devices unusuable.
> >   makes some PCI devices unusuable.
> >
> > Also, this description is still pretty vague. What exactly happened=
? Did some PCI=20
> > devices not show up during bootup? Or did they hang? Or did somethi=
ng else happen?
>=20
> There's a reference mail URL in the description, but here it is in fu=
ll glory.
>=20
> The machine in question started behaving like being drunk without thi=
s fix
> with 4.0.5 and 4.1.0-rc8 and 4.1.0-final. 3.18.16 was good.
>=20
> There's a Realtek RTL8111/8168/8411 (PCI ID 10ec:8168, Subsystem ID 1=
565:230e)
> network chip on the mainboard. After the r8169 driver loaded, the IRQ=
s in
> the machine went berserk. Keyboard keypressed arrived with considerab=
le
> latency and duplicated, so no real work was possible. The machine res=
ponded
> to the power button but didn't actually power down. It just stuck at =
the powering
> down message. I had to press the power button for 4 seconds to power =
it down.
>=20
> The computer is a POS machine with a big battery inside. Because of t=
his,
> either ACPI or the Realtek chip kept the bad state and after rebootin=
g, the
> network chip didn't even show up in lspci. Not even the PXE ROM annou=
nced
> itself during boot. I had to disconnect the battery to beat some sens=
e back
> to the computer.

So my point is that this description is more valuable than all the rest=
 of the=20
changelog, and it should be quoted prominently in the first paragraph o=
r so!

And this too should round up the changelog:

> With the fix, the behavior of the machine was restored to how 3.18.16=
 worked,=20
> i.e. the memory range that is over 4GB is ignored again, and lspci -v=
vxxx shows=20
> that everything is at the same memory window as they were with 3.18.1=
6.

as it is far more informative about the practical effects of the fix th=
an anything=20
in the previous versions of the changelog.

Thanks,

	Ingo
