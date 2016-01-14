From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 11:38:44 -0500
Message-ID: <1452789524.28109.24.camel@redhat.com>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <1452785393.28109.16.camel@redhat.com> <5697C0EB.4020404@codeaurora.org>
	 <20160114161238.GA20706@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42105 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbcANQir (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 11:38:47 -0500
In-Reply-To: <20160114161238.GA20706@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On Thu, 2016-01-14 at 16:12 +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 14, 2016 at 10:38:19AM -0500, Sinan Kaya wrote:
> > On 1/14/2016 10:29 AM, Mark Salter wrote:
> > On Wed, 2016-01-13 at 14:20 +0100, Tomasz Nowicki wrote:
> > > IO resources on Mustang get disabled unless I do:
> > >=20
> > > @@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct
> > > resource *res, u64 len, if (!acpi_dev_resource_len_valid(res->sta=
rt,
> > > res->end, len, true)) res->flags |=3D IORESOURCE_DISABLED |
> > > IORESOURCE_UNSET;
> > >=20
> > > +#if 0 if (res->end >=3D 0x10003) res->flags |=3D IORESOURCE_DISA=
BLED |
> > > IORESOURCE_UNSET; - +#endif
> > >=20
> > > res->end is way beyond 0x10003 on Mustang:
> > >=20
> > > pci_bus 0000:00: root bus resource [io=C2=A0=C2=A00x0000-0xffff w=
indow] (bus
> > > address [0x10000000-0x1000ffff])
> > >=20
> > >=20
> >=20
> > Join the club. I complained about this and I got the message that w=
e
> > just do what Intel does.=C2=A0=C2=A0See Arnd Bergmann's reply.
> >=20
> > [PATCH V2 00/23] MMCONFIG refactoring and support for ARM64 PCI
> > hostbridge init based on ACPI
> >=20
> > 1/12/2016 9:30 AM
> >=20
> > It is an artificial limit coming from the x86 world introduced into
> > common code.
>=20
> Guys, I think you are mixing things up here, we discussed this to
> death, read the archives please.
>=20
> The ACPI IO descriptors AddressMinimum/AddressMaximum describe
> the IO space PCI bus addresses. The AddressTranslation field
> provides the PCI IO space -> CPU physical address translation, or
> put it differently, the secondary to primary bus translation in
> ACPI jargon, that's how ACPI tables must be written for IO space,
> at least that's what IA64 does (and on ia64 IO space is memory
> mapped, as on arm64).
>=20
> I bet APM IO descriptors specify the *CPU* physical address in
> the AddressMinimum field, and that's where the problem lies.
>=20

You would lose that bet. AddressMinimum/Maximum describe the
PCI bus addresses.

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QWordIO (Resour=
ceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000000000000, // =
Granularity
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000010000000, // =
Range Minimum
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x000000001000FFFF, // =
Range Maximum
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x000000E000000000, // =
Translation Offset
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0000000000010000, // =
Length
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0,, , TypeStatic)


> Jiang's patch:
>=20
> https://lkml.org/lkml/2015/12/16/249
>=20
> parses the IO descriptors and stores the AddressMinimum, AddressMaxim=
um
> in the IO resource (with AddressTranslation as offset which must be t=
he
> *CPU* physical address mapping IO), from the log above it seems to me=
 in
> AddressMinimum APM specifies the *CPU* physical address generating IO
> cycles.
>=20
> All in all, I was right to fear this would happen, and I already
> raised the point within the ACPI spec working group, ACPI IO
> descriptors specification is ambiguous and we must agree on how
> they have to be specified once for all.
>=20
> Lorenzo

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
