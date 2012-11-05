From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Mon, 5 Nov 2012 13:03:22 +0200
Message-ID: <20121105110322.GD24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <1351928793-14375-3-git-send-email-mika.westerberg@linux.intel.com>
 <20121105105455.GD1385@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36108 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886Ab2KELBD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Nov 2012 06:01:03 -0500
Content-Disposition: inline
In-Reply-To: <20121105105455.GD1385@opensource.wolfsonmicro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Mon, Nov 05, 2012 at 11:54:55AM +0100, Mark Brown wrote:
> On Sat, Nov 03, 2012 at 09:46:32AM +0200, Mika Westerberg wrote:
> 
> > +	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
> > +	if (info.gsi >= 0)
> > +		spi->irq = acpi_register_gsi(&adev->dev, info.gsi,
> > +					     info.triggering, info.polarity);
> > +	request_module(spi->modalias);
> 
> request_module()?  Why?

The DT code does the same. I have no idea why it is there, really :-)

I can remove it in the next version if you think it is not needed.
