From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] spi / ACPI: add ACPI enumeration support
Date: Wed, 7 Nov 2012 15:05:48 +0200
Message-ID: <20121107130548.GZ24532@intel.com>
References: <1351928793-14375-1-git-send-email-mika.westerberg@linux.intel.com>
 <2584820.Vd5p0uzRAK@vostro.rjw.lan>
 <20121107095842.GY24532@intel.com>
 <1493573.krE1QVlUux@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1394 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab2KGNDa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 08:03:30 -0500
Content-Disposition: inline
In-Reply-To: <1493573.krE1QVlUux@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, lenb@kernel.org, rafael.j.wysocki@intel.com, broonie@opensource.wolfsonmicro.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, mathias.nyman@linux.intel.com, linux-acpi@vger.kernel.org

On Wed, Nov 07, 2012 at 12:14:31PM +0100, Rafael J. Wysocki wrote:
> > So is the idea now that the ACPI core parses the resources and passes them
> > forward via struct acpi_device? I'm just wondering how to proceed with
> > these I2C and SPI enumeration patches.
> 
> Well, we definitely don't want to duplicate what drivers/pnp/pnpacpi/rsparser.c
> does, so the idea is to move the code from there to the core in such a way that
> both the SPI/I2C patches and the PNP layer can use it.

Ok.

> I'll have some prototype code ready shortly, hopefully, and I'll post it
> in that form for comments (and so that you know what to expect).

Sounds good. Thanks!
