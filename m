From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI/IORT: Handle PCI aliases properly
Date: Wed, 2 Aug 2017 11:00:31 +0100
Message-ID: <20170802100031.GA3521@red-moon>
References: <20170531175230.16529-4-robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbdHBJ6i (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Aug 2017 05:58:38 -0400
Content-Disposition: inline
In-Reply-To: <20170531175230.16529-4-robin.murphy@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

[+Shameer, for his information]

Hi Robin,

On Wed, May 31, 2017 at 06:52:30PM +0100, Robin Murphy wrote:
> When a PCI device has DMA quirks, we need to ensure that an upstream
> IOMMU knows about all possible aliases, since the presence of a DMA
> quirk does not preclude the device still also emitting transactions
> (e.g. MSIs) on its 'real' RID. Similarly, the rules for bridge aliasing
> are relatively complex, and some bridges may only take ownership of
> transactions under particular transient circumstances, leading again to
> multiple RIDs potentially being seen at the IOMMU for the given device.
> 
> Take all this into account in the IORT code by mapping every RID
> produced by the alias walk, not just whichever one comes out last. Since
> adding any more internal PTR_ERR() juggling would have confused me no
> end, a bit of refactoring happens in the process - we know where to find
> the ops if everything succeeded, so we're free to just pass regular error
> codes around up until then.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This applies on top of the fixes currently queued in the IOMMU tree:
> "ACPI/IORT: Move the check to get iommu_ops from translated fwspec"
> "ACPI/IORT: Ignore all errors except EPROBE_DEFER"
> 
>  drivers/acpi/arm64/iort.c | 113 ++++++++++++++++++++++++----------------------

I have tried to pull this patch aiming at sending it for 4.14 but I
noticed it now clashes with:

http://marc.info/?l=linux-arm-kernel&m=150158522819369&w=2

and in particular, as you stated, we have to sort out how to handle
PCI aliases and ITS node mapping to reserve regions in the patch
above.

I would like to merge this patch but to avoid trees conflicts
(arm64<->iommu) it is probably better to rebase this patch on top of
patch above (or the other way around) and send it via IOMMU with my ACK.

Question is how to handle PCI aliases in the patch above with this
fixed PCI aliases approach you are adding.

Please let me know what you think.

Thanks,
Lorenzo

>  1 file changed, 59 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 797b28dc7b34..50e2749eafdc 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -598,14 +598,6 @@ void acpi_configure_pmsi_domain(struct device *dev)
>  		dev_set_msi_domain(dev, msi_domain);
>  }
>  
> -static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> -{
> -	u32 *rid = data;
> -
> -	*rid = alias;
> -	return 0;
> -}
> -
>  static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
>  			       struct fwnode_handle *fwnode,
>  			       const struct iommu_ops *ops)
> @@ -643,8 +635,7 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
>  {
>  	int err = 0;
>  
> -	if (!IS_ERR_OR_NULL(ops) && ops->add_device && dev->bus &&
> -	    !dev->iommu_group)
> +	if (ops->add_device && dev->bus && !dev->iommu_group)
>  		err = ops->add_device(dev);
>  
>  	return err;
> @@ -658,36 +649,49 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
>  { return 0; }
>  #endif
>  
> -static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
> -					struct acpi_iort_node *node,
> -					u32 streamid)
> +static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
> +			    u32 streamid)
>  {
> -	const struct iommu_ops *ops = NULL;
> -	int ret = -ENODEV;
> +	const struct iommu_ops *ops;
>  	struct fwnode_handle *iort_fwnode;
>  
> -	if (node) {
> -		iort_fwnode = iort_get_fwnode(node);
> -		if (!iort_fwnode)
> -			return NULL;
> +	if (!node)
> +		return -ENODEV;
>  
> -		ops = iommu_ops_from_fwnode(iort_fwnode);
> -		/*
> -		 * If the ops look-up fails, this means that either
> -		 * the SMMU drivers have not been probed yet or that
> -		 * the SMMU drivers are not built in the kernel;
> -		 * Depending on whether the SMMU drivers are built-in
> -		 * in the kernel or not, defer the IOMMU configuration
> -		 * or just abort it.
> -		 */
> -		if (!ops)
> -			return iort_iommu_driver_enabled(node->type) ?
> -			       ERR_PTR(-EPROBE_DEFER) : NULL;
> +	iort_fwnode = iort_get_fwnode(node);
> +	if (!iort_fwnode)
> +		return -ENODEV;
>  
> -		ret = arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> -	}
> +	ops = iommu_ops_from_fwnode(iort_fwnode);
> +	/*
> +	 * If the ops look-up fails, this means that either
> +	 * the SMMU drivers have not been probed yet or that
> +	 * the SMMU drivers are not built in the kernel;
> +	 * Depending on whether the SMMU drivers are built-in
> +	 * in the kernel or not, defer the IOMMU configuration
> +	 * or just abort it.
> +	 */
> +	if (!ops)
> +		return iort_iommu_driver_enabled(node->type) ?
> +		       -EPROBE_DEFER : -ENODEV;
>  
> -	return ret ? NULL : ops;
> +	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
> +}
> +
> +struct iort_pci_alias_info {
> +	struct device *dev;
> +	struct acpi_iort_node *node;
> +};
> +
> +static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct iort_pci_alias_info *info = data;
> +	struct acpi_iort_node *parent;
> +	u32 streamid;
> +
> +	parent = iort_node_map_id(info->node, alias, &streamid,
> +				  IORT_IOMMU_TYPE);
> +	return iort_iommu_xlate(info->dev, parent, streamid);
>  }
>  
>  /**
> @@ -723,7 +727,7 @@ void iort_set_dma_mask(struct device *dev)
>  const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  {
>  	struct acpi_iort_node *node, *parent;
> -	const struct iommu_ops *ops = NULL;
> +	const struct iommu_ops *ops;
>  	u32 streamid = 0;
>  	int err;
>  
> @@ -737,21 +741,18 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  
>  	if (dev_is_pci(dev)) {
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
> -		u32 rid;
> -
> -		pci_for_each_dma_alias(to_pci_dev(dev), __get_pci_rid,
> -				       &rid);
> +		struct iort_pci_alias_info info = { .dev = dev };
>  
>  		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
>  				      iort_match_node_callback, &bus->dev);
>  		if (!node)
>  			return NULL;
>  
> -		parent = iort_node_map_id(node, rid, &streamid,
> -					  IORT_IOMMU_TYPE);
> -
> -		ops = iort_iommu_xlate(dev, parent, streamid);
> -
> +		info.node = node;
> +		err = pci_for_each_dma_alias(to_pci_dev(dev),
> +					     iort_pci_iommu_init, &info);
> +		if (err)
> +			goto out_err;
>  	} else {
>  		int i = 0;
>  
> @@ -764,9 +765,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  						   IORT_IOMMU_TYPE, i++);
>  
>  		while (parent) {
> -			ops = iort_iommu_xlate(dev, parent, streamid);
> -			if (IS_ERR_OR_NULL(ops))
> -				return ops;
> +			err = iort_iommu_xlate(dev, parent, streamid);
> +			if (err)
> +				goto out_err;
>  
>  			parent = iort_node_map_platform_id(node, &streamid,
>  							   IORT_IOMMU_TYPE,
> @@ -774,21 +775,25 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		}
>  	}
>  
> +	ops = dev->iommu_fwspec->ops;
> +
>  	/*
>  	 * If we have reason to believe the IOMMU driver missed the initial
>  	 * add_device callback for dev, replay it to get things in order.
>  	 */
>  	err = iort_add_device_replay(ops, dev);
>  	if (err)
> -		ops = ERR_PTR(err);
> -
> -	/* Ignore all other errors apart from EPROBE_DEFER */
> -	if (IS_ERR(ops) && (PTR_ERR(ops) != -EPROBE_DEFER)) {
> -		dev_dbg(dev, "Adding to IOMMU failed: %ld\n", PTR_ERR(ops));
> -		ops = NULL;
> -	}
> +		goto out_err;
>  
>  	return ops;
> +
> +	/* Ignore all other errors apart from EPROBE_DEFER */
> +out_err:
> +	if (err == -EPROBE_DEFER)
> +		return ERR_PTR(err);
> +
> +	dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> +	return NULL;
>  }
>  
>  static void __init acpi_iort_register_irq(int hwirq, const char *name,
> -- 
> 2.12.2.dirty
> 
