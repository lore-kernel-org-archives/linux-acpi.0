Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B767377EAF;
	Tue, 18 Aug 2026 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038215; cv=none; b=aWTiIwxRy5YD3lnPwTcTD7N1Ca0qpbio2/MXn/BhF3zUJOJ4eV8oYCglHzI6viTPDGRTSSQHinTzo7aYM2SzK7QeHcP0G9ndbYV1dI9C02aT+1xH30TgjrS8JUBuI6wBQAoiboJvKeT+OEfiYf3XzTClTfNhTIL0L0HQzrSSnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038215; c=relaxed/simple;
	bh=adD4hrekVKJzjV5lsiD6Q6AEfAbU+gFc1zFewcN1zJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICTy5NlKIBiCwNZL3WDQYvLzCvuevRPZO/PIQjYI0Pj0oM3M3qE1Oj+qecbkEIiBwYLL9khgnEn3Ow/TjMb2Iz6PEIFtcetI5dpU2LSCw9tSID1x6Mwk/z+tzL9DgOaqv9hBOA4ycHhHjFtavyJEoqkeR1N01GOZR13UW2Jjf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FA/YuLG1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FA/YuLG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787038213; x=1818574213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=adD4hrekVKJzjV5lsiD6Q6AEfAbU+gFc1zFewcN1zJ4=;
  b=FA/YuLG1zeM6HfaEQTMjIcTDUIHx1ly2WFMNqsUelyJhIRsKwk9kTbrW
   Ux/E1Dz5qCrnEePfZzhXLVvgGUBCSnhhSrnOxb0Dr3Ya7UAiXbhoLFvan
   /Ut16HUTB1aKWZbvlJ/7eCdGyupEQGJlxU8HjCwMDVm6vFG4GzbvXA09f
   PWsjnE6teWMOCT7b4rSzOvwggaFOvwWniDf2Uh/ktd9klkqiXxNT0HRbW
   FuP1oMe8VAz77xcPL/rvweBgsiFfP5Tq2ojR7/MyGjI++RzpkySuPV3WP
   bhpwDsTL0UIpV48ufB/SAOZCUfzZNl1n86H3AS2Ea+Rqx6IAa+bWm4kAv
   w==;
X-CSE-ConnectionGUID: 1ZavWEkPTZmmkuiJ/Gtd3g==
X-CSE-MsgGUID: 21TS8LtJT/eSx+6B0xzbhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91335144"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91335144"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:30:12 -0700
X-CSE-ConnectionGUID: wr4E8eR1TXGpg7aXAM1Q/w==
X-CSE-MsgGUID: atJtsneeQjKrAVs4KlySAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="269450324"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 00:30:06 -0700
Date: Tue, 18 Aug 2026 10:30:04 +0300
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
Subject: Re: [PATCH net-next v3 1/4] driver core: add fw_devlink
 supplier-copy helper
Message-ID: <aoQJ_Ixg9NkTm1aH@ashevche-desk.local>
References: <20260818-submit-phy-package-fwdevlink-v1-v3-0-40a905ea16b6@gmail.com>
 <20260818-submit-phy-package-fwdevlink-v1-v3-1-40a905ea16b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-submit-phy-package-fwdevlink-v1-v3-1-40a905ea16b6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 12:58:57AM -0600, James Hilliard wrote:
> Some firmware nodes describe resources shared by devices instantiated for
> their children, but the container node itself is never converted to a
> struct device. The firmware parser should retain the topology as
> described, while the framework which creates the children can identify
> the actual consumers.
> 
> Add fw_devlink_copy_suppliers() so such a framework can copy the direct
> supplier links from a container to a real consumer firmware node before
> the consumer is registered. The normal device_add() path then converts
> the copied dependencies into device links at the correct point in device
> registration.
> 
> Leave the source links in place for other children, suppress duplicate
> links and roll back newly allocated links if a copy fails. Skip ignored
> links and clear cycle flags on newly copied links, since cycle
> classification must be recomputed for the new consumer topology. Reject
> calls after the target firmware node has been associated with a device.
> Check that association while holding the fwnode-link lock so a
> concurrent device_add() either observes the copied links or makes the
> helper reject the request.

What is this paragraph about? The workflow?

> Add KUnit coverage for filtering, cycle-flag handling, idempotency, the
> pre-registration contract and conversion into an active device link.

...

