Return-Path: <SRS0=PMQP=YO=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB5CA9EB5
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Oct 2019 09:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA622089C
	for <linux-acpi@archiver.kernel.org>; Mon, 21 Oct 2019 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfJUJI3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:08:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:8180 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfJUJI2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Oct 2019 05:08:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 02:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="397267172"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2019 02:08:26 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iMTfu-0001b1-0o; Mon, 21 Oct 2019 12:08:26 +0300
Date:   Mon, 21 Oct 2019 12:08:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 3/5] ACPI: button: Turn lid_blacklst dmi table into a
 generic quirk table
Message-ID: <20191021090826.GI32742@smile.fi.intel.com>
References: <20191018194115.93281-1-hdegoede@redhat.com>
 <20191018194115.93281-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018194115.93281-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 18, 2019 at 09:41:13PM +0200, Hans de Goede wrote:
> Commit 3540c32a9ae4 ("ACPI / button: Add quirks for initial lid state
> notification") added 3 different modes to the LID handling code to deal
> with various buggy implementations.
> 
> Until now users which need one of the 2 non-default modes to get their
> hw to work have to pass a kernel commandline option for this.
> 
> E.g. https://bugzilla.kernel.org/show_bug.cgi?id=106151 was closed with a
> note that the user has to add "button.lid_init_state=open" to the kernel
> commandline to get the LID code to not cause undesirable suspends on his
> Samsung N210 Plus.
> 
> This commit modifies the existing lid_blacklst dmi table so that it can
> be used not only to completely disable the LID code on devices where
> the ACPI tables are broken beyond repair, but also to select one of the 2
> non default LID handling modes on devices where this is necessary.
> 
> This will allow us to add quirks to make the LID work OOTB on broken
> devices. Getting this working OOTB is esp. important because the typical
> breakage is false LID closed reporting, causing undesirable suspends which
> basically make the system unusable.

> +static int lid_init_state = -1;

>  static int acpi_button_register_driver(struct acpi_driver *driver)
>  {
> +	const struct dmi_system_id *dmi_id;
> +
> +	if (lid_init_state == -1) {
> +		dmi_id = dmi_first_match(dmi_lid_quirks);
> +		if (dmi_id)

> +			lid_init_state = (long)dmi_id->driver_data;

I would rather see here (intptr_t), though up to you and Rafael.
Or mark a variable long itself?

> +		else
> +			lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;

Can't we simple default the value to this?

> +	}

-- 
With Best Regards,
Andy Shevchenko


