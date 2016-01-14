From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Date: Thu, 14 Jan 2016 17:07:23 +0000
Message-ID: <20160114170723.GB20706@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452785393.28109.16.camel@redhat.com>
 <5697C0EB.4020404@codeaurora.org>
 <20160114161238.GA20706@red-moon>
 <1452789524.28109.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452789524.28109.24.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 14, 2016 at 11:38:44AM -0500, Mark Salter wrote:

[...]

> You would lose that bet. AddressMinimum/Maximum describe the
> PCI bus addresses.

In the mainline DT (APM Mustang), the CPU physical address correspondin=
g
to IO space is 0xe010000000, PCI bus address is 0x0.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 QWordIO (ResourceProducer, MinFixed, =
MaxFixed, PosDecode, EntireRange,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000=
000000000, // Granularity
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000=
010000000, // Range Minimum


> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000=
01000FFFF, // Range Maximum
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x000000E=
000000000, // Translation Offset

See above, I will get the APM specifications to countercheck.

I agree with you we have to verify if this IO space limitation is
real or it is just an x86ism, in which case we remove that check.

Lorenzo
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x0000000=
000010000, // Length
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0,, , Type=
Static)

>=20
>=20
> > Jiang's patch:
> >=20
> > https://lkml.org/lkml/2015/12/16/249
> >=20
> > parses the IO descriptors and stores the AddressMinimum, AddressMax=
imum
> > in the IO resource (with AddressTranslation as offset which must be=
 the
> > *CPU* physical address mapping IO), from the log above it seems to =
me in
> > AddressMinimum APM specifies the *CPU* physical address generating =
IO
> > cycles.
> >=20
> > All in all, I was right to fear this would happen, and I already
> > raised the point within the ACPI spec working group, ACPI IO
> > descriptors specification is ambiguous and we must agree on how
> > they have to be specified once for all.
> >=20
> > Lorenzo
>=20
