From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: Re: [PATCH] Teach OSL to handle multiple interrupts [1/2]
Date: Tue, 16 Nov 2004 03:22:18 +0000
Message-ID: <20041116032218.GF1108@parcelfarce.linux.theplanet.co.uk>
References: <3ACA40606221794F80A5670F0AF15F84041AC065@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC065@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Fu, Michael" <michael.fu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 13, 2004 at 01:28:54AM +0800, Yu, Luming wrote:
> My comments:

These all seem to relate to the gpe-block device patch, right?  You see no
problems with the OSL patch you actually quote, correct?

> 1. In acpi_gpe_block_add, 
> 
> +	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +			acpi_gpe_block_crs_add, &block);
> +	if (block.register_count == 0)
> +		return 0;
> 
> 1.1  Shouldn't it return AE_ERROR.

I don't think it really matters.  The driver will attach to these devices,
but that doesn't do any harm.

> 1.2  You assume there always have IRQ resource for the gpe blocks.

No, I assume there are io or memory resources for these gpe blocks.  If
there aren't, it's pretty useless!

> 2. In acpi_gpe_block_remove,
> +	acpi_walk_resources(device->handle, METHOD_NAME__CRS,
> +			acpi_gpe_block_crs_remove, &fadt);
> +	if (fadt)
> +		return AE_OK;
> 
> 2.1 fadt seems always to be 0, So why you need it?

fadt is only set to 0 when _CRS resources exist.  ie for GPE blocks that
aren't described in the FADT.  We shouldn't unregister GPE blocks that're
described in the FADT because we didn't register them in the first place.

> 2.2 How to free IRQ resource? You just free them at acpi_os_terminate.

Huh?  acpi_remove_gpe_block() releases the IRQ resource.  I have actually
loaded and unloaded this driver ;-)

> 3. In acpi_gpe_block_crs_addr
> +	data->address.register_bit_width = ACPI_GPE_REGISTER_WIDTH;
> +	data->address.register_bit_offset = ACPI_GPE_REGISTER_WIDTH;
> +	data->address.address = addr->min_address_range;
> +	data->register_count = size / 2;
> 
> 3.1 you should specify address.address_space_id

I do that right above the section you quoted.

> 3.2  address.reserved must be 0. (You allocate it at stack)

Doesn't really matter.  It isn't used.  But I'll fix that.

> 3.3 Why you think register_bit_offset is ACPI_GPE_REGISTER_WIDTH.

Why do you think it isn't?  BTW, the current ACPICA ignores what values
get passed in for register_bit_width and register_bit_offset and hardcodes
ACPI_GPE_REGISTER_WIDTH instead.

> 3.3 Why you think register_count should be size/2 ? 

Because there's an enable and status byte for each event.  I basically
got the idea from:
                register_count0 = (u16) (acpi_gbl_FADT->gpe0_blk_len / 2);


BTW, I think your comments basically show why the callback interface
that ACPICA is based on sucks.  It forces too much information to be 
remembered between two different functions.  Much better to do it all
in one function.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
