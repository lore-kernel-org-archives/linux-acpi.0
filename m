From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi-dma: Add support for "dma-names" device property
Date: Fri, 25 Sep 2015 02:29:55 +0200
Message-ID: <1484799.EJckEmIlYa@vostro.rjw.lan>
References: <1442241456-75340-1-git-send-email-mika.westerberg@linux.intel.com> <1442241456-75340-2-git-send-email-mika.westerberg@linux.intel.com> <20150924153528.GB2381@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54762 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751723AbbIYABm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Sep 2015 20:01:42 -0400
In-Reply-To: <20150924153528.GB2381@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, September 24, 2015 09:05:28 PM Vinod Koul wrote:
> On Mon, Sep 14, 2015 at 05:37:36PM +0300, Mika Westerberg wrote:
> > The current implementation hard codes the two supported channels so that
> > "tx" is always 0 and "rx" is always 1. This is because there has been no
> > suitable way in ACPI to name resources.
> > 
> > With _DSD device properties we can finally do this:
> > 
> > 	Device (SPI1) {
> > 	    Name (_CRS, ResourceTemplate () {
> > 	        ...
> > 	        FixedDMA (0x0000, 0x0000, Width32bit)
> > 	        FixedDMA (0x0001, 0x0001, Width32bit)
> > 	    })
> > 
> > 	    Name (_DSD, Package () {
> > 	        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > 	        Package () {
> > 	            Package () {"dma-names", Package () {"tx", "rx"}}
> > 	        },
> > 	    })
> > 	}
> > 
> > The names "tx" and "rx" now provide index of the FixedDMA resource in
> > question.
> > 
> > Modify acpi_dma_request_slave_chan_by_name() so that it looks for
> > "dma-names" property first and only then fall back using hardcoded indices.
> > 
> > The DT "dma-names" binding that we reuse for ACPI is documented in
> > Documentation/devicetree/bindings/dma/dma.txt.
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> This is actually good and will help a lot.

Thanks!

Added [1/2] and this one to my device-properties branch.

Thanks,
Rafael

