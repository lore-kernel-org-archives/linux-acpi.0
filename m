From: Leif Liddy <leif.linux@gmail.com>
Subject: Re: ACPI SPI slave device
Date: Tue, 1 Mar 2016 16:42:18 +0100
Message-ID: <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
	<20160223073819.GK1770@lahna.fi.intel.com>
	<CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
	<20160223150222.GL1770@lahna.fi.intel.com>
	<20160223153240.GM1770@lahna.fi.intel.com>
	<CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
	<20160229082114.GC1770@lahna.fi.intel.com>
	<CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35816 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbcCAPmT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 10:42:19 -0500
Received: by mail-ig0-f169.google.com with SMTP id hb3so20608488igb.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Mar 2016 07:42:19 -0800 (PST)
In-Reply-To: <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

With Ismo's patch applied, I added a few printk statements to spi.c
and resource.c (the lines beginning with xxx).

modprobe pxa2xx-spi-pci


pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
xxx resource.c acpi_dev_get_resources acpi_handle is ffff8802650bdcd0
returns c.count 0...
dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan0)
pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
xxx resource.c acpi_dev_get_resources acpi_handle is ffff8802650bdcd0
returns c.count 0...
dmaengine: private_candidate: dma0chan0 busy
dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
dmaengine: __dma_request_channel: success (dma0chan1)
pxa2xx-spi pxa2xx-spi.0: registered master spi0
xxx spi.c acpi_register_spi_devices acpi_handle is ffff8802650bdcd0
xxx resource.c acpi_dev_get_resources acpi_handle is ffff8802650bf000
returns c.count 0...


I believe these acpi handle values correspond to:
ffff8802650bdcd0 = INT33C1/SPI controller
ffff8802650bf000 = APP000D/SPI slave

spi.c did find the slave device, as this statement was not evaluated:

     if (ACPI_FAILURE(status))
             dev_warn(&master->dev, "failed to enumerate SPI slaves\n");

However, the slave device is never enumerated.

Do you know how I could print out the the name or id of the ACPI
device from the acpi_device pointer?
**I'm struggling a bit with some of these data types

I'll continue to debug this issue a bit more...

On Mon, Feb 29, 2016 at 6:21 PM, Leif Liddy <leif.linux@gmail.com> wrote:
> I debugged acpi_lpss.c as it attempted to created a platform device for INT33C1.
>
> I got as far as this function in resouce.c
> status = acpi_walk_resources(adev->handle, METHOD_NAME__CRS,
> acpi_dev_process_resource, &c);
>
> the value of c never gets incremented --and returns 0.
>
> I'm not sure how closely apcia follows the logic of these tables and
> whether the OSI value is actually checked or not.
> If WBUF is being returned,  then that would be the source of the issue.
>
>
> Device (SDMA)
>      {
>         Name (_ADR, 0x00150000)  // _ADR: Address
>         Name (_UID, 0x01)  // _UID: Unique ID
>         Name (RBUF, ResourceTemplate ()
>         ...
>         Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>         {
>              Return (RBUF) /* \_SB_.PCI0.SDMA.RBUF */
>         }
>         ...
> Device (SPI1)
>     {
>        Name (_ADR, 0x00150004)  // _ADR: Address
>        Name (_CID, "INT33C1" /* Intel Serial I/O SPI Host Controller */)
>         ..
>        Name (WBUF, ResourceTemplate ()
>        {
>        })
>        Name (DBUF, ResourceTemplate ()
>        {
>             FixedDMA (0x0010, 0x0006, Width32bit, )
>             FixedDMA (0x0011, 0x0007, Width32bit, )
>        })
>       Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>       {
>           If (!OSDW ())
>           {
>               Return (WBUF) /* \_SB_.PCI0.SPI1.WBUF */
>           }
>
>               Return (ConcatenateResTemplate (RBUF, DBUF))
>           }
>      }
>         ......
>
>
> In any case, it sounds like the best approach is just to go with the
> spi-pxa2xx-pci driver.
>
>>>I believe passing the ACPI handle to the platform device is the real
>>fix.
>
> Ok, I understand what this means now --and I know what the acpi handle
> is for INT33C1.
> I'm going to try and modify spi.c to use this acpi handle --and
> hopefully it will find the SPI slave device.
>
> handle = ACPI_HANDLE(master->dev.parent);
>
> status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>                                      acpi_spi_add_device, NULL,
>                                      master, NULL);
>
> On Mon, Feb 29, 2016 at 9:21 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
>> On Tue, Feb 23, 2016 at 09:30:40PM +0100, Leif Liddy wrote:
>>> I'm beginning to understand how this is meant to work.
>>>
>>> spi_pxa2xx_platform should by itself be able to setup the SPI controller.
>>> **it has the ACPI ID for it
>>> { "INT33C1", LPSS_LPT_SSP }
>>>
>>> When I modprobe spi_pxa2xx_platform
>>> pxa2xx_spi_probe never gets called, there must be an issue with:
>>> acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match)
>>
>> That's fine - the device is a PCI device and does not require ACPI ID.
>> However, the PCI part of the driver creates this platform device for
>> spi_pxa2xx_platform.
>>
>>> Ok, so I've installed Ismo's one line patch
>>>
>>> dmesg log of "modprobe spi_pxa2xx_pci"
>>>
>>> pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
>>> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
>>> dmaengine: __dma_request_channel: success (dma0chan0)
>>> pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
>>> dmaengine: private_candidate: dma0chan0 busy
>>> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
>>> dmaengine: __dma_request_channel: success (dma0chan1)
>>
>> Difference is that with Ismo's patch you actually have ACPI handle for
>> the device so it tries to use ACPI to look for the DMA channels.
>>
>>> without the patch:
>>>
>>> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
>>> dmaengine: __dma_request_channel: success (dma0chan0)
>>> dmaengine: private_candidate: dma0chan0 busy
>>> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
>>> dmaengine: __dma_request_channel: success (dma0chan1)
>>
>> Here it uses hardcoded indices instead. In both cases result is the
>> same.
