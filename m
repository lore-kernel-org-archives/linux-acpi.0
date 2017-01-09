From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] ACPI/IORT: Fix iort_node_get_id() mapping entries
 indexing
Date: Mon, 9 Jan 2017 16:01:09 +0800
Message-ID: <ca7a81e0-e1ba-9205-d443-534b9520bac2@linaro.org>
References: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35465 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751521AbdAIIBS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 03:01:18 -0500
Received: by mail-pg0-f48.google.com with SMTP id 194so12100634pgd.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2017 00:01:18 -0800 (PST)
In-Reply-To: <20170105182921.8167-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>, Nate Watterson <nwatters@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 2017/1/6 2:29, Lorenzo Pieralisi wrote:
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

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
