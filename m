From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Tue, 10 Jan 2017 10:53:19 -0500
Message-ID: <99a9af52-6b9b-7633-6bff-a40039d55cc4@codeaurora.org>
References: <20170110120020.17867-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdAJPxV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2017 10:53:21 -0500
In-Reply-To: <20170110120020.17867-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 1/10/2017 7:00 AM, Lorenzo Pieralisi wrote:
> Commit 618f535a6062 ("ACPI/IORT: Add single mapping function")
> introduced a function (iort_node_get_id()) to retrieve ids for IORT
> named components.
> 
> The iort_node_get_id() takes an index as input to refer to a specific
> mapping entry in the named component IORT node mapping array.
> 
> For a mapping entry at a given index, iort_node_get_id() should return
> the id value (through the id_out function parameter) and the IORT node
> output_reference (through function return value) the given mapping entry
> refers to.
> 
> Technically output_reference values may differ for different map
> entries, (see diagram below - mapped id values may refer to different eg
> IORT SMMU nodes; the kernel may not be able to handle different
> output_reference values for a given named component but the IORT kernel
> layer should still report the IORT mappings as reported by firmware) but
> current code in iort_node_get_id() fails to use the index function
> parameter to return the correct output_reference value (ie it always
> returns the output_reference value of the first entry in the mapping
> array whilst using the index correctly to retrieve the id value from the
> respective entry).
> 
> 	|----------------------|
> 	|     named component  |
> 	|----------------------|
> 	|      map entry[0]    |
> 	|----------------------|
> 	|       id value       |
> 	| output_reference----------------> eg SMMU 1
> 	|----------------------|
> 	|      map entry[1]    |
> 	|----------------------|
> 	|       id value       |
> 	| output_reference----------------> eg SMMU 2
> 	|----------------------|
> 		    .
> 		    .
> 		    .
> 	|----------------------|
> 	|      map entry[N]    |
> 	|----------------------|
> 	|       id value       |
> 	| output_reference----------------> eg SMMU 1
> 	|----------------------|
> 
> Consequently the iort_node_get_id() function always returns the IORT
> node pointed at by the output_reference value of the first named
> component mapping array entry, irrespective of the index parameter,
> which is a bug.
> 
> Update the map array entry pointer computation in iort_node_get_id() to
> take into account the index value, fixing the issue.
> 
> Fixes: 618f535a6062 ("ACPI/IORT: Add single mapping function")
> Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: Nate Watterson <nwatters@codeaurora.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
> v1 -> v2:
> 	- Updated/improved commit log
> 	- Added review tags
> 
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
>  			return parent;
>  		}
>  	}
> 

Tested on Qualcomm QDF2400 server with Hanjun's first 11 patches + my patch 
for (NC->SMMU->ITS) using HIDMA DMA Engine driver and MSI interrupts. 

No impacts to the existing functionality. Note that I do not have a topology
as described in this commit. I'm just stating that my existing functionality
is not impacted by this change.

Tested-by: Sinan Kaya <okaya@codeaurora.org>


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
