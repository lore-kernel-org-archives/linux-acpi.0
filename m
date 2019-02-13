From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 1/3] ACPI: Support Generic Initator only domains
Date: Wed, 13 Feb 2019 10:16:40 +0000
Message-ID: <20190213101640.00006a51@huawei.com>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
        <20190212164926.202-2-Jonathan.Cameron@huawei.com>
        <20190212214736.GG6176@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212214736.GG6176@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E9r=F4me?= Glisse <jglisse@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Tue, 12 Feb 2019 14:47:36 -0700
Keith Busch <keith.busch@intel.com> wrote:

> On Tue, Feb 12, 2019 at 04:49:24PM +0000, Jonathan Cameron wrote:
> > +	case ACPI_SRAT_TYPE_GENERIC_INITIATOR_AFFINITY:
> > +	{
> > +		struct acpi_srat_gi_affinity *p =
> > +			(struct acpi_srat_gi_affinity *)header;
> > +		char name[9] = {};
> > +
> > +		if (p->flags & ACPI_SRAT_GI_PCI_HANDLE) {
> > +			/*
> > +			 * For pci devices this may be the only place they
> > +			 * are assigned a proximity domain
> > +			 */
> > +			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> > +				p->pci_handle.segment,
> > +				p->pci_handle.bdf,
> > +				p->proximity_domain,
> > +				(p->flags & ACPI_SRAT_GI_ENABLED) ?
> > +				"enabled" : "disabled");  
> 
> <snip>
> 
> > +#define ACPI_SRAT_GI_ENABLED     (1)		/* 00: Use affinity structure */
> > +#define ACPI_SRAT_GI_ACPI_HANDLE (0)		/* 01: */
> > +#define ACPI_SRAT_GI_PCI_HANDLE  (1 << 1)	/* 01: */  
> 
> It looks like you're reading reserved bits. My copy of the 6.3 spec says
> PCI Handle is 1, and is set in Device Handle Type field, not in the Flags.
Good spot.

Sorry, wrote this long before spec publish and some details got tidied up.
I fixed iasl end but forgot to actually update the reading of it. Oops!
As you can probably guess that my test was using an ACPI handle so didn't
hit this at all.  I'll shove a PCIe card in the machine to check those
as well.

Will fix up for v2!

Thanks,

Jonathan
> 
> > +/* 5 : Generic Initiator Affinity (ACPI 6.3) */
> > +
> > +struct acpi_srat_gi_affinity {
> > +	struct acpi_subtable_header header;
> > +	u8 reserved;
> > +	u8 device_handl_type;
> > +	u32 proximity_domain;
> > +	union {
> > +		struct acpi_srat_gi_acpi_handle acpi_handle;
> > +		struct acpi_srat_gi_pci_handle pci_handle;
> > +	};
> > +	u32 flags;
> > +	u32 reserved2;
> > +};  
