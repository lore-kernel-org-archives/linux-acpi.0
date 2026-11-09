Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258823;
	b=XD/VwuqyKefVuQUs8nq3JZrUonvhWUmwHnQsVlzekYgeCQDAJrJ34o6FVP2n5cYUHH5m
	 wZel4JJrDHSNraZUnKiWv8YK01mDwbJJEhwEC4W32vaWqsCxGDbAEbYoy72EQhHGpMBK6
	 QlqzASwoVs9P0mM+VOKorvSJ+9RI3v+44e66tAiOABpSPe8C02TUy4j7cNgtlwojDzvKv
	 sSMrTA7qldpqHj2iKrXfc+t+Kgi7M+VbxUVRPuVND82YJTAh96V0ZXk2zja1Qv2NJBKnx
	 JCrdS8mnsB50KPucJntZCwcqd6ya8reZncQxAL8F+t0RAg98GLocJIoBmASNJRJc4vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258823;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=V6S6ADLAOTA23gGkcqpm9vsCKsCWK50iy0cw18dDWEY=;
	b=BnqobjSt6awM7XtBfC0wwCiqXGXP0lllPB19t8wlPGr03LSrZFeq6ckaTDZlr4G70A7R
	 hO4a62EZq8ZlLCy9ze+hw3z62Un/coaAycCtMBLGNS49p7q1zBhdtLlE+FzQsnFFa8vbV
	 bOFkjjoH32V9PP2d5U7DegezqcZyDsE2K9Wuv9/0E9s6gir9t9ylpjswNv6gFS8/PQBic
	 eKK9WMAaxBU2SiJ6CtbB5Jm80pVa7FK22n0t66ppd9anO9JezhKoVG93KxjjYJr66Rmnw
	 ltD4vbVrNSmYtqfUzB4nexUjF1QiWJy0tOaNU10dXcOJ9DMUx/54WCSgTF9IALFjhew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7V4piKU;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39573606A31C;
	Mon,  9 Nov 2026 21:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39573606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I7V4piKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794258824; x=1825794824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bUFL1VnRt9/kwtxYQqI5cg6sG3sMLWSyuNPbrpq49Yo=;
  b=I7V4piKUHrUdznyETcrOUv91Bxdfp3shi8VAKBOvpxD7vpIZGgNIeM7N
   YRVb3o+qAKbT7xV1aJ1f+snsE76FDSsHdQATeGqLV1+nADvLmX0P8v8cR
   7VTSXvzQo88pEW0bJ5+3gmsNEVXLI6IWUxz56KejTrJ9GvdJzH37oQWai
   kNrvYBZolIXkuaMjXJ5DMr+u5xUy0HI3OB0SzQJGa+x3hjJze56F+t2mT
   DqSfE/NFTR7Y+4m2D570HvLlYPkFu7VH2qbAlLLL3qawwylFedhu3DJ5e
   aiGrEnwf/Um6BglK8yx6AjryYqDo/dFoX+SIRuCDK1TIcZ6LOJUpu+ZYN
   w==;
X-CSE-ConnectionGUID: sjV/cByZSJWxPiAnDqgb8Q==
X-CSE-MsgGUID: W7fG9LQZRBa0NGtKbeRNcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2881628"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2881628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:13:42 -0800
X-CSE-ConnectionGUID: YxnrjC0TTP+9AzDlLTW0vA==
X-CSE-MsgGUID: 4c+5US7AQQ+rz0DKt15Orw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7985628"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:13:38 -0800
Date: Mon, 9 Nov 2026 23:13:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/4] software node: pin referenced swnodes while
 resolving them
Message-ID: <avI3f7ZK_qx_Rd7j@ashevche-desk.local>
References: <20261106-swnode-race-v1-v2-0-f8bc7b14d578@nxp.com>
 <20261106-swnode-race-v1-v2-3-f8bc7b14d578@nxp.com>
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
In-Reply-To: <20261106-swnode-race-v1-v2-3-f8bc7b14d578@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 06, 2026 at 12:38:37PM +0800, Peng Fan (OSS) wrote:

> software_node_get_reference_args() and software_node_add_links() resolve
> DEV_PROP_REF entries by calling software_node_fwnode(), which returns a
> borrowed pointer. The referenced swnode can be unregistered and released
> between the lookup and the fwnode reference or link operation.
> 
> Use software_node_to_swnode_get() for software node references and keep
> the reference until the argument or link has been set up. For direct
> fwnode references in software_node_add_links(), take a reference with
> fwnode_handle_get() and release it after fwnode_link_add() completes.

...

> -	if (ref->swnode)
> -		refnode = software_node_fwnode(ref->swnode);
> -	else if (ref->fwnode)
> -		refnode = ref->fwnode;
> -	else
> -		return -EINVAL;
> +	if (ref->swnode) {
> +		struct swnode *remote = software_node_to_swnode_get(ref->swnode);
>  
> -	if (!refnode)
> -		return -ENOTCONN;
> +		if (!remote)
> +			return -ENOTCONN;

It's always better to maintain when assignment is coupled with a validation
check.

		struct swnode *remote;

		remote = software_node_to_swnode_get(ref->swnode);
		if (!remote)
			return -ENOTCONN;

> +		refnode = &remote->fwnode;
> +	} else if (ref->fwnode) {
> +		refnode = fwnode_handle_get(ref->fwnode);
> +	} else {
> +		return -EINVAL;
> +	}

...

> -			if (ref->swnode)
> -				refnode = software_node_fwnode(ref->swnode);
> -			else if (ref->fwnode)
> -				refnode = ref->fwnode;
> -			else
> +			if (ref->swnode) {
> +				struct swnode *remote;

> +				remote = software_node_to_swnode_get(ref->swnode);
> +				if (!remote)
> +					continue;

Seems like a dup code, perhaps a helper?

> +				refnode = &remote->fwnode;
> +			} else if (ref->fwnode) {
> +				refnode = fwnode_handle_get(ref->fwnode);
> +			} else {
>  				continue;
> +			}
>  
>  			/* Supplier not registered yet, or self-reference. */
> -			if (!refnode || refnode == &swnode->fwnode)

> +			if (refnode == &swnode->fwnode) {
> +				fwnode_handle_put(refnode);
>  				continue;
> +			}
>  
>  			fwnode_link_add(&swnode->fwnode, refnode, 0);
> +			fwnode_handle_put(refnode);

I don't see a context, but it looks like it continues in both cases.
If so, the above may be refactored for that.

-- 
With Best Regards,
Andy Shevchenko


