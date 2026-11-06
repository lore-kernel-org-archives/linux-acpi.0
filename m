Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987244;
	b=D3xdOTJNke+fbw5CUWCyvN7puby1pFZPBGYzHoSVMVVRXa96/ZmoJFIcvTHj2ZRyqNZr
	 Vf9vxBTUcvRPNT1Ngiv96JXwTnY5GPbffhTuQ/Fmg2DPDtVy+XLp+3lRlHDbGxZBW4BXS
	 xvYJeL6S+wgp27AwQRpcZZdogOWyiRz858SRSSLVrYSwRrB1Ucb8Lqe/VlbHqOEZeePJy
	 V5wfSWrrItp7wBifGeAPdMZPqM9k4AteXgGpjxEK/eKWMdi9LK8GDk/ELWmRANLyIw7gf
	 HGgsrnFSwu2ammaeY2XLP1yYZbe8hMmSg2XUw6WDmP9YFdatJCpr/uc+mG19mSOX8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987244;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Erym8mBAycZf4kLhSrQAcDQ8l3ywcG4qyDch6JEY96E=;
	b=3GhFHOzZ4UFT54bzwHj0O32yc3MV65ssxvyZ8aejjC8McFSFFwM3XObSN3kyz1jnRswv
	 Rz4V3LEGlbwR27tfeG7RPclwTb4uo2tFkCwhFNVddu592mWwm6dnvDuXvOUbO+F+krgvX
	 nNLxkVRliC0B8pYc2eH1+I2Q3dS3uMwi5nbooWK7bsQmYsVQih493iJ7N594hjAP5X53a
	 aX2fSmo4+lvCPWcC0aF6QS2rlF4eZWuCj6jX+l+3flmn8aY3fQwGTUkGkrtcFErJ0l1F/
	 GB+sH4ZNs0JPmGZKN4YzDLpY8jVCRBra48HUZtDBIRtBCxYcRm0Pl0QZDqNwrwNttIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=enr8Q909;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741C606A329;
	Fri,  6 Nov 2026 17:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8741C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=enr8Q909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793987243; x=1825523243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WI+CHfd4hadSzCFGcEnv6F/XDjux3RlSxL8wxZyC+Q0=;
  b=enr8Q909t3t0hpAokk+pDxneL4ExO5k1zlTcnc91Hubef8fmuEJu3pbv
   lPPpIr06MboIc5TNKnKBRt2AMJVjowcxNbmQ37n/oHM5u9cpaGGe0TXYf
   rB1VsIqYVb1Fh6sxXWxGfk5DIcywGokU7WfI7oX54gidVjBAGkCWBrC39
   4UUoRhhAaiHW0XXixHeCepXDjLavI2OTNPsBVxfZFuRbxkBGgbEuvroRp
   rYpyAi17QEvH8umuZq0tKsCELB5u1kKxX15A2cc8rPXl78Ngo9sP1RJID
   LreBTZ6SE0xvP+Wr20YgZCdYSI5HcYrFaQOaSZS80Wf5X5o3Ww5aJ9qrE
   A==;
X-CSE-ConnectionGUID: nzNIGla6SBuCnF5AysjodQ==
X-CSE-MsgGUID: 4scfk27QQh+8nceQQSNx3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2695070"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2695070"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:47:23 -0800
X-CSE-ConnectionGUID: nEsxF3xsQnSkXwzmUtNwPQ==
X-CSE-MsgGUID: U+VfDvbdSb2X0gjwi8MKmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223513"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2026 09:47:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B33B499; Fri, 06 Nov 2026 18:47:18 +0100 (CET)
Date: Fri, 6 Nov 2026 18:47:18 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Subject: Re: [PATCH] software node: only let the owner release a managed node
Message-ID: <au4Spi8lWIs4C0ca@black.igk.intel.com>
References: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-swnode-only-owner-release-v1-1-ee4c9022a629@oss.qualcomm.com>

On Mon, Nov 02, 2026 at 04:25:16PM +0100, Bartosz Golaszewski wrote:
> device_create_managed_software_node() creates a node whose lifetime is
> tied to the device it was created for. software_node_notify_remove() is
> called for every device that has the node as its fwnode (primary OR
> secondary) and, if the node is managed, unconditionally detaches it from
> that device and drops the creation reference.
> 
> This breaks when the node is shared with another device. Example: the
> i2c-designware copies the parent's fwnode to the adapter's struct device.
> When the adapter is deleted, it releases the reference that belongs to
> the owner and the latter ends up with a dangling pointer.
> 
> Record the device's "manager" and only perform the actual release when
> notify is called for that "owner" device.
> 
> Reported-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
> Closes: https://lore.kernel.org/all/20261009164241.923756-2-balasubramani.vivekanandan@intel.com/
> Fixes: 151f6ff78cdf ("software node: Provide replacement for device_add_properties()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

LGTM. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Hi!
> 
> This is my approach at addressing the bug reported by Vivekanandan
> directly in driver core. Please test it if you can.
> 
> Thanks,
> Bartosz
> ---
>  drivers/base/swnode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..abb6d6d59d59cb4e605fc31cc7e89f92e9f900a6 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -29,6 +29,8 @@ struct swnode {
>  	struct fwnode_handle fwnode;
>  	const struct software_node *node;
>  	int id;
> +	/* Device the managed node's lifetime is tied to. */
> +	struct device *owner;
>  
>  	/* hierarchy */
>  	struct ida child_ids;
> @@ -37,7 +39,6 @@ struct swnode {
>  	struct swnode *parent;
>  
>  	unsigned int allocated:1;
> -	unsigned int managed:1;
>  };
>  
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1145,7 +1146,7 @@ int device_create_managed_software_node(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>  
> -	to_swnode(fwnode)->managed = true;
> +	to_swnode(fwnode)->owner = dev;
>  	set_secondary_fwnode(dev, fwnode);
>  
>  	if (device_is_registered(dev))
> @@ -1190,6 +1191,7 @@ void software_node_notify(struct device *dev)
>  void software_node_notify_remove(struct device *dev)
>  {
>  	struct swnode *swnode;
> +	bool is_owner;
>  
>  	swnode = dev_to_swnode(dev);
>  	if (!swnode)
> @@ -1206,9 +1208,13 @@ void software_node_notify_remove(struct device *dev)
>  	if (!device_match_fwnode(dev, &swnode->fwnode) && swnode->fwnode.dev == dev)
>  		swnode->fwnode.dev = NULL;
>  
> +	is_owner = swnode->owner && swnode->owner == dev;
> +	if (is_owner)
> +		swnode->owner = NULL;
> +
>  	swnode_put(swnode);
>  
> -	if (swnode->managed) {
> +	if (is_owner) {
>  		set_secondary_fwnode(dev, NULL);
>  		swnode_put(swnode);
>  	}
> 
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> change-id: 20261102-swnode-only-owner-release-45efdc7123e1
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

-- 
heikki
