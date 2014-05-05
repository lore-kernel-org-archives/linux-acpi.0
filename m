From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 part1 08/11] ARM64 / ACPI: Introduce PCI functions for ACPI on ARM64
Date: Mon, 05 May 2014 15:09:26 +0200
Message-ID: <4761400.zttHIHIKh6@wuerfel>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org> <8888740.lgd2Xkrtad@wuerfel> <53674D62.5020004@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:63876 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbaEENJg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2014 09:09:36 -0400
In-Reply-To: <53674D62.5020004@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linaro-acpi@lists.linaro.org, Rob Herring <robh@kernel.org>, Mark Brown <broonie@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 05 May 2014 16:35:46 Hanjun Guo wrote:
> On 2014-4-29 18:01, Arnd Bergmann wrote:
> [...]
> >>> For raw_pci_{read,write} we can have a trivial generic implementa=
tion in
> >>> the PCI core, like
> >>>
> >>> int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> >>> 		  unsigned int devfn, int reg, int len, u32 *val)
> >>> {
> >>> 	struct pci_bus *bus =3D pci_find_bus(domain, bus);
> >>> 	if (!bus)
> >>> 		return -ENODEV;
> >>>
> >>> 	return bus->ops->read(bus, devfn, reg, len, val);
> >>> }
> >>>
> >>> which won't work on x86 or ia64, but should be fine everywhere el=
se. Alternatively,
> >>> you can change the ACPI code to do the above manually and call th=
e architecture
> >>> independent interfaces, either bus->ops->read, or pci_bus_read_co=
nfig_{byte,word,dword},
> >>> which would actually simplify the ACPI code.
> >>
> >> This may not work. ACPI needs to be able to access PCI config spac=
e before
> >> we've done a PCI bus scan and created pci_bus structures, so the p=
ointer
> >> of bus will be NULL.
> >=20
> > Hmm, this is a serious issue, and I don't have a good idea for how
> > to solve it yet, we need to discuss it some more I think.
> >=20
> > We are currently working on generic PCI support for ARM64 with DT, =
which
> > will be based around the concept that all PCI host drivers can be l=
oadable
> > modules, and each host driver would supply its own config space acc=
ess
> > method.
>=20
> this will be the problem, ACPI may access config space before modules=
 are
> loaded.

I've given it some more thought independently. In the end, I think it's
not a big issue because the standard PCI driver for ACPI will be rather
trivial and we can always have that built-in.

It destroys my dream of making the PCI core itself a loadable module,
but I wasn't sure if that was realistic anyway, and we may still be abl=
e
to do that for non-ACPI configurations.

> > With ACPI, we probably don't need the flexibility, because hopefull=
y all
> > PCI host bridges will be SBSA compliant and have a regular ECAM con=
fig
> > space implementation (as opposed to the proprietary methods used by
> > e.g. APM X-Gene, Samsung GH7 or everything we have on ARM32).
> >=20
> > If we can rely on always having ECAM support available, it would be
> > easy enough to add an implementation of that specifically for ACPI,
> > outside of the architecture code or the PCI core, or we could have
> > a global implementation of that, which gets used by both ACPI and
> > the compliant PCI host bridge drivers and can be built-in even for
> > loadable host drivers.
> >=20
> > Alternatively, you could try to see if it's possible to defer the P=
CI
> > access to the time the host driver is loaded. Do you know what the =
access
> > to config space is actually needed for?
>=20
> There is a statement in ACPI 5.0a spec:
> OSPM must guarantee that the following operation regions must always =
be
> accessible (which means even before the driver is ready):
> PCI_Config operation regions on a PCI root bus containing a _BBN obje=
ct.
> (invoke _BBN method will return PCI bus number)

Hmm, the next statement there is

* I/O operation regions.

That one is even harder to make available in general, in particular
because SBSA says it doesn't have to be provided at all.

> And raw_pci_{read,write} will be called in ACPICA to access the PCI_C=
onfig
> to get some information, so theoretic any device defined in DSDT with
> PCI_Config operation region which be enumerated before PCI host bridg=
e will
> access config space before the PCI bus scan.

Just to confirm: Are they called before pci_acpi_scan_root()?

In the same section you quote, it seems not:

It should be noted that PCI Config Space Operation Regions are ready as
soon the host controller or bridge controller has been programmed with =
a
bus number. PCI1=E2=80=99s _REG method would not be run until the PCI-P=
CI bridge
has been properly configured.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
