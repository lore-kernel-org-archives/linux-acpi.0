From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Wed, 7 Nov 2012 11:58:42 +0200
Message-ID: <20121107095842.GY24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <CAErSpo44pWUJmRAP6eR9T+2WvO5hJPFOC=Nn-WPXDtCY0v0EDw@mail.gmail.com>
 <1996776.cC14CHafyR@vostro.rjw.lan>
 <2584820.Vd5p0uzRAK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17676 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab2KGJ4f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 04:56:35 -0500
Content-Disposition: inline
In-Reply-To: <2584820.Vd5p0uzRAK@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Tue, Nov 06, 2012 at 11:36:08PM +0100, Rafael J. Wysocki wrote:
> > 
> > OK, but then we need to pass the information obtained from _CRS
> > (presumably after some adjustments through _SRS) to drivers, or rather to
> > things like the SPI core, I2C core etc. so that they can create device
> > objects for drivers to bind to and quite frankly I don't see why not to use
> > ACPI resources for that.
> 
> Nevertheless, the routines for parsing those resources should belong
> to the ACPI core, mostly to avoid code duplication.

Rafael,

So is the idea now that the ACPI core parses the resources and passes them
forward via struct acpi_device? I'm just wondering how to proceed with
these I2C and SPI enumeration patches.

Thanks.
