From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI add interface to acpi_pci
Date: Fri, 6 Nov 2015 18:55:10 +0000
Message-ID: <20151106185510.GA10672@red-moon>
References: <563CE870.3040901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43445 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbKFSyW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Nov 2015 13:54:22 -0500
Content-Disposition: inline
In-Reply-To: <563CE870.3040901@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: jiang.liu@linux.intel.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>

Hi Jeremy,

On Fri, Nov 06, 2015 at 11:50:40AM -0600, Jeremy Linton wrote:
> Hello,
>=20
> I just took a quick look at the discussion about the DwordIO ACPI
> translation, and I have a couple comments (I don't have the whole
> thread available for some reason..).
>=20
> First, the "secondary bus" referenced in the ACPI specification is
> the processor side, rather than the PCI device side. So the
> minimum/max base address are the MMIO mapped addresses. To get the
> actual IO address the translation must be subtracted. This means
> AFAIK that the qemu table is wrong in two ways for ARM64.

As I said, this is certainly confusing. AFAICT, I read "secondary bus"
as secondary bus side of the PCI bridge, I agree there is a mismatch
in the ACPI specs between the WordIo specification and the actual
Resource descriptors, reading page 366, for an IO resource descriptor,
_TTP:

Bit [4] I/O to Memory Translation, _TTP
1 TypeTranslation: This resource, which is I/O on the secondary
		   side of the bridge, is memory on the primary side
		   of the bridge.
0 TypeStatic: This resource, which is I/O on the secondary side of the
	      bridge, is also I/O on the primary side of the bridge.

Then (19.6.33):

"TranslationType is an optional argument that specifies whether the
resource type on the secondary side of the bus is different (TypeTransl=
ation)
from that on the primary side of the bus or the same
(TypeStatic). If TypeTranslation is specified, then the secondary side
of the bus is Memory. If TypeStatic is specified, then the secondary si=
de
of the bus is I/O. If nothing is specified, then TypeStatic is assumed.
The 1-bit field DescriptorName._TTP is automatically created to refer t=
o
this portion of the resource descriptor, where =E2=80=981=E2=80=99 is T=
ypeTranslation and =E2=80=980=E2=80=99
is TypeStatic. See _TTP (page 365) for more information."

That reads the other way around :), which one is correct ?

> So that said, I will reference the juno DwordIo resource which I
> recently added to the EDK.
>=20
> DWordIo ( // IO window
> 	ResourceProducer,
> 	MinFixed,
> 	MaxFixed,
> 	PosDecode,
> 	EntireRange,
> 	0x00000000, 	// Granularity
> 	0x5f800000, 	// Min Base Address
> 	0x5fffffff,	// Max Base Address
> 	0x5f800000, 	// Translate
> 	0x00800000  	// Length
> )
>=20
> Which after reading the specification, I realized should be setting
> the translation type to TypeTranslation. But that really doesn't
> matter for ARM64 because ARM64 doesn't have a processor accessible
> IO address range. AKA the TranslationType controls whether the
> processor is doing an IN/OUT/etc to access the range or actual MMIO
> read/writes. Since on ARM64 the only choice is MMIO, this field
> should be ignored, the only behavior difference should possibly be a
> warning if someone leaves it set to static.
>=20
> Put another way, the setting of the TranslationType doesn't change
> the way the "translation" is computed, only how its accessed. AKA it
> doesn't affect the math..

It seems to me that is down to interpretation, and that's not good at
all.

We need to raise the point within the ASWG and get this clarified.

Thanks,
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
