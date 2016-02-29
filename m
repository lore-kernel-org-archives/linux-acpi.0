From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI SPI slave device
Date: Mon, 29 Feb 2016 10:21:14 +0200
Message-ID: <20160229082114.GC1770@lahna.fi.intel.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
 <20160223073819.GK1770@lahna.fi.intel.com>
 <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
 <20160223150222.GL1770@lahna.fi.intel.com>
 <20160223153240.GM1770@lahna.fi.intel.com>
 <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52463 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbcB2IVf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Feb 2016 03:21:35 -0500
Content-Disposition: inline
In-Reply-To: <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

On Tue, Feb 23, 2016 at 09:30:40PM +0100, Leif Liddy wrote:
> I'm beginning to understand how this is meant to work.
> 
> spi_pxa2xx_platform should by itself be able to setup the SPI controller.
> **it has the ACPI ID for it
> { "INT33C1", LPSS_LPT_SSP }
> 
> When I modprobe spi_pxa2xx_platform
> pxa2xx_spi_probe never gets called, there must be an issue with:
> acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match)

That's fine - the device is a PCI device and does not require ACPI ID.
However, the PCI part of the driver creates this platform device for
spi_pxa2xx_platform.

> Ok, so I've installed Ismo's one line patch
> 
> dmesg log of "modprobe spi_pxa2xx_pci"
> 
> pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan0)
> pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
> dmaengine: private_candidate: dma0chan0 busy
> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan1)

Difference is that with Ismo's patch you actually have ACPI handle for
the device so it tries to use ACPI to look for the DMA channels.

> without the patch:
> 
> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan0)
> dmaengine: private_candidate: dma0chan0 busy
> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan1)

Here it uses hardcoded indices instead. In both cases result is the
same.
