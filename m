From: Leif Liddy <leif.linux@gmail.com>
Subject: Re: ACPI SPI slave device
Date: Mon, 29 Feb 2016 18:21:20 +0100
Message-ID: <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
	<20160223073819.GK1770@lahna.fi.intel.com>
	<CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
	<20160223150222.GL1770@lahna.fi.intel.com>
	<20160223153240.GM1770@lahna.fi.intel.com>
	<CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
	<20160229082114.GC1770@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35920 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbcB2RVV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 12:21:21 -0500
Received: by mail-io0-f180.google.com with SMTP id l127so193462933iof.3
        for <linux-acpi@vger.kernel.org>; Mon, 29 Feb 2016 09:21:20 -0800 (PST)
In-Reply-To: <20160229082114.GC1770@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

I debugged acpi_lpss.c as it attempted to created a platform device for INT33C1.

I got as far as this function in resouce.c
status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
acpi_dev_process_resource, &c);

the value of c never gets incremented --and returns 0.

I'm not sure how closely apcia follows the logic of these tables and
whether the OSI value is actually checked or not.
If WBUF is being returned,  then that would be the source of the issue.


Device (SDMA)
     {
        Name (_ADR, 0x00150000)  // _ADR: Address
        Name (_UID, 0x01)  // _UID: Unique ID
        Name (RBUF, ResourceTemplate ()
        ...
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
             Return (RBUF) /* \_SB_.PCI0.SDMA.RBUF */
        }
        ...
Device (SPI1)
    {
       Name (_ADR, 0x00150004)  // _ADR: Address
       Name (_CID, "INT33C1" /* Intel Serial I/O SPI Host Controller */)
        ..
       Name (WBUF, ResourceTemplate ()
       {
       })
       Name (DBUF, ResourceTemplate ()
       {
            FixedDMA (0x0010, 0x0006, Width32bit, )
            FixedDMA (0x0011, 0x0007, Width32bit, )
       })
      Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
      {
          If (!OSDW ())
          {
              Return (WBUF) /* \_SB_.PCI0.SPI1.WBUF */
          }

              Return (ConcatenateResTemplate (RBUF, DBUF))
          }
     }
        ......


In any case, it sounds like the best approach is just to go with the
spi-pxa2xx-pci driver.

>>I believe passing the ACPI handle to the platform device is the real
>fix.

Ok, I understand what this means now --and I know what the acpi handle
is for INT33C1.
I'm going to try and modify spi.c to use this acpi handle --and
hopefully it will find the SPI slave device.

handle = ACPI_HANDLE(master->dev.parent);

status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
                                     acpi_spi_add_device, NULL,
                                     master, NULL);

On Mon, Feb 29, 2016 at 9:21 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Feb 23, 2016 at 09:30:40PM +0100, Leif Liddy wrote:
>> I'm beginning to understand how this is meant to work.
>>
>> spi_pxa2xx_platform should by itself be able to setup the SPI controller.
>> **it has the ACPI ID for it
>> { "INT33C1", LPSS_LPT_SSP }
>>
>> When I modprobe spi_pxa2xx_platform
>> pxa2xx_spi_probe never gets called, there must be an issue with:
>> acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match)
>
> That's fine - the device is a PCI device and does not require ACPI ID.
> However, the PCI part of the driver creates this platform device for
> spi_pxa2xx_platform.
>
>> Ok, so I've installed Ismo's one line patch
>>
>> dmesg log of "modprobe spi_pxa2xx_pci"
>>
>> pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
>> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
>> dmaengine: __dma_request_channel: success (dma0chan0)
>> pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
>> dmaengine: private_candidate: dma0chan0 busy
>> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
>> dmaengine: __dma_request_channel: success (dma0chan1)
>
> Difference is that with Ismo's patch you actually have ACPI handle for
> the device so it tries to use ACPI to look for the DMA channels.
>
>> without the patch:
>>
>> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
>> dmaengine: __dma_request_channel: success (dma0chan0)
>> dmaengine: private_candidate: dma0chan0 busy
>> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
>> dmaengine: __dma_request_channel: success (dma0chan1)
>
> Here it uses hardcoded indices instead. In both cases result is the
> same.
