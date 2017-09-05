From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: Add support for Cherry Trail Dollar Cove TI
 PMIC
Date: Tue, 5 Sep 2017 09:14:52 +0100
Message-ID: <20170905081452.buvwvwyeudqdsd5h@dell>
References: <20170824081141.5018-1-tiwai@suse.de>
 <20170824081141.5018-2-tiwai@suse.de>
 <20170904133732.ll6cmuvnxja242gi@dell>
 <s5h1snmr2rp.wl-tiwai@suse.de>
 <20170905072553.cffjdmlxamop4c5r@dell>
 <s5ho9qptwvy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38745 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdIEIOz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2017 04:14:55 -0400
Received: by mail-wr0-f178.google.com with SMTP id 108so6768427wra.5
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2017 01:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5ho9qptwvy.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, Johannes Stezenbach <js@sig21.net>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 05 Sep 2017, Takashi Iwai wrote:

> On Tue, 05 Sep 2017 09:25:53 +0200,
> Lee Jones wrote:
> > 
> > On Mon, 04 Sep 2017, Takashi Iwai wrote:
> > 
> > > On Mon, 04 Sep 2017 15:37:32 +0200,
> > > Lee Jones wrote:
> > > > 
> > > > > +static struct mfd_cell dc_ti_dev[] = {
> > > > > +	{
> > > > > +		.name = "dc_ti_pwrbtn",
> > > > > +		.num_resources = ARRAY_SIZE(power_button_resources),
> > > > > +		.resources = power_button_resources,
> > > > > +	},
> > > > > +	{
> > > > 
> > > > Place these on the same line.
> > > 
> > > Does this and ...
> > > 
> > > 
> > > > > +	},
> > > > > +	{
> > > > > +		.name = "dc_ti_region",
> > > > > +	},
> > > > 
> > > > This should be a one line entry:
> > > > 
> > > > 	{ .name = "dc_ti_region" },
> > > 
> > > .... this match together?  The result would be like:
> > > 
> > > static struct mfd_cell dc_ti_dev[] = {
> > > 	{
> > > 		.name = "dc_ti_pwrbtn",
> > > 		.num_resources = ARRAY_SIZE(power_button_resources),
> > > 		.resources = power_button_resources,
> > > 	}, {
> > > 		.name = "chtdc_ti_adc",
> > > 		.num_resources = ARRAY_SIZE(adc_resources),
> > > 	.....
> > > 	}, {	.name = "chtdc_ti_region",	},
> > > };
> > > 
> > > which I find a bit inconsistent.
> > 
> > No, it doesn't.
> 
> Heh, I find such a mixture annoying, but it's a matter of taste.

Coding style is always a matter of taste. :)

> > The single lines need to be on their own.
> 
> So did I already in the v5 patch submitted yesterday.

I saw it, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
