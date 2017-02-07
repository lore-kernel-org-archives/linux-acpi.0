From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v2 15/16] device property: Add fwnode_get_next_parent()
Date: Tue, 7 Feb 2017 11:57:55 -0700
Message-ID: <9a481aec-92e6-ac01-b825-167bf73dfb11@redhat.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
 <1486052546-19257-16-git-send-email-sakari.ailus@linux.intel.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34001 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754502AbdBGS56 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Feb 2017 13:57:58 -0500
Received: by mail-qt0-f178.google.com with SMTP id w20so138724900qtb.1
        for <linux-acpi@vger.kernel.org>; Tue, 07 Feb 2017 10:57:58 -0800 (PST)
In-Reply-To: <1486052546-19257-16-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org

On 02/02/2017 09:22 AM, Sakari Ailus wrote:
> In order to differentiate the functionality between dropping a reference
> to the node (or not) for the benefit of OF, introduce
> fwnode_get_next_parent().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c  | 29 +++++++++++++++++++++++++++++
>  include/linux/property.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 28125a5..8e4398f 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -868,6 +868,35 @@ int device_add_properties(struct device *dev, struct property_entry *properties)
>  EXPORT_SYMBOL_GPL(device_add_properties);
>  
>  /**
> + * fwnode_get_next_parent - Iterate to the node's parent
> + * @fwnode: Firmware whose parent is retrieved
> + *
> + * This is like fwnode_get_parent() except that it drops the refcount
> + * on the passed node, making it suitable for iterating through a
> + * node's parents.
> + *
> + * Returns a node pointer with refcount incremented, use
> + * fwnode_handle_node() on it when done.
> + */
> +struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_handle *parent = NULL;
> +
> +	if (is_of_node(fwnode)) {
> +		struct device_node *node;
> +
> +		node = of_get_next_parent(to_of_node(fwnode));
> +		if (node)
> +			parent = &node->fwnode;
> +	} else if (is_acpi_node(fwnode)) {
> +		parent = acpi_node_get_parent(fwnode);
> +	}
> +
> +	return parent;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_next_parent);

I think I agree with Rob's prior comments about making an ops struct for DT
vs ACPI.  Out of the 16 patches, 2/16, 3/16, 5/16 (multiple times), and this
patch all end up using the same construct.  Maybe it needs to be a separate
refactoring effort, but if it's happening this often just in this patch set,
it seems like it's getting time to clean things up.

> +/**
>   * fwnode_get_parent - Return parent firwmare node
>   * @fwnode: Firmware whose parent is retrieved
>   *
> diff --git a/include/linux/property.h b/include/linux/property.h
> index eb7ba73..760df98 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -73,6 +73,7 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
>  				 const char *propname, const char *string);
>  
>  struct fwnode_handle *fwnode_get_parent(struct fwnode_handle *fwnode);
> +struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
>  struct fwnode_handle *fwnode_get_next_child_node(struct fwnode_handle *fwnode,
>  						 struct fwnode_handle *child);
>  
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
