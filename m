Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53471C6FD1F
	for <linux-acpi@archiver.kernel.org>; Wed, 22 Mar 2023 09:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCVJi3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCVJi0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 05:38:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB11989;
        Wed, 22 Mar 2023 02:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679477905; x=1711013905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQ0ma1DS/5QZs63ZmlAiWW5xtbmloqfCkaH7fe2xda8=;
  b=c1uPOVREdRuJWag0YmrbLfp/5OZb2vW4Pi9Zp/XhDYHi869dF822MIj/
   hQQdsVMEUTUPrBOjtgJs5ysO3xItK3jCgnJ/2uaz4fvgjwGJFa/ryF6b2
   JsMg9bLjkw57UduBlCOpcudfbxNM9h6Ib0JeyGv2aKgLB5jNtR/9vnOdf
   0HGY1ZjFrFg5cVKYT/+qSJTlr28yCDyUeS28EN++q5AwlB73rHO55osDW
   JW6zO7lVN5nE87MCqztFlMh59cHei+2YHHzl68uoBlf/4V44FhXjtrAZD
   68ylPM9BZs2IhUPCnQtJkuRobeqSaIp9SdlZZgwtraQDXPeAjvUkHNdJe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319562297"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="319562297"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 02:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="684237136"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="684237136"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2023 02:38:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peuvF-0075Az-0P;
        Wed, 22 Mar 2023 11:38:21 +0200
Date:   Wed, 22 Mar 2023 11:38:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Niyas Sait <niyas.sait@linaro.org>
Cc:     mika.westerberg@linux.intel.com, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sudeep.Holla@arm.com, Souvik.Chakravarty@arm.com,
        Sunny.Wang@arm.com, lorenzo.pieralisi@linaro.org,
        bob.zhang@cixtech.com, fugang.duan@cixtech.com
Subject: Re: [RFC v1 1/1] Refactor ACPI DMA to support platforms without
 shared info descriptor in CSRT
Message-ID: <ZBrMjLVpJRfj7Hx9@smile.fi.intel.com>
References: <20230321160241.1339538-1-niyas.sait@linaro.org>
 <ZBnvHSmHVvgsumlM@smile.fi.intel.com>
 <6e90881b-ba24-7f5a-e80d-1ae7fc9d9382@linaro.org>
 <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBrLr4QDdZpgs3RV@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 22, 2023 at 11:34:40AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 22, 2023 at 07:56:11AM +0000, Niyas Sait wrote:
> > On 21/03/2023 17:53, Andy Shevchenko wrote:
> > 
> > > can_we_avoid_long_name_of_the_functions_please() ?
> > 
> > Sure, will do that.
> > 
> > > Also is this renaming is a must?
> > 
> > It is not a must. I considered the existing method with shared info
> > as a special case as it uses non standard descriptors from CSRT table
> > and introduced the new function to handle it.
> > 
> > > Btw, what is the real argument of not using this table?
> > > 
> > > Yes, I know that this is an MS extension, but why ARM needs something else and
> > > why even that is needed at all? CSRT is only for the _shared_ DMA resources
> > > and I think most of the IPs nowadays are using private DMA engines (or
> > > semi-private when driver based on ID can know which channel services which
> > > device).
> > 
> > The issue is that shared info descriptor is not part of CSRT definition [1]
> > and I think it is not standardized or documented anywhere.
> > 
> > I was specifically looking at NXP I.MX8MP platform and the DMA lines for
> > devices are specified using FixedDMA resource descriptor. I think other Arm
> > platforms like RPi have similar requirement.
> 
> Perhaps, but my question is _why_ is it so?
> I.o.w. what is the technical background for this solution.
> 
> > [1] https://uefi.org/sites/default/files/resources/CSRT%20v2.pdf

JFYI: ARM platform(s) use SPCR, which is also not a part of the specification.

-- 
With Best Regards,
Andy Shevchenko


