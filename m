Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D5C433E9
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Mar 2021 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F4565260
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Mar 2021 19:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCHTxW (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:53:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:50368 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbhCHTwv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 14:52:51 -0500
IronPort-SDR: X2puvW5TYLwwDmjJ8B/lU9vuiIiRVDyZ+t+iPxU25KdWSz2ILsNyaFv7nPrNWysf3C/vOHKQCY
 ESHbv8fNzANQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207864408"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="207864408"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:52:51 -0800
IronPort-SDR: Yx6g48chMPt/AJZKnKf+VB2noc8/t5zcNm/qIwXKvFq9d4CVAIUZ174oopcZ1p3E1WIOvAZiu0
 upFaOLh4hw/w==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="520048158"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 11:52:49 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJLvq-00Atpl-8T; Mon, 08 Mar 2021 21:52:46 +0200
Date:   Mon, 8 Mar 2021 21:52:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 2/2] gpiolib: Fold conditionals into simple ternary
 operator
Message-ID: <YEaAjmCEn+0ZihjR@smile.fi.intel.com>
References: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
 <20210308193146.65585-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com>
 <YEZ/LFwFkh3+zyjY@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEZ/LFwFkh3+zyjY@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 08, 2021 at 09:46:52PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 08, 2021 at 08:43:19PM +0100, Rafael J. Wysocki wrote:

> I just sent v5 without this, sorry :-)

I will do it in v6.

-- 
With Best Regards,
Andy Shevchenko


