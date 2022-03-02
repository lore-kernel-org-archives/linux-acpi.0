Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB60C433EF
	for <linux-acpi@archiver.kernel.org>; Wed,  2 Mar 2022 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbiCBRKZ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiCBRKY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2022 12:10:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7E6342;
        Wed,  2 Mar 2022 09:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646240981; x=1677776981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ARu95SNjYvUW6s+dQ5hSBTaIXLn2LgPc0xfUHeJLPZ8=;
  b=Kcnwq8R/yC952bKJDjGmx4d8EwmscA4Ac5uEyQ0MaKD4CW7TZOtsVBXh
   7u0iB61y0FvWqXn3Onu7RSiRWof4mPOucmAqP7j2bEnA71q4QZPER2UOb
   cDhlV1CPYWAGXN06fYLCFruln7j2y61Au1JfDF+B9V/WYRG4eggm3aV8c
   +aVRORwTVqAm7hk/HigDBFK9hitQaVgBIPXJJsjcLCNPWnXk6ZtciWKqn
   bGklHoGHpPSGZcBNfmHvcW0jkFvMW2LVVsC3DVkl9u8zRuSycefSka/H7
   3ZeK7HCQTZpZ2inApn2OqZAG0Fa6P06bM9n+kzPk1KYR1IWroNUbLZCIr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251027450"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="251027450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:09:15 -0800
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="511078765"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:09:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nPSSf-00APUi-LB;
        Wed, 02 Mar 2022 19:08:25 +0200
Date:   Wed, 2 Mar 2022 19:08:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nvdimm@lists.linux.dev, Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: Switch to use list_entry_is_head() helper
Message-ID: <Yh+kiSMZPleBcOXh@smile.fi.intel.com>
References: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com>
 <Yh+SHs4CEWkiLxAe@smile.fi.intel.com>
 <CAJZ5v0g_3a7A5aFab6ZsM8nPDmivoTeNgdSG17Lt71mFKmNxmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_3a7A5aFab6ZsM8nPDmivoTeNgdSG17Lt71mFKmNxmg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 02, 2022 at 05:36:20PM +0100, Rafael J. Wysocki wrote:
> On Wed, Mar 2, 2022 at 4:50 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 11, 2022 at 01:04:23PM +0200, Andy Shevchenko wrote:
> > > Since we got list_entry_is_head() helper in the generic header,
> > > we may switch the ACPI modules to use it. This eliminates the
> > > need in additional variable. In some cases it reduces critical
> > > sections as well.
> >
> > Besides the work required in a couple of cases (LKP) there is an
> > ongoing discussion about list loops (and this particular API).
> >
> > Rafael, what do you think is the best course of action here?
> 
> I think the current approach is to do the opposite of what this patch
> is attempting to do: avoid using the list iterator outside of the
> loop.

OK, let's drop this change.

-- 
With Best Regards,
Andy Shevchenko


