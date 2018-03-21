From: "Jiang, Dave" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] libnvdimm, nfit: fix persistence domain reporting
Date: Wed, 21 Mar 2018 22:50:33 +0000
Message-ID: <112A412BB11A1242B37129D931BCE5348309A035@fmsmsx117.amr.corp.intel.com>
References: <152167195887.4609.5407001869524973776.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152167195887.4609.5407001869524973776.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Williams, Dan J" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Williams, Dan J
> Sent: Wednesday, March 21, 2018 3:39 PM
> To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
> Cc: Jiang, Dave <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>; Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>; linux-
> acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [PATCH] libnvdimm, nfit: fix persistence domain reporting
> 
> The persistence domain is a point in the platform where once writes
> reach that destination the platform claims it will make them persistent
> relative to power loss. In the ACPI NFIT this is currently communicated
> as 2 bits in the "NFIT - Platform Capabilities Structure". The bits
> comprise a hierarchy, i.e. bit0 "CPU Cache Flush to NVDIMM Durability on
> Power Loss Capable" implies bit1 "Memory Controller Flush to NVDIMM
> Durability on Power Loss Capable".
> 
> Commit 96c3a239054a "libnvdimm: expose platform persistence attr..."
> shows the persistence domain as flags, but it's really an enumerated
> hierarchy.
> 
> Fix this newly introduced user ABI to show the closest available
> persistence domain before userspace develops dependencies on seeing, or
> needing to develop code to tolerate, the raw NFIT flags communicated
> through the libnvdimm-generic region attribute.
> 
> Fixes: 96c3a239054a ("libnvdimm: expose platform persistence attr...")
> Cc: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
> Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


Thanks for the fix!

Reviewed-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/acpi/nfit/core.c     |   10 +++++++---
>  drivers/nvdimm/region_devs.c |   10 ++++++----
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index bbe48ad20886..eb09ef55c38a 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2675,10 +2675,14 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>  	else
>  		ndr_desc->numa_node = NUMA_NO_NODE;
> 
> -	if(acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_CACHE_FLUSH)
> +	/*
> +	 * Persistence domain bits are hierarchical, if
> +	 * ACPI_NFIT_CAPABILITY_CACHE_FLUSH is set then
> +	 * ACPI_NFIT_CAPABILITY_MEM_FLUSH is implied.
> +	 */
> +	if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_CACHE_FLUSH)
>  		set_bit(ND_REGION_PERSIST_CACHE, &ndr_desc->flags);
> -
> -	if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_MEM_FLUSH)
> +	else if (acpi_desc->platform_cap & ACPI_NFIT_CAPABILITY_MEM_FLUSH)
>  		set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc->flags);
> 
>  	list_for_each_entry(nfit_memdev, &acpi_desc->memdevs, list) {
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index a8e9d428c0a5..1593e1806b16 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -532,11 +532,13 @@ static ssize_t persistence_domain_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
>  	struct nd_region *nd_region = to_nd_region(dev);
> -	unsigned long flags = nd_region->flags;
> 
> -	return sprintf(buf, "%s%s\n",
> -			flags & BIT(ND_REGION_PERSIST_CACHE) ? "cpu_cache " : "",
> -			flags & BIT(ND_REGION_PERSIST_MEMCTRL) ? "memory_controller " : "");
> +	if (test_bit(ND_REGION_PERSIST_CACHE, &nd_region->flags))
> +		return sprintf(buf, "cpu_cache\n");
> +	else if (test_bit(ND_REGION_PERSIST_MEMCTRL, &nd_region->flags))
> +		return sprintf(buf, "memory_controller\n");
> +	else
> +		return sprintf(buf, "\n");
>  }
>  static DEVICE_ATTR_RO(persistence_domain);
> 
