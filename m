Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D923CC43334
	for <linux-acpi@archiver.kernel.org>; Tue, 28 Jun 2022 10:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbiF1KYv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiF1KYr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 06:24:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749531200;
        Tue, 28 Jun 2022 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656411887; x=1687947887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xlq0heybwteppeO6xSJNvQp8iMqjAGgxIhiwFvhtCz0=;
  b=I/rBr/V0B9pcZD3lhqNQtVWNLvVnj6pZZuQWv+JsKL0cpwLgKA7clPiM
   W/lSzEqIaRAzuqU3YXqDiK4HuHSvGmEIzbHt1hbJKi5ft+/bBvTS4k86e
   zwaVeZwtu0xrLaHE7m0Abp0r6FxMCfhiF1wi5fts6fHEiNlQDHjW5FDjN
   d+odadSiusdENvTQPYThPS67++PaNZB+PP8rBq/+eiksVq48XIhhd93as
   vtaJbKy6k3q6NQS+Dqeop+d/xKlIdXr/hg2SAp/3GyaPQshGiJupkZ5HR
   uG3+IdRyxx0SiW2QI3Kc/h1+9w07tz2rwC3q9vqIW31RXrRB5eZVWcoZ3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307182935"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307182935"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="693054369"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:24:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o68OX-000whm-PK;
        Tue, 28 Jun 2022 13:24:33 +0300
Date:   Tue, 28 Jun 2022 13:24:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: Re: [PATCH 1/7] ACPI: video: Change how we determine if brightness
 key-presses are handled
Message-ID: <YrrW4V+plHWUtgiH@smile.fi.intel.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
 <20220624112340.10130-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624112340.10130-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 24, 2022 at 01:23:34PM +0200, Hans de Goede wrote:
> Some systems have an ACPI video bus but not ACPI video devices with
> backlight capability. On these devices brightness key-presses are
> (logically) not reported through the ACPI video bus.
> 
> Change how acpi_video_handles_brightness_key_presses() determines if
> brightness key-presses are handled by the ACPI video driver to avoid
> vendor specific drivers/platform/x86 drivers filtering out their
> brightness key-presses even though they are the only ones reporting
> these presses.

...

> -	return have_video_busses &&
> +	return has_backlight &&
>  	       (report_key_events & REPORT_BRIGHTNESS_KEY_EVENTS);

I would combine on one line.

-- 
With Best Regards,
Andy Shevchenko


