From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Thu, 27 Aug 2015 10:14:14 +0300
Message-ID: <20150827071414.GB28428@lahna.fi.intel.com>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
 <20150820123805.GG30005@lahna.fi.intel.com>
 <20150821121152.GA26813@intel-desktop>
 <20150821063641.GK30005@lahna.fi.intel.com>
 <20150821132015.GN30005@lahna.fi.intel.com>
 <20150824125147.GA23677@intel-desktop>
 <20150824085959.GO30005@lahna.fi.intel.com>
 <20150824170920.GA32764@intel-desktop>
 <20150824094455.GP30005@lahna.fi.intel.com>
 <20150827143953.GA5095@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:14144 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbbH0HQp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Aug 2015 03:16:45 -0400
Content-Disposition: inline
In-Reply-To: <20150827143953.GA5095@intel-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Thu, Aug 27, 2015 at 08:09:55PM +0530, Kasagar, Srinidhi wrote:
> On Mon, Aug 24, 2015 at 12:44:55PM +0300, Mika Westerberg wrote:
> > On Mon, Aug 24, 2015 at 10:39:21PM +0530, Kasagar, Srinidhi wrote:
> > > Ok, then we have two options:
> > > 
> > > Let's drop LPSS_NO_D3_DELAY for BYT and duplicate the common devices which
> > > are shared between Braswell and BYT & keep LPSS_NO_D3_DELAY only for BSW.
> > 
> > That sounds the safest option for now.
> > 
> > > OR
> > > Use the cpu id to detect the platform which I believe not a good idea..
> > > 
> > > Because of few devices, I do not think it make sense to compromise on
> > > the significant reduction in the resume delay.
> > 
> > I agree.
> 
> Refreshed the patch (below) affecting BSW platform alone.
> 
> But this does not solve your earlier concern on Broadwell which
> shares the same acpi ids..

It does not share IDs:

        /* Braswell LPSS devices */
        { "80862288", LPSS_ADDR(byt_pwm_dev_desc) },
        { "8086228A", LPSS_ADDR(byt_uart_dev_desc) },
        { "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
        { "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },

	/* The following are Broadwell LPSS IDs _not_ Braswell */
        { "INT3430", LPSS_ADDR(lpt_dev_desc) },
        { "INT3431", LPSS_ADDR(lpt_dev_desc) },
        { "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
        { "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
        { "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
        { "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
        { "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
        { "INT3437", },

So please make the patch touch only the four 808622* devices above
unless you have tested this on Broadwell as well.

Otherwise the patch looks good to me.
