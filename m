From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 12/16] device property: Move dev_fwnode() to linux/property.h
Date: Mon, 13 Mar 2017 22:49:24 +0100
Message-ID: <5262143.K42JDpMSHF@aspire.rjw.lan>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com> <1488809970-25568-13-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63433 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752277AbdCMVyt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Mar 2017 17:54:49 -0400
In-Reply-To: <1488809970-25568-13-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

On Monday, March 06, 2017 04:19:26 PM Sakari Ailus wrote:
> The function to obtain a fwnode related to a struct device is useful for
> drivers that use the fwnode property API: it allows not being aware of the
> underlying firmware implementation.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/base/property.c  |  6 ------
>  include/linux/property.h | 10 ++++++++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 111049b..860e160 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -183,12 +183,6 @@ static int pset_prop_read_string(struct property_set *pset,
>  	return 0;
>  }
>  
> -static inline struct fwnode_handle *dev_fwnode(struct device *dev)
> -{
> -	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> -		&dev->of_node->fwnode : dev->fwnode;
> -}

What about making it non-inline instead?

> -
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 0ae7d20..0b61ea4 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -13,11 +13,11 @@
>  #ifndef _LINUX_PROPERTY_H_
>  #define _LINUX_PROPERTY_H_
>  
> +#include <linux/device.h>
>  #include <linux/fwnode.h>
> +#include <linux/of.h>
>  #include <linux/types.h>

You would not need to add the above includes here then.

Thanks,
Rafael

