Return-Path: <SRS0=hrbu=X2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A11C352AA
	for <linux-acpi@archiver.kernel.org>; Tue,  1 Oct 2019 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C07E21855
	for <linux-acpi@archiver.kernel.org>; Tue,  1 Oct 2019 09:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfJAJcv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:32:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:54715 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfJAJcv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Oct 2019 05:32:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 02:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205031901"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Oct 2019 02:32:46 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Oct 2019 12:32:45 +0300
Date:   Tue, 1 Oct 2019 12:32:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/6] ACPI / utils: Move acpi_dev_get_first_match_dev()
 under CONFIG_ACPI
Message-ID: <20191001093245.GG2714@lahna.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
 <20190924193739.86133-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924193739.86133-3-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37:35PM +0300, Andy Shevchenko wrote:
> We have a stub defined for the acpi_dev_get_first_match_dev() in acpi.h
> for the case when CONFIG_ACPI=n.
> 
> Moreover, acpi_dev_put(), counterpart function, is already placed under
> CONFIG_ACPI.
> 
> Thus, move acpi_dev_get_first_match_dev() under CONFIG_ACPI as well.
> 
> Fixes: 817b4d64da03 ("Introduce acpi_dev_get_first_match_dev() helper")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
