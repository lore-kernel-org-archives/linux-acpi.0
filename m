From: joeyli <jlee-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH] libnvdimm, nd_blk: mask off reserved status bits
Date: Mon, 1 Aug 2016 14:00:49 +0800
Message-ID: <20160801060049.GI9236@linux-rxt1.site>
References: <20160729205912.20436-1-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160729205912.20436-1-ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Ross,

On Fri, Jul 29, 2016 at 02:59:12PM -0600, Ross Zwisler wrote:
> The "NVDIMM Block Window Driver Writer's Guide":
> 
> http://pmem.io/documents/
> http://pmem.io/documents/NVDIMM_DriverWritersGuide-July-2016.pdf
> 
> defines the layout of the block window status register.  For the July 2016
> version of the spec linked to above, this happens in Figure 4 on page 26.
> 
> The only bits defined in this spec are bits 31, 5, 4, 2, 1 and 0.  The rest
> of the bits in the status register are reserved, and there is a warning
> following the diagram that says:
> 
>   Note: The driver cannot assume the value of the RESERVED bits in the
>   status register are zero. These reserved bits need to be masked off, and
>   the driver must avoid checking the state of those bits.
> 
> This change ensures that for hardware implementations that set these
> reserved bits in the status register, the driver won't incorrectly fail the
> block I/Os.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/acpi/nfit.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 1f0e060..375c10f 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c

The drivers/acpi/nfit.c is moved to drivers/acpi/nfit/core.c

> @@ -1396,11 +1396,12 @@ static u32 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
>  {
>  	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
>  	u64 offset = nfit_blk->stat_offset + mmio->size * bw;
> +	const u32 STATUS_MASK = 0x80000037;
>  
>  	if (mmio->num_lines)
>  		offset = to_interleave_offset(offset, mmio);
>  
> -	return readl(mmio->addr.base + offset);
> +	return readl(mmio->addr.base + offset) & STATUS_MASK;
>  }
>  
>  static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
> -- 
> 2.9.0

Other parts are good to me.

Reviewed-by: Lee, Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>

Regards
Joey Lee
