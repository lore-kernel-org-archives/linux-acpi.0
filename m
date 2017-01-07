From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Sat, 7 Jan 2017 16:09:33 -0500
Message-ID: <f089f31e-cc9e-291d-091e-00a10ba78cca@codeaurora.org>
References: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbdAGVJh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Jan 2017 16:09:37 -0500
In-Reply-To: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 1/5/2017 1:29 PM, Lorenzo Pieralisi wrote:
> Commit 618f535a6062 ("ACPI/IORT: Add single mapping function")
> introduced a function (iort_node_get_id()) to retrieve ids for IORT
> named components.
> 
> iort_node_get_id() takes an index as input to refer to a specific
> mapping entry in the mapping array to retrieve the id at a specific
> index provided the index is below the total mapping count; currently the
> index is used to retrieve the mapping value from the correct entry but
> not to dereference the correct entry while retrieving the mapping
> output_reference (ie IORT parent pointer), which consequently always
> resolves to the output_reference of the first entry in the mapping
> array.
> 
> Update the map array entry pointer computation in iort_node_get_id() to
> take into account the index value, fixing the issue.
> 
> Fixes: 618f535a6062 ("ACPI/IORT: Add single mapping function")
> Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Nate Watterson <nwatters@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index e0d2e6e..ba156c5 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -333,7 +333,7 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  		return NULL;
>  
>  	map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, node,
> -			   node->mapping_offset);
> +			   node->mapping_offset + index * sizeof(*map));

What does this give us that the previous code didn't do?

You are using map as a pointer and returning the offset of the first map entry above
and then accessing the map at the indexed offset with map[index]

The new code is using map as a plain pointer, calculating the pointer location with ACPI_ADD_PTR
instead and then collecting the output parameter with map->output_base.

>  
>  	/* Firmware bug! */
>  	if (!map->output_reference) {
> @@ -348,10 +348,10 @@ struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
>  	if (!(IORT_TYPE_MASK(parent->type) & type_mask))
>  		return NULL;
>  
> -	if (map[index].flags & ACPI_IORT_ID_SINGLE_MAPPING) {
> +	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
>  		if (node->type == ACPI_IORT_NODE_NAMED_COMPONENT ||
>  		    node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> -			*id_out = map[index].output_base;
> +			*id_out = map->output_base;

You are claiming that the existing code is collecting the output parameter from the first mapping.
I don't see this happening above.

What am I missing?

>  			return parent;
>  		}
>  	}
> 

If we are just doing a housekeeping, this is fine. I couldn't see an actual bug getting fixed.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
