From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv5 03/10] acpi/hmat: Parse and report heterogeneous memory
Date: Wed, 6 Feb 2019 09:06:14 -0700
Message-ID: <20190206160613.GG28064@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-4-keith.busch@intel.com>
 <20190206122814.00000127@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190206122814.00000127@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 06, 2019 at 12:28:14PM +0000, Jonathan Cameron wrote:
> On Thu, 24 Jan 2019 16:07:17 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> 
> > +	pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> > +		hmat_loc->flags, hmat_data_type(type), ipds, tpds,
> > +		hmat_loc->entry_base_unit);
> > +
> > +	inits = (u32 *)(hmat_loc + 1);
> > +	targs = &inits[ipds];
>
> This line is a bit of an oddity as it's indexing off the end of the data.
> 	targs = inits + ipds;
> would be nicer to my mind as doesn't even hint that we are in inits still.
> 
> 
> > +	entries = (u16 *)(&targs[tpds]);

Sure, I can change these to addition rather than indexing. I have no
preference either way.

> As above I'd prefer we did the pointer arithmetic explicitly rather
> than used an index off the end of the array.
> 
> > +	for (init = 0; init < ipds; init++) {
> > +		for (targ = 0; targ < tpds; targ++) {
> > +			value = entries[init * tpds + targ];
> > +			value = (value * hmat_loc->entry_base_unit) / 10;
> > +			pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> > +				inits[init], targs[targ], value,
> > +				hmat_data_type_suffix(type));
> 
> Worth checking at this early stage that the domains exist in SRAT?
> + screaming if they don't.

Sure, I think it should be sufficient to check pxm_to_node() for a valid
value to validate the table is okay..

> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> > +				   const unsigned long end)
> > +{
> > +	struct acpi_hmat_cache *cache = (void *)header;
> > +	u32 attrs;
> > +
> > +	if (cache->header.length < sizeof(*cache)) {
> > +		pr_debug("HMAT: Unexpected cache header length: %d\n",
> > +			 cache->header.length);
> > +		return -EINVAL;
> > +	}
> > +
> > +	attrs = cache->cache_attributes;
> > +	pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> > +		cache->memory_PD, cache->cache_size, attrs,
> > +		cache->number_of_SMBIOShandles);
> 
> Can we sanity check those smbios handles actually match anything?

Will do.
 
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> > +					   const unsigned long end)
> > +{
> > +	struct acpi_hmat_address_range *spa = (void *)header;
> > +
> > +	if (spa->header.length != sizeof(*spa)) {
> > +		pr_debug("HMAT: Unexpected address range header length: %d\n",
> > +			 spa->header.length);
> 
> My gut feeling is that it's much more useful to make this always print rather
> than debug.  Same with other error paths above.  Given the number of times
> broken ACPI tables show up, it's nice to complain really loudly!
> 
> Perhaps others prefer to not do so though so I'll defer to subsystem norms.

Yeah, I demoted these to debug based on earlier feedback. We should
still be operational even with broken HMAT, so I don't want to create
unnecessary panic if its broken, but I agree something should be
immediately noticable if the firmware tables are incorrect. Maybe like
what bad_srat() provides.
