Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C389C38A2D
	for <linux-acpi@archiver.kernel.org>; Tue, 25 Oct 2022 09:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiJYJMj (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 25 Oct 2022 05:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiJYJMQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2022 05:12:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187916E28C;
        Tue, 25 Oct 2022 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666688769; x=1698224769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVVNFnPd0rsSyjJKo6UrNXzcN+sjgjFC6IOZJD87/6A=;
  b=LAHevOjD7FP5XSDucVRDn+I9/pZ9Yx/ONngsRoNuZk6VaQsgIzJ3JnOg
   pIUapUFgjv5P1hRS5q7EFcfQDhVi83Ww4tMDEwOCInOPmVSY6rcjsBLLd
   VhMuLfRbioBTfhqmICpzgb30aVaKMpDrfVeCzCyuhpvIYk368Lkr+uG5L
   pxKoLUSp2z+4CnOn4ISvFRBzdhiVgIJDhGd71qpB6ZCdFv00g11o8aC4F
   GdDPaZybAyDUCEg3nrCm7X4YhPGnQc48MVsyq39Ix7BMIk4rD+LHvUdUM
   pkt1H2BrZKc8LNv8bwzCHihxzGVRvEljpqHZdaktOB5Peo3mU8LBVgxop
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="393943472"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="393943472"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 02:06:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="664843110"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="664843110"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2022 02:06:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onFsr-001uny-29;
        Tue, 25 Oct 2022 12:06:05 +0300
Date:   Tue, 25 Oct 2022 12:06:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Fix documentation for
 *_match_string() APIs
Message-ID: <Y1em/YJwcvLV4J05@smile.fi.intel.com>
References: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 06, 2022 at 03:38:07PM +0300, Andy Shevchenko wrote:
> The returned value on success is an index of the matching string,
> starting from 0. Reflect this in the documentation.
> 
> Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Is this gone through the cracks?

-- 
With Best Regards,
Andy Shevchenko


