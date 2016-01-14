From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 17:59:24 +0000
Message-ID: <20160114175924.GC20706@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452785393.28109.16.camel@redhat.com>
 <5697C0EB.4020404@codeaurora.org>
 <20160114161238.GA20706@red-moon>
 <1452789524.28109.24.camel@redhat.com>
 <20160114170723.GB20706@red-moon>
 <1452792723.28109.31.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48370 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbcANR5r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 12:57:47 -0500
Content-Disposition: inline
In-Reply-To: <1452792723.28109.31.camel@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On Thu, Jan 14, 2016 at 12:32:03PM -0500, Mark Salter wrote:
> On Thu, 2016-01-14 at 17:07 +0000, Lorenzo Pieralisi wrote:
> > On Thu, Jan 14, 2016 at 11:38:44AM -0500, Mark Salter wrote:
> >=20
> > [...]
> >=20
> > > You would lose that bet. AddressMinimum/Maximum describe the
> > > PCI bus addresses.
> >=20
> > In the mainline DT (APM Mustang), the CPU physical address correspo=
nding
> > to IO space is 0xe010000000, PCI bus address is 0x0.
> >=20
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 QWordIO (ResourceProducer, MinFix=
ed, MaxFixed, PosDecode, EntireRange,
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000=
0000000000000, // Granularity
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000=
0000010000000, // Range Minimum
> >=20
> >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000=
000001000FFFF, // Range Maximum
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000=
000E000000000, // Translation Offset
> >=20
> > See above, I will get the APM specifications to countercheck.
>=20
> The spec won't help other than to verify that the PCIe bridge support=
s
> a 32-bit IO address space. The firmware sets the PCI bus base @
> 0x10000000 with a CPU base address for that window @ 0xe010000000. Th=
e
> pci-xgene.c driver sets the PCI bus IO base address to whatever DT
> tells it too. For ACPI, we have to use whatever the firmware set it t=
o
> and described it in the ACPI table.

It makes sense, thank you for clarifying (and sorry for jumping
to conclusions, I am a bit worried about the ACPI IO space descriptors
specification and usage on arm64).

> When I looked at this a while back, neither ACPI nor PCI had anything
> which disallowed 32-bit IO space on the PCI bus. The 16-bit limit is
> an x86 limit in the instruction set.

We should ask Jiang to remove that check or to make it x86 only (does
current mainline - where the offset is added to the resource start/end =
-
work on ia64 ?)

Thanks,
Lorenzo

>=20
> >=20
> > I agree with you we have to verify if this IO space limitation is
> > real or it is just an x86ism, in which case we remove that check.
> >=20
> > Lorenzo
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000=
0000000010000, // Length
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0,, , =
TypeStatic)
> >=20
> > >=20
> > >=20
> > > > Jiang's patch:
> > > >=20
> > > > https://lkml.org/lkml/2015/12/16/249
> > > >=20
> > > > parses the IO descriptors and stores the AddressMinimum, Addres=
sMaximum
> > > > in the IO resource (with AddressTranslation as offset which mus=
t be the
> > > > *CPU* physical address mapping IO), from the log above it seems=
 to me in
> > > > AddressMinimum APM specifies the *CPU* physical address generat=
ing IO
> > > > cycles.
> > > >=20
> > > > All in all, I was right to fear this would happen, and I alread=
y
> > > > raised the point within the ACPI spec working group, ACPI IO
> > > > descriptors specification is ambiguous and we must agree on how
> > > > they have to be specified once for all.
> > > >=20
> > > > Lorenzo
> > >=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
