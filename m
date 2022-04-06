Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CD7C433EF
	for <linux-acpi@archiver.kernel.org>; Wed,  6 Apr 2022 16:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiDFQFY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiDFQFR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2022 12:05:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6533504A4;
        Wed,  6 Apr 2022 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649252220; x=1680788220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZiYtCewVoMnuD9HBEc2prs7oXG1sMa5YDmnUqewHYuc=;
  b=kL7e0vPoeLy7UcfluqY24vYc+X42Ph85Mwpwu8BoyIUw4PLzHGCLev0B
   Z/VJLaHJ/Zc5SvwB5dh/WkEhVTXFTfqDxb8YW3OxQh42QznWYryQWKCMV
   w31EpaooGbMpdaSAeP9E7M+AxqSsHPOpM1t5GLBu8UwGoEGLOJys4wy/K
   ZKn8DujOgd4ab6in8Glshj5X0AQpeJDrc6jsCxVyCyJ/VCVR21uO86+2E
   mVuLMj+skDmA4Zd6sPJ/rGZCluqku6WKXRnnqz7lfhBy1kKqDR/aD+7LE
   x2UeXBSmP8dv8e3N651RVPWWHN7UO3JdT/OT0cQ+PQbyLbWYRtdwO3yGf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241630778"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="241630778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:36:59 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="523926538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:36:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nc5oi-000Ee5-UH;
        Wed, 06 Apr 2022 16:35:24 +0300
Date:   Wed, 6 Apr 2022 16:35:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     djrscally@gmail.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nuno.sa@analog.com, rafael@kernel.org,
        sakari.ailus@linux.intel.com, Russell King <linux@armlinux.org.uk>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH v4 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
Message-ID: <Yk2XHJccym/DpU4i@smile.fi.intel.com>
References: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com>
 <20220314195138.20036-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314195138.20036-1-michael@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 14, 2022 at 08:51:37PM +0100, Michael Walle wrote:

> This breaks SFP/phylink (using the lan966x switch) on my board. See below
> for more details.

I have just sent v5 (it's now a series of patches where the first one is
the fixed version of this patch), please (re-)test.

-- 
With Best Regards,
Andy Shevchenko


