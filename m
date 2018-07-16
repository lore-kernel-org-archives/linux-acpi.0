From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Support address size limit for root complexes
Date: Mon, 16 Jul 2018 16:10:51 +0100
Message-ID: <20180716151051.GB19945@red-moon>
References: <b52cdefb7a3f631340b98dcd38a274ae277bd561.1531239023.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b52cdefb7a3f631340b98dcd38a274ae277bd561.1531239023.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 10, 2018 at 05:13:45PM +0100, Robin Murphy wrote:
> IORT revision D allows PCI root complex nodes to specify a memory
> address size limit equivalently to named components, to help describe
> straightforward integrations which don't really warrant a full-blown
> _DMA method. Now that our headers are up-to-date, plumb it in.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/iort.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7a3a541046ed..4a66896e2aa3 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -947,6 +947,24 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
>  	return 0;
>  }
>  
> +static int rc_dma_get_range(struct device *dev, u64 *size)
> +{
> +	struct acpi_iort_node *node;
> +	struct acpi_iort_root_complex *rc;
> +
> +	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
> +			      iort_match_node_callback, dev);
> +	if (!node || node->revision < 1)
> +		return -ENODEV;
> +
> +	rc = (struct acpi_iort_root_complex *)node->node_data;
> +
> +	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> +			1ULL<<rc->memory_address_limit;
> +
> +	return 0;
> +}
> +
>  /**
>   * iort_dma_setup() - Set-up device DMA parameters.
>   *
> @@ -975,10 +993,13 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  
>  	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
>  
> -	if (dev_is_pci(dev))
> +	if (dev_is_pci(dev)) {
>  		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -	else
> +		if (ret == -ENODEV)
> +			ret = rc_dma_get_range(dev, &size);

Thank you for putting together the patch.

The question is whether it is OK to ignore the IORT address limits
when _DMA is actually specified. It is a sort of grey area that
has to be clarified, maybe we can add a check to detect a size
mismatch, I do not know if something should be added at IORT spec
level to clarify its relation to the _DMA object, if present.

Thanks,
Lorenzo

> +	} else {
>  		ret = nc_dma_get_range(dev, &size);
> +	}
>  
>  	if (!ret) {
>  		msb = fls64(dmaaddr + size - 1);
> -- 
> 2.17.1.dirty
> 
