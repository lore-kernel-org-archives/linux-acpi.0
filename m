Return-Path: <SRS0=KIqj=IG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB998C433DB
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Mar 2021 10:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851B5651A5
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Mar 2021 10:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhCHK1N (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Mar 2021 05:27:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:35087 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhCHK0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Mar 2021 05:26:42 -0500
IronPort-SDR: zKIw0jXppZCU/N7orVq71MO52M+Yi6McL2ojUJQX6vfceaBqaubMfYOujHlzvp2kZZCKEylk4A
 pvGZdrYqAxig==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="249383265"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="249383265"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:26:39 -0800
IronPort-SDR: GCyVMSlolox2gY5HTDX57lQtulQu84OJoJJbNlsESxexLJVo4/nkdYsdvVtBD/wxfE9aXbyNxm
 qHVQCk5Kl1dw==
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="385806533"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 02:26:37 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJD5u-00Amzi-NB; Mon, 08 Mar 2021 12:26:34 +0200
Date:   Mon, 8 Mar 2021 12:26:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux GPIO <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] intel-gpio for 5.12-2
Message-ID: <YEX72lTYIwxc0I8O@smile.fi.intel.com>
References: <YD9K8LzSFpuAhDvW@black.fi.intel.com>
 <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Mf1MsRUGJN9Y09yVQ=OO41-kYRo8n3D3tyLpymnJ6_JvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Mar 06, 2021 at 12:38:33PM +0100, Bartosz Golaszewski wrote:
> On Wed, Mar 3, 2021 at 3:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Hi Linux GPIO and ACPI maintainers,
> >
> > This is material for v5.12-rcX (presumably -rc2). Since it touches ACPI, this
> > PR is to both subsystems.

> Pulled, thanks!

Thanks! Though I don't see it in your repository.

-- 
With Best Regards,
Andy Shevchenko