> +int fw_devlink_copy_suppliers(struct fwnode_handle *to,
> +			      struct fwnode_handle *from)
> +{
> +	struct list_head *first;
> +	struct fwnode_link *link;
> +	int ret;
> +
> +	if (!to || !from)
> +		return -EINVAL;
> +	if (!fw_devlink_flags || to == from)
> +		return 0;

I think if to == NULL and from == NULL, it's fine to return 0.

	if (to == from)
		return 0;
	if (!to || !from)
		return -EINVAL;
	if (!fw_devlink_flags)
		return 0;

> +	fw_devlink_parse_fwnode(from);
> +
> +	guard(mutex)(&fwnode_link_lock);

+ blank line.

> +	if (READ_ONCE(to->dev))
> +		return -EBUSY;
> +
> +	first = to->suppliers.next;

No, we have list.h and APIs for a reason.

> +	list_for_each_entry(link, &from->suppliers, c_hook) {
> +		u8 flags = link->flags & ~FWLINK_FLAG_CYCLE;
> +
> +		if (flags & FWLINK_FLAG_IGNORE)
> +			continue;
> +
> +		ret = __fwnode_link_add(to, link->supplier, flags);
> +		if (ret)
> +			goto rollback;
> +	}
> +
> +	return 0;
> +
> +rollback:
> +	while (to->suppliers.next != first) {

Same here. I think the above and this needs to be thought through as this looks
like an AI shortcut without thinking of the existing APIs and possible different
(better) implementation.

> +		link = list_first_entry(&to->suppliers, struct fwnode_link,
> +					c_hook);
> +		__fwnode_link_del(link);
> +	}
> +
> +	return ret;
> +}

...

> +++ b/drivers/base/test/fwnode-link-test.c

> +#include <kunit/platform_device.h>
> +#include <kunit/test.h>
> +
> +#include <linux/device.h>
> +#include <linux/fwnode.h>

+ list.h

> +#include <linux/platform_device.h>
> +
> +#define FWNODE_LINK_TEST_DRIVER_NAME	"fwnode-link-test"
> +
> +struct fwnode_link_test_context {
> +	struct fwnode_handle consumer;
> +	struct fwnode_handle container;
> +	struct fwnode_handle supplier_a;
> +	struct fwnode_handle supplier_b;
> +};
> +
> +static int fwnode_link_test_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver fwnode_link_test_driver = {
> +	.probe = fwnode_link_test_probe,
> +	.driver = {
> +		.name = FWNODE_LINK_TEST_DRIVER_NAME,
> +	},
> +};
> +
> +static void fwnode_link_test_cleanup(void *data)
> +{
> +	struct fwnode_link_test_context *context = data;
> +
> +	fwnode_links_purge(&context->consumer);
> +	fwnode_links_purge(&context->container);
> +	fwnode_links_purge(&context->supplier_a);
> +	fwnode_links_purge(&context->supplier_b);
> +}
> +
> +static struct fwnode_link_test_context *
> +fwnode_link_test_init(struct kunit *test)
> +{
> +	struct fwnode_link_test_context *context;
> +	int ret;
> +
> +	context = kunit_kzalloc(test, sizeof(*context), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, context);
> +
> +	fwnode_init(&context->consumer, NULL);
> +	fwnode_init(&context->container, NULL);
> +	fwnode_init(&context->supplier_a, NULL);
> +	fwnode_init(&context->supplier_b, NULL);
> +	ret = kunit_add_action_or_reset(test, fwnode_link_test_cleanup,
> +					context);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	return context;
> +}
> +
> +static struct platform_device *
> +fwnode_link_test_register_pdev(struct kunit *test,
> +			       struct fwnode_handle *fwnode)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = kunit_platform_device_alloc(test, FWNODE_LINK_TEST_DRIVER_NAME,
> +					   PLATFORM_DEVID_AUTO);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +
> +	device_set_node(&pdev->dev, fwnode);
> +	ret = kunit_platform_device_add(test, pdev);
> +	if (ret) {
> +		KUNIT_FAIL(test, "failed to register platform device: %d", ret);
> +		return NULL;
> +	}
> +
> +	return pdev;
> +}
> +
> +static unsigned int fwnode_supplier_count(struct fwnode_handle *fwnode)
> +{
> +	struct fwnode_link *link;
> +	unsigned int count = 0;
> +
> +	list_for_each_entry(link, &fwnode->suppliers, c_hook)
> +		count++;

We have an existing API for this. I recommend to stop using AI for a moment
and just read the existing code thoroughly (list.h) and see what we have
in the kernel.

> +	return count;
> +}

...

> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h

> +int fw_devlink_copy_suppliers(struct fwnode_handle *to,
> +			      struct fwnode_handle *from);
>  bool fw_devlink_is_strict(void);

It might be better to split a test into a separate patch. But I don't care
about this much.

-- 
With Best Regards,
Andy Shevchenko


