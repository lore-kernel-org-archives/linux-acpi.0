From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] ACPI / LPSS: Ignore 10ms delay for Braswell and Baytrail
Date: Fri, 21 Aug 2015 17:41:52 +0530
Message-ID: <20150821121152.GA26813@intel-desktop>
References: <1440090968-17728-1-git-send-email-srinidhi.kasagar@intel.com>
 <20150820123805.GG30005@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43706 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbbHUEUo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Aug 2015 00:20:44 -0400
Content-Disposition: inline
In-Reply-To: <20150820123805.GG30005@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, Kumar P Mahesh <mahesh.kumar.p@intel.com>, Heikki Krogerus <heikki.krogerus@intel.com>

On Thu, Aug 20, 2015 at 03:38:05PM +0300, Mika Westerberg wrote:
> +Heikki
> 
> On Thu, Aug 20, 2015 at 10:46:07PM +0530, Srinidhi Kasagar wrote:
> > LPSS devices in Braswell and Baytrail does not need the default
> > 10ms d3_delay imposed by PCI specification. Removing this
> > unnecessary delay significantly reduces the resume time
> > (~200ms on Braswell/Cherrytrail) on these platforms.
> > 
> > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > Signed-off-by: Kumar P Mahesh <mahesh.kumar.p@intel.com>
> 
> Have you tested this on Asus T100? The delay was actually needed in
> order to restore the context IIRC.

Sorry, I do not have T100 h/w :(

> 
> Also you are saying Braswell and Baytrail but...
> 
> > ---
> >  drivers/acpi/acpi_lpss.c |   59 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 46 insertions(+), 13 deletions(-)
> > 

[...]

> > @@ -219,13 +247,13 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
> >  	{ "8086228E", LPSS_ADDR(bsw_spi_dev_desc) },
> >  	{ "808622C1", LPSS_ADDR(byt_i2c_dev_desc) },
> >  
> > -	{ "INT3430", LPSS_ADDR(lpt_dev_desc) },
> > -	{ "INT3431", LPSS_ADDR(lpt_dev_desc) },
> > -	{ "INT3432", LPSS_ADDR(lpt_i2c_dev_desc) },
> > -	{ "INT3433", LPSS_ADDR(lpt_i2c_dev_desc) },
> > -	{ "INT3434", LPSS_ADDR(lpt_uart_dev_desc) },
> > -	{ "INT3435", LPSS_ADDR(lpt_uart_dev_desc) },
> > -	{ "INT3436", LPSS_ADDR(lpt_sdio_dev_desc) },
> > +	{ "INT3430", LPSS_ADDR(bsw_lpt_dev_desc) },
> > +	{ "INT3431", LPSS_ADDR(bsw_lpt_dev_desc) },
> > +	{ "INT3432", LPSS_ADDR(bsw_lpt_i2c_dev_desc) },
> > +	{ "INT3433", LPSS_ADDR(bsw_lpt_i2c_dev_desc) },
> > +	{ "INT3434", LPSS_ADDR(bsw_lpt_uart_dev_desc) },
> > +	{ "INT3435", LPSS_ADDR(bsw_lpt_uart_dev_desc) },
> > +	{ "INT3436", LPSS_ADDR(bsw_lpt_sdio_dev_desc) },
> 
> ... these are Broadwell devices. Have you tested that this won't break
> existing Broadwell systems?

You mean these are Broadwell devices too? As of now I have
tested these devices to be working on Braswell and Cherrytrail.

Srinidhi
