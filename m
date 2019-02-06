From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCHv5 09/10] acpi/hmat: Register memory side cache
 attributes
Date: Wed, 6 Feb 2019 12:17:06 +0000
Message-ID: <20190206121706.00005246@huawei.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
        <20190124230724.10022-10-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124230724.10022-10-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 24 Jan 2019 16:07:23 -0700
Keith Busch <keith.busch@intel.com> wrote:

> Register memory side cache attributes with the memory's node if HMAT
> provides the side cache iniformation table.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
Trivial suggestion inline.
> ---
>  drivers/acpi/hmat/hmat.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 917e6122b3f0..11f65b38e9f9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -245,6 +245,7 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  				   const unsigned long end)
>  {
>  	struct acpi_hmat_cache *cache = (void *)header;
> +	struct node_cache_attrs cache_attrs;
>  	u32 attrs;
>  
>  	if (cache->header.length < sizeof(*cache)) {
> @@ -258,6 +259,37 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  		cache->memory_PD, cache->cache_size, attrs,
>  		cache->number_of_SMBIOShandles);
>  
> +	cache_attrs.size = cache->cache_size;
> +	cache_attrs.level = (attrs & ACPI_HMAT_CACHE_LEVEL) >> 4;
> +	cache_attrs.line_size = (attrs & ACPI_HMAT_CACHE_LINE_SIZE) >> 16;
> +
> +	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {

FIELD_GET might be nice for these to avoid having the shifts and the mask.

> +	case ACPI_HMAT_CA_DIRECT_MAPPED:
> +		cache_attrs.associativity = NODE_CACHE_DIRECT_MAP;
> +		break;
> +	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
> +		cache_attrs.associativity = NODE_CACHE_INDEXED;
> +		break;
> +	case ACPI_HMAT_CA_NONE:
> +	default:
> +		cache_attrs.associativity = NODE_CACHE_OTHER;
> +		break;
> +	}
> +
> +	switch ((attrs & ACPI_HMAT_WRITE_POLICY) >> 12) {
> +	case ACPI_HMAT_CP_WB:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_BACK;
> +		break;
> +	case ACPI_HMAT_CP_WT:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_THROUGH;
> +		break;
> +	case ACPI_HMAT_CP_NONE:
> +	default:
> +		cache_attrs.write_policy = NODE_CACHE_WRITE_OTHER;
> +		break;
> +	}
> +
> +	node_add_cache(pxm_to_node(cache->memory_PD), &cache_attrs);
>  	return 0;
>  }
>  
