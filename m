From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] ACPI: Return _DSD hierarchical extension (data) sub-nodes correctly
Date: Tue, 19 Sep 2017 23:06:08 +0200
Message-ID: <1758892.oZFS9QWCQq@aspire.rjw.lan>
References: <1504862681-29165-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51412 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751341AbdISVPM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Sep 2017 17:15:12 -0400
In-Reply-To: <1504862681-29165-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, andriy.shevchenko@intel.com, mika.westerberg@intel.com

On Friday, September 8, 2017 11:24:41 AM CEST Sakari Ailus wrote:
> The recently merged patch "ACPI: Prepare for constifying
> acpi_get_next_subnode() fwnode argument" was part of a patchset
> constifying the fwnode arguments across the fwnode property API. The
> purpose of the patch was to allow returning non-const fwnodes from a data
> structure the root of which is const.
> 
> Unfortunately the patch introduced the functionality, in particular when
> starting parsed from an ACPI device node, the hierarchical data extension
> nodes would not be enumerated.
> 
> Restore the old behaviour while still retaining constness properties of
> the patch.
> 
> Fixes: 01c1da289791 ("ACPI: Prepare for constifying acpi_get_next_subnode() fwnode argument")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> since v1:
> 
> - Add Mika's ack.
> 
> - Fix recetly -> recently in commit message.
> 
> - Add commit ID to Fixes: line.
> 
>  drivers/acpi/property.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a65c09c..d70dab2 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -902,11 +902,12 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  					    struct fwnode_handle *child)
>  {
>  	const struct acpi_device *adev = to_acpi_device_node(fwnode);
> -	struct acpi_device *child_adev = NULL;
>  	const struct list_head *head;
>  	struct list_head *next;
>  
>  	if (!child || is_acpi_device_node(child)) {
> +		struct acpi_device *child_adev;
> +
>  		if (adev)
>  			head = &adev->children;
>  		else
> @@ -916,8 +917,8 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  			goto nondev;
>  
>  		if (child) {
> -			child_adev = to_acpi_device_node(child);
> -			next = child_adev->node.next;
> +			adev = to_acpi_device_node(child);
> +			next = adev->node.next;
>  			if (next == head) {
>  				child = NULL;
>  				goto nondev;
> @@ -935,8 +936,8 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  		const struct acpi_data_node *data = to_acpi_data_node(fwnode);
>  		struct acpi_data_node *dn;
>  
> -		if (child_adev)
> -			head = &child_adev->data.subnodes;
> +		if (adev)
> +			head = &adev->data.subnodes;
>  		else if (data)
>  			head = &data->data.subnodes;
>  		else
> 

Applied, thanks!


