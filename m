From: Ken Xue <Ken.Xue@amd.com>
Subject: Re: [PATCH V2] acpi:apd:add AMD ACPI2Platform device support for
 x86 system.
Date: Tue, 3 Feb 2015 09:04:55 +0800
Message-ID: <1422925495.2528.12.camel@kxue-X58A-UD3R>
References: <1422870652.2528.6.camel@kxue-X58A-UD3R>
	 <20150202130356.GS22740@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1bn0101.outbound.protection.outlook.com ([157.56.110.101]:47117
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932612AbbBCBsW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Feb 2015 20:48:22 -0500
In-Reply-To: <20150202130356.GS22740@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-02-02 at 15:03 +0200, mika.westerberg@linux.intel.com
wrote:
> On Mon, Feb 02, 2015 at 05:50:52PM +0800, Ken Xue wrote:
> > >From b9654ecbfaebde00aee746a024eec9fe8de24b97 Mon Sep 17 00:00:00 2001
> > From: Ken Xue <Ken.Xue@amd.com>
> > Date: Mon, 2 Feb 2015 17:32:24 +0800
> > Subject: [PATCH] This new feature is to interpret AMD specific ACPI device to
> >  platform device such as I2C, UART found on AMD CZ and later chipsets. It
> >  based on example INTEL LPSS. Now, it can support AMD I2C & UART.
> 
> Looks good to me. There are few smallish issues still, see below.
> 
...

> > +	switch (action) {
> > +	case BUS_NOTIFY_ADD_DEVICE:
> > +		if (pdata->dev_desc->flags & ACPI_APD_PM) {
> > +			if (pdata->dev_desc->flags & ACPI_APD_PM_ON)
> > +				ret = dev_pm_domain_attach(&pdev->dev, true);
> > +			else
> > +				ret = dev_pm_domain_attach(&pdev->dev, false);
> 
> How about:
> 
> 	power_on = !!(pdata->dev_desc->flags & ACPI_APD_PM_ON)
> 	ret = dev_pm_domain_attach(&pdev->dev, power_on);
> 
> ?
good 

> 
> Furthermore I think this is not needed at all. If you check
> platform_drv_probe() it calls dev_pm_domain_attach() already.
> 
as you said, platform_drv_probe calls dev_pm_domain_attach(). but
platform_drv_probe just is a default probe routine. Not all platform
device drivers use this probe routine. so, codes here may be still
necessary.



