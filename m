Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B241EC432BE
	for <linux-acpi@archiver.kernel.org>; Wed,  1 Sep 2021 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BD9B610FA
	for <linux-acpi@archiver.kernel.org>; Wed,  1 Sep 2021 17:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbhIARk2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:40:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:22410 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344905AbhIARkY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Sep 2021 13:40:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="218829206"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="218829206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:39:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="688467610"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 10:39:22 -0700
Received: from andy by smile with local (Exim 4.95-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mLUCl-00GUqP-Q8;
        Wed, 01 Sep 2021 20:39:19 +0300
Date:   Wed, 1 Sep 2021 20:39:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: TPS68470 PMIC config option
Message-ID: <YS+6xzk9yc8uPetU@smile.fi.intel.com>
References: <20210901160234.0e3e24b2@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901160234.0e3e24b2@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc: Sakari.

On Wed, Sep 01, 2021 at 04:02:34PM +0200, Jean Delvare wrote:
> Hi Andy,
> 
> Is there a reason why config TPS68470_PMIC_OPREGION is not under "if
> PMIC_OPREGION" where all other *_PMIC_OPREGION driver options are?

It was originally like that.

Sakari, do you know?

-- 
With Best Regards,
Andy Shevchenko


