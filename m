Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52773315D23;
	Mon, 29 Jun 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755169; cv=none; b=JUEK/XXkPmNcb1lnpvC2mbfDEBb85NW31i8ChtoHItji0xVW1KRYOyHcgSpYNLSwWMJ+OoV8BoufaJT+yF7XpqpV3lDu2l5aTo70bwRHB5lLi/b4wyOVH0e6PeEcuMbR4JIz413TSMxVM5WlgxiNHWlpwOcBpsPB79MejdQlBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755169; c=relaxed/simple;
	bh=+fVep1oaw10FmngY3yJgEadhXu7Kjk9Ol4Nu80XY4rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIcB0JWP+99dYZV/4yaBnNBQ9n4jA4KhWlUkd7iolcNODrbpD9VvfGndKiKKvVuTwPO4loPvWjEgGyeMtPOAM3RP8PwrAIeJCewMxNhkqWXEzzJ42iHNQzn38zsYzyGCazxI/cBJYBNAL+eKXo3NabTy7T+VFmCoeioC60RyAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6ljByvJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6ljByvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782755169; x=1814291169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+fVep1oaw10FmngY3yJgEadhXu7Kjk9Ol4Nu80XY4rY=;
  b=E6ljByvJvSpo2et13pi03TVc/7K2hhowkzcdr4Khbg36718VhacZE3Hk
   j0CRqcx5q+buTyZ+DOct0Od2WVQWfzu/M35RjTrt14nq6bZj/1FD8h+G1
   tf8bpqTlKMse19sc07Q5O4yhnKr8ZQDV8Mv0cg9G5+glomHWzWynhckuO
   BM3lBB4+SQ27r0fhtJvMlCUCapbq0aN8ZxANHg2oGLOfmwxW5LLYzAapl
   /JmQ1FSkdHV6Ei72F1zhtkvGM9eQXiadaNfz6dwT4/vwlsUEkO0kfbWHP
   V54olv6XS8znpHmJO7k5+l9/hoUfBPjwN6lQ9eORZZgIhwOxYZmfwsS9Y
   w==;
X-CSE-ConnectionGUID: X90IEqDVQHShWnlAU1oiqg==
X-CSE-MsgGUID: BKj4b1gCSO6KUFzdHmRGxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83231498"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83231498"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:46:08 -0700
X-CSE-ConnectionGUID: OyraD0aAT0Gu1j9fYo9gbA==
X-CSE-MsgGUID: 0T6lZFEkTVmSDrmFqaaaoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="255626633"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:46:05 -0700
Date: Mon, 29 Jun 2026 20:46:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: mike.isely@cobaltdigital.com, Bartosz Golaszewski <brgl@kernel.org>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] software node: Only the managing device can
 unreference managed software node
Message-ID: <akKvWmZ2KqOs6da6@ashevche-desk.local>
References: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303211348.2414465-1-mike.isely@cobaltdigital.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 03:13:47PM -0600, mike.isely@cobaltdigital.com wrote:

+Cc: Bart (I believe you will be interested in this case).

