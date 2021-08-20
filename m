Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F4C432BE
	for <linux-acpi@archiver.kernel.org>; Fri, 20 Aug 2021 12:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B2460FE6
	for <linux-acpi@archiver.kernel.org>; Fri, 20 Aug 2021 12:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhHTMVm (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:21:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:58698 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240547AbhHTMVk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 08:21:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="213640359"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="213640359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:21:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="595659589"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:21:01 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mH3W3-00Bofz-NE; Fri, 20 Aug 2021 15:20:55 +0300
Date:   Fri, 20 Aug 2021 15:20:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [RFC 1/3] imx258: Defer probing on ident register read fail (on
 ACPI)
Message-ID: <YR+eJytxRcVpSxgA@smile.fi.intel.com>
References: <20210819201936.7390-1-sakari.ailus@linux.intel.com>
 <20210819201936.7390-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819201936.7390-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 19, 2021 at 11:19:34PM +0300, Sakari Ailus wrote:
> Return -EPROBE_DEFER if probing the device fails because of the I²C
> transaction (-EIO only). This generally happens when the power on sequence
> of the device has not been fully performed yet due to later probing of
> other drivers.

...

> +	if (ret == -EIO && is_acpi_device_node(dev_fwnode(&client->dev))) {

has_acpi_companion() is better to have here, no?

> +		/*
> +		 * If we get -EIO here and it's an ACPI device, there's a fair
> +		 * likelihood it's because the drivers required to power this
> +		 * device on have not probed yet. Thus return -EPROBE_DEFER.
> +		 */
> +		return -EPROBE_DEFER;
> +	}

-- 
With Best Regards,
Andy Shevchenko


