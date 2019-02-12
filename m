From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] ACPI: Support Generic Initator only domains
Date: Tue, 12 Feb 2019 14:47:36 -0700
Message-ID: <20190212214736.GG6176@localhost.localdomain>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
 <20190212164926.202-2-Jonathan.Cameron@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212164926.202-2-Jonathan.Cameron@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, jcm@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 12, 2019 at 04:49:24PM +0000, Jonathan Cameron wrote:
> +	case ACPI_SRAT_TYPE_GENERIC_INITIATOR_AFFINITY:
> +	{
> +		struct acpi_srat_gi_affinity *p =
> +			(struct acpi_srat_gi_affinity *)header;
> +		char name[9] = {};
> +
> +		if (p->flags & ACPI_SRAT_GI_PCI_HANDLE) {
> +			/*
> +			 * For pci devices this may be the only place they
> +			 * are assigned a proximity domain
> +			 */
> +			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
> +				p->pci_handle.segment,
> +				p->pci_handle.bdf,
> +				p->proximity_domain,
> +				(p->flags & ACPI_SRAT_GI_ENABLED) ?
> +				"enabled" : "disabled");

<snip>

> +#define ACPI_SRAT_GI_ENABLED     (1)		/* 00: Use affinity structure */
> +#define ACPI_SRAT_GI_ACPI_HANDLE (0)		/* 01: */
> +#define ACPI_SRAT_GI_PCI_HANDLE  (1 << 1)	/* 01: */

It looks like you're reading reserved bits. My copy of the 6.3 spec says
PCI Handle is 1, and is set in Device Handle Type field, not in the Flags.

> +/* 5 : Generic Initiator Affinity (ACPI 6.3) */
> +
> +struct acpi_srat_gi_affinity {
> +	struct acpi_subtable_header header;
> +	u8 reserved;
> +	u8 device_handl_type;
> +	u32 proximity_domain;
> +	union {
> +		struct acpi_srat_gi_acpi_handle acpi_handle;
> +		struct acpi_srat_gi_pci_handle pci_handle;
> +	};
> +	u32 flags;
> +	u32 reserved2;
> +};
