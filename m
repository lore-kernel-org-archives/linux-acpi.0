Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13535C197;
	Tue, 18 Aug 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038765; cv=none; b=ShKLe7TjHioF2G56KpASeUbLynyPApsdy88xPQiuiFOpbANobD3aheOL78NhclgAQscolWXnkvWlx+cCLEPMCc1Lfl/y3EyYQmV/idqGkkOMwordy02vozDIPxOOvnYk8NE0HvdoYvuG7bfx/YoFFvUBaTPLE3mkwXY0YqXnJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038765; c=relaxed/simple;
	bh=rUZuiYBQhddnOH+vaEvo30zPTJjxHELmXEY2dzNJ/zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdtrCQjnJsWHegLnmobXL9y+hkkSeHsuwXeRmwS4RCgaQRwMHgitf3P69IynryQ6UxRCHyMnQD3dKIw+GfAW3nl5BJvzV9FY96SKkRGKUpu5SGzsplHhUc+LJ0lGYJKCcfD3v+s2NWfZRKAKNVsl9aAtLj+HkLwKL4fGh99UFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoE42hQ+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoE42hQ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787038765; x=1818574765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rUZuiYBQhddnOH+vaEvo30zPTJjxHELmXEY2dzNJ/zk=;
  b=HoE42hQ+0rDrJ/DNzWiohG9lCdPH1mtUZIxQxAOyQTMNFQIwB4wsFtyH
   +PeHu3yrFd+QLON63r1JYDprLzgvaYOzUjmGbPclzPWwvNceMfcdETdZ1
   Zg0U+za3zu5K3KyyIUI19IxKSz1UT553akdFWO7Rb0UMBdSsBh55juOUI
   VTVpEAVUyjaw8AxYpK/ICMVZH16X4g7/c6PaNbixftIleuQBiDvQ2El9p
   YWqIXGLXc7B0a/oGKgURwjPaRhnhv/QfwnRNZQMTvTJKaM9vjd27l5ou0
   gp55AoxZUaWjtZnmdvMX2AsrHj5W1HOAeKOdWIgEheWC4W1pEX2t4GN9e
   Q==;
X-CSE-ConnectionGUID: ucpy3r9DQoyTIOn3bngPpA==
X-CSE-MsgGUID: ycpeORgdR0uAgb4ReR+xMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98676787"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="98676787"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:39:24 -0700
X-CSE-ConnectionGUID: 6rx1eunEQ6K3p9ombMUnGQ==
X-CSE-MsgGUID: n58X/hcrREWuLNX7Ojee3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262522257"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:39:18 -0700
Date: Tue, 18 Aug 2026 10:39:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/4] net: mdio: link PHY package suppliers to
 member PHYs
Message-ID: <aoQMI4yxEzRFQ3Bg@ashevche-desk.local>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
 <20260818-submit-phy-package-fwdevlink-v1-v3-2-40a905ea16b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-2-40a905ea16b6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 12:58:58AM -0600, James Hilliard wrote:
> Ethernet PHY package nodes describe resources shared by their member
> PHYs, but a package node is not instantiated as a device. Its
> firmware-node supplier links therefore cannot become normal device links
> for the PHY members without help from the MDIO layer.
> 
> When registering an OF-backed PHY whose parent is an
> ethernet-phy-package node, copy the package supplier links onto the
> member's firmware node before the PHY device is added. The ordinary
> fw_devlink path then creates managed links after the PHY device has been
> initialized for link registration and before its driver can probe.
> 
> Apply this to both ordinary OF discovery and the exported registration
> path for a pre-created PHY device. Leave the package links intact so
> every member, including one registered later, can acquire the same
> dependencies. This preserves probe, unbind and runtime-PM ordering
> without adding PHY-package policy to generic firmware parsing.

...

>  #include <linux/device.h>
>  #include <linux/err.h>

> +#include <linux/fwnode.h>

How is this being used?

>  #include <linux/fwnode_mdio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>

...

> +static int of_mdiobus_link_phy_package(struct device_node *child)
> +{
> +	struct device_node *package __free(device_node) = of_get_parent(child);
> +
> +	if (!package || !of_node_name_eq(package, "ethernet-phy-package"))
> +		return 0;
> +
> +	return fw_devlink_copy_suppliers(of_fwnode_handle(child),
> +					 of_fwnode_handle(package));

It could be moved to fwnode from the start. Don't we have the respective parts
already?

> +}

-- 
With Best Regards,
Andy Shevchenko


