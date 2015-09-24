From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] acpi-dma: Add support for "dma-names" device property
Date: Thu, 24 Sep 2015 21:05:28 +0530
Message-ID: <20150924153528.GB2381@localhost>
References: <1442241456-75340-1-git-send-email-mika.westerberg@linux.intel.com>
 <1442241456-75340-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46925 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122AbbIXPcp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Sep 2015 11:32:45 -0400
Content-Disposition: inline
In-Reply-To: <1442241456-75340-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dan Williams <dan.j.williams@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 14, 2015 at 05:37:36PM +0300, Mika Westerberg wrote:
> The current implementation hard codes the two supported channels so that
> "tx" is always 0 and "rx" is always 1. This is because there has been no
> suitable way in ACPI to name resources.
> 
> With _DSD device properties we can finally do this:
> 
> 	Device (SPI1) {
> 	    Name (_CRS, ResourceTemplate () {
> 	        ...
> 	        FixedDMA (0x0000, 0x0000, Width32bit)
> 	        FixedDMA (0x0001, 0x0001, Width32bit)
> 	    })
> 
> 	    Name (_DSD, Package () {
> 	        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 	        Package () {
> 	            Package () {"dma-names", Package () {"tx", "rx"}}
> 	        },
> 	    })
> 	}
> 
> The names "tx" and "rx" now provide index of the FixedDMA resource in
> question.
> 
> Modify acpi_dma_request_slave_chan_by_name() so that it looks for
> "dma-names" property first and only then fall back using hardcoded indices.
> 
> The DT "dma-names" binding that we reuse for ACPI is documented in
> Documentation/devicetree/bindings/dma/dma.txt.

Acked-by: Vinod Koul <vinod.koul@intel.com>

This is actually good and will help a lot. Btw would like to see some
tested-by tags, perhaps on dw dma or idma...

-- 
~Vinod
