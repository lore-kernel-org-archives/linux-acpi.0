From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCHv5 03/10] acpi/hmat: Parse and report heterogeneous
 memory
Date: Wed, 6 Feb 2019 16:39:29 +0000
Message-ID: <20190206163929.0000394a@huawei.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-4-keith.busch@intel.com>
        <20190206122814.00000127@huawei.com>
        <20190206160613.GG28064@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206160613.GG28064@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org


...

> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> > > +					   const unsigned long end)
> > > +{
> > > +	struct acpi_hmat_address_range *spa = (void *)header;
> > > +
> > > +	if (spa->header.length != sizeof(*spa)) {
> > > +		pr_debug("HMAT: Unexpected address range header length: %d\n",
> > > +			 spa->header.length);  
> > 
> > My gut feeling is that it's much more useful to make this always print rather
> > than debug.  Same with other error paths above.  Given the number of times
> > broken ACPI tables show up, it's nice to complain really loudly!
> > 
> > Perhaps others prefer to not do so though so I'll defer to subsystem norms.  
> 
> Yeah, I demoted these to debug based on earlier feedback. We should
> still be operational even with broken HMAT, so I don't want to create
> unnecessary panic if its broken, but I agree something should be
> immediately noticable if the firmware tables are incorrect. Maybe like
> what bad_srat() provides.

Agreed. Something general like that would be great. Let's people know they
should turn debug on.

Thanks,

Jonathan