> Explanation here is lengthy because the problem is subtle.
> 
> A scenario exists where device_create_managed_software_node() is used
> to create an swnode instance that will be implicitly shared to a child
> device despite best intentions not to permit such sharing (per the
> comment in device_create_managed_software_node()).  I encountered this
> with the sfp kernel module when it was instantiated with properties
> via a call to platform_device_register_full() - it will create hwmon
> child devices which get all property references.  Unfortunately with
> just a "managed" boolean in struct swnode handling this, then
> kobject_put() gets called for the managed aspect when the child device
> goes away instead of the parent.  This leads to premature freeing of
> the swnode structure, followed by use-after-free problems, heap
> corruption, and generally chaos / crashes / misbehavior in the kernel.
> 
> This commit changes that boolean into a pointer to the actual managing
> struct device, which is then checked against the struct device
> instance that is actually going away (via the usual call back into
> software_node_notify_remove()).  Thus the child device removal is
> ignored as it should, and we only do the kobject_put() when the actual
> managing struct device instance goes away.  We effectively carry a
> little bit more information now so that we can be sure to clean up
> only when the correct struct device instance is actually going away.
> 
> Note that while we are now keeping a pointer to a struct device here,
> this is safe to do because the pointer itself only stays in use while
> the pointed-to device remains valid.  (So no need to be concerned
> about additional reference counting.)
> 
> Here's a succinct, generic sequence that spells out the steps which
> lead to trouble:
> 
>   1. Somebody creates a struct device instance.
> 
>   2. Somebody calls device_create_managed_software_node() associating
>   it with that struct device instance.  This causes two kobject
>   references to be counted against the swnode instance (one for the
>   struct device and one because the managed flag was set).  refcount=2
> 
>   3. Some time later, a child struct device is created and the
>   properties of the parent are shared with the child.  This causes
>   another kobject reference to be counted against the swnode instance.
>   refcount=3
> 
>   4. Some time later, that child struct device instance goes
>   away (perhaps due to a hotplug removal).  During the tear-down,
>   software_node_notify_remove() notices that the managed field of the
>   swnode instance is set, so TWO kobject references are removed
>   instead of the single reference created by the previous step.
>   refcount=1
> 
>   5. Repeat step 3.  refcount=2
> 
>   6. Repeat step 4.  refcount=0
> 
>   7. Now the kobject reference count inside the swnode instance has
>   dropped to zero and so the swnode instance is released.  Notice that
>   the parent device is still holding a physical reference, now
>   pointing into freed memory.  Chaos likely follows.  If lucky, a NULL
>   pointer kernel oops is the result.
> 
> The patch fixes this by causing step 4 to only do the second reference
> decrement if the device being torn down is the same one that
> established the managing relationship in the first place.  Then
> everything stays balanced.
> 
> I confirmed this exact sequence of behavior in the context of the sfp
> kernel module with appropriate printk debug trace added, when
> instantiated with platform_device_register_full() with properties
> provided.  While that's may be hard for to reproduce without sfp
> hardware, anything else which performs those steps should produce
> similar results.
> 
> Note that because platform_device_register_full() will implicitly
> employ a managed swnode instance any time it is passed properties in
> its pdevinfo argument, then by implication anyone calling
> platform_device_register_full() in that manner - which happens in
> multiple other places in the kernel - is at risk for the same issue.
> 
> Signed-off-by: Mike Isely <mike.isely@cobaltdigital.com>
> Signed-off-by: Mike Isely <isely@pobox.com>
> ---
>  drivers/base/swnode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 53b3f0061ad12..18a903a35197c 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -36,8 +36,8 @@ struct swnode {
>  	struct list_head children;
>  	struct swnode *parent;
>  
> +	struct device *managing_dev;
>  	unsigned int allocated:1;
> -	unsigned int managed:1;
>  };
>  
>  static DEFINE_IDA(swnode_root_ids);
> @@ -1060,7 +1060,7 @@ int device_create_managed_software_node(struct device *dev,
>  	if (IS_ERR(fwnode))
>  		return PTR_ERR(fwnode);
>  
> -	to_swnode(fwnode)->managed = true;
> +	to_swnode(fwnode)->managing_dev = dev;
>  	set_secondary_fwnode(dev, fwnode);
>  
>  	if (device_is_registered(dev))
> @@ -1104,7 +1104,7 @@ void software_node_notify_remove(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "software_node");
>  	kobject_put(&swnode->kobj);
>  
> -	if (swnode->managed) {
> +	if (swnode->managing_dev == dev) {
>  		set_secondary_fwnode(dev, NULL);
>  		kobject_put(&swnode->kobj);
>  	}
> -- 
> 2.47.3
> 
> ---
> 
> Correct issue in drivers/base/swnode.c that can lead to use-after-free
> due to kobject reference counting error, which itself is due to
> incorrect behavior with the "managed" struct swnode flag in
> circumstances involving child struct device instances where the parent
> struct device is managing a struct swnode.
> 
> Use-after-free in this case leads to likely kernel heap corruption, so
> any manner of chaos can result, if left unaddressed.

-- 
With Best Regards,
Andy Shevchenko


