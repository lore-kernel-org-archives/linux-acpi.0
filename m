Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA7C4320A
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Aug 2021 14:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F553610A3
	for <linux-acpi@archiver.kernel.org>; Thu, 12 Aug 2021 14:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhHLOON (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:14:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:19633 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237893AbhHLOON (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 10:14:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="195628171"
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="195628171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:13:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,316,1620716400"; 
   d="scan'208";a="673619429"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 07:13:44 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mEBSk-008fEr-5m; Thu, 12 Aug 2021 17:13:38 +0300
Date:   Thu, 12 Aug 2021 17:13:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linux GPIO <linux-gpio@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     David Thompson <davthompson@nvidia.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        Liming Sun <limings@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Possible ACPI abuse in Mellanox BlueField Gigabit Ethernet driver
Message-ID: <YRUskkALrPLa2cSf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi!

From time to time I do grep kernel for ACPI_RESOURCE_TYPE_GPIO usage.
Recently the drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_gpio.c
caught my eye.

Looking into the code I see that it looks like misunderstanding of how ACPI
works with GPIOs. First of all, I would like to inform that this code has
been properly reviewed neither by GPIO nor by ACPI maintainers. Second, before
going it to the real conclusions (and potential revert of this), I would like
to see the real ACPI tables for this and some explanations from the authors of
the driver about GPIO usage here (from hw and sw perspectives).

It makes sense to discuss ASAP, otherwise I would really want to revert it.

-- 
With Best Regards,
Andy Shevchenko


