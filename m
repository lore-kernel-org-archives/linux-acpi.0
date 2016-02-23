From: Leif Liddy <leif.linux@gmail.com>
Subject: Re: ACPI SPI slave device
Date: Tue, 23 Feb 2016 21:30:40 +0100
Message-ID: <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
	<20160223073819.GK1770@lahna.fi.intel.com>
	<CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
	<20160223150222.GL1770@lahna.fi.intel.com>
	<20160223153240.GM1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33349 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbcBWUak (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2016 15:30:40 -0500
Received: by mail-io0-f173.google.com with SMTP id z135so1026130iof.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Feb 2016 12:30:40 -0800 (PST)
In-Reply-To: <20160223153240.GM1770@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

I'm beginning to understand how this is meant to work.

spi_pxa2xx_platform should by itself be able to setup the SPI controller.
**it has the ACPI ID for it
{ "INT33C1", LPSS_LPT_SSP }

When I modprobe spi_pxa2xx_platform
pxa2xx_spi_probe never gets called, there must be an issue with:
acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match)


Ok, so I've installed Ismo's one line patch

dmesg log of "modprobe spi_pxa2xx_pci"

pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan0)
pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
dmaengine: private_candidate: dma0chan0 busy
dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan1)


without the patch:

dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan0)
dmaengine: private_candidate: dma0chan0 busy
dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan1)

On Tue, Feb 23, 2016 at 4:32 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Feb 23, 2016 at 05:02:22PM +0200, Mika Westerberg wrote:
>> > Upstream-status: Inappropriate, real fix forthcoming"
>>
>> I believe passing the ACPI handle to the platform device is the real
>> fix.
>
> That said, I remember discussing this with Ismo (author of the patch you
> are trying out) and the real fix probably means that we do the same for
> SPI that we already did for I2C - scan all devices for SpiSerialBus()
> connections to the SPI master we just registered, not just the immediate
> children.
