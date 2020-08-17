Return-Path: <SRS0=UsKU=B3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FF6C433E1
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Aug 2020 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C065206FA
	for <linux-acpi@archiver.kernel.org>; Mon, 17 Aug 2020 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgHQKfa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:35:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:39037 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQKf3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Aug 2020 06:35:29 -0400
IronPort-SDR: 9XRqITadBPJ1mssyb2Ub7trnoeUKMcMVLFkgWnoJuh3GAKCLe/iSvlbzGegKZBqBIPV4u/0oXd
 7AOm9u6hIAgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="155766989"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="155766989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 03:35:28 -0700
IronPort-SDR: P97oS++z/R2rMjl1iJBK9Nlrx5yiXyc8ZqWGdlOBvPX9h9Wcy/JKQenLSpQXqUeYFDxU0K168D
 fvHgu8aZ1DWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="400153078"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Aug 2020 03:35:26 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Aug 2020 13:35:25 +0300
Date:   Mon, 17 Aug 2020 13:35:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: Move TPS68470 OpRegion driver to
 drivers/acpi/pmic/
Message-ID: <20200817103525.GD1375436@lahna.fi.intel.com>
References: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
 <20200814132726.11456-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814132726.11456-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 14, 2020 at 04:27:26PM +0300, Andy Shevchenko wrote:
> It is revealed now that TPS68470 OpRegion driver has been added
> in slightly different scope. Let's move it to the drivers/acpi/pmic/
> folder for sake of the unification.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
