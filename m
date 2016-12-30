From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 10/14] ACPI: ARM64: IORT: rework iort_node_get_id() for
 NC->SMMU->ITS case
Date: Fri, 30 Dec 2016 16:58:28 +0800
Message-ID: <586621B4.9050704@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-11-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:31604 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbcL3I7x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 03:59:53 -0500
In-Reply-To: <1482384922-21507-11-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> iort_node_get_id() for now only support NC(named componant)->SMMU
> or NC->ITS cases, we also have other device topology such NC->
> SMMU->ITS, so rework iort_node_get_id() for those cases.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>   drivers/acpi/arm64/iort.c | 59 ++++++++++++++++++++++++++---------------------
>   1 file changed, 33 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 6b72fcb..9b3f268 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -292,22 +292,28 @@ static acpi_status iort_match_node_callback(struct acpi_iort_node *node,
>   	return status;
>   }
>   
> -static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> -		       u32 *rid_out)
> +static int iort_id_single_map(struct acpi_iort_id_mapping *map, u8 type,
> +			      u32 *rid_out)
>   {
>   	/* Single mapping does not care for input id */
>   	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>   		if (type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>   		    type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			*rid_out = map->output_base;
> +			if (rid_out)
> +				*rid_out = map->output_base;
>   			return 0;
>   		}
>   
>   		pr_warn(FW_BUG "[map %p] SINGLE MAPPING flag not allowed for node type %d, skipping ID map\n",
>   			map, type);
> -		return -ENXIO;
>   	}
>   
> +	return -ENXIO;
> +}
> +
> +static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> +		       u32 *rid_out)
> +{
>   	if (rid_in < map->input_base ||
>   	    (rid_in >= map->input_base + map->id_count))
>   		return -ENXIO;
> @@ -324,33 +330,34 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>   	struct acpi_iort_node *parent;
>   	struct acpi_iort_id_mapping *map;
>   
> -	if (!node->mapping_offset || !node->mapping_count ||
> -				     index >= node->mapping_count)
> -		return NULL;
> -
> -	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> -			   node->mapping_offset);
> +	while (node) {
> +		if (!node->mapping_offset || !node->mapping_count ||
> +					     index >= node->mapping_count)
> +			return NULL;
>   
> -	/* Firmware bug! */
> -	if (!map->output_reference) {
> -		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> -		       node, node->type);
> -		return NULL;
> -	}
> +		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> +				   node->mapping_offset);
>   
> -	parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> -			       map->output_reference);
> +		/* Firmware bug! */
> +		if (!map->output_reference) {
> +			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> +			       node, node->type);
> +			return NULL;
> +		}
>   
> -	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
> -		return NULL;
> +		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
> +				      map->output_reference);
>   
> -	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> -		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
> -		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			if (id_out)
> -				*id_out = map[index].output_base;
> -			return parent;
> +		/* go upstream to find its parent */
> +		if (!(IORT_TYPE_MASK(parent->type) & type_mask)) {
> +			node = parent;
> +			continue;
>   		}
> +
> +		if (iort_id_single_map(&map[index], node->type, id_out))
> +			break;
> +
> +		return parent;
>   	}
>   
>   	return NULL;
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

