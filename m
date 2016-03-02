From: Leif Liddy <leif.linux@gmail.com>
Subject: Re: ACPI SPI slave device
Date: Wed, 2 Mar 2016 04:13:16 +0100
Message-ID: <CAAbRKOsNxsu4CYq=EByck997RWRO3fQ-+LAAS5AbSL3XNRSh7A@mail.gmail.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
	<20160223073819.GK1770@lahna.fi.intel.com>
	<CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
	<20160223150222.GL1770@lahna.fi.intel.com>
	<20160223153240.GM1770@lahna.fi.intel.com>
	<CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
	<20160229082114.GC1770@lahna.fi.intel.com>
	<CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
	<CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
	<20160301160726.GA23371@wunner.de>
	<CAAbRKOuESP+_65cmeCPNtO5HzN1+ct7bDv1stbE+a8u=KEwDKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36449 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbcCBDNR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 22:13:17 -0500
Received: by mail-io0-f173.google.com with SMTP id l127so245765572iof.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Mar 2016 19:13:17 -0800 (PST)
In-Reply-To: <CAAbRKOuESP+_65cmeCPNtO5HzN1+ct7bDv1stbE+a8u=KEwDKw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

 I finally got the SPI slave enumerated....by modifying the DSDT table

P: /devices/pci0000:00/0000:00:15.4/pxa2xx-spi.0/spi_master/spi0/spi-APP000D:00
E: DEVPATH=/devices/pci0000:00/0000:00:15.4/pxa2xx-spi.0/spi_master/spi0/spi-APP000D:00
E: ID_VENDOR_FROM_DATABASE=Apple Computer Inc
E: MODALIAS=acpi:APP000D:APPLE-SPI-TOPCASE:
E: SUBSYSTEM=spi
E: USEC_INITIALIZED=27944872

/proc/acpi/wakeup
Device S-state  Status   Sysfs node
SPIT  S3 *disabled   spi:spi-APP000D:00

I'll post more tomorrow, need to evaluate the changes I made --but I
think the change that did it was changing this:

Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
    If (!OSDW ())
    {
        Return (WBUF) /* \_SB_.PCI0.SPI1.WBUF */
    }

    Return (ConcatenateResTemplate (RBUF, DBUF))
}

to:

Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
{
      Return (ConcatenateResTemplate (RBUF, DBUF))
}

On Wed, Mar 2, 2016 at 12:33 AM, Leif Liddy <leif.linux@gmail.com> wrote:
> Thanks for that!!!
>
> Ok, I added a few more printk statments to spi.c. It looks like the
> root cause of the issue is that the
> "ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS" check is failing.
>
> pxa2xx-spi pxa2xx-spi.0: found DMA channel "tx" at index 0
> xxx resource.c acpi_dev_get_resources acpi_dev_name=INT33C1:00 returns
> c.count 0...
> dma dma0chan0: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan0)
> pxa2xx-spi pxa2xx-spi.0: found DMA channel "rx" at index 1
> xxx resource.c acpi_dev_get_resources acpi_dev_name=INT33C1:00 returns
> c.count 0...
> dmaengine: private_candidate: dma0chan0 busy
> dma dma0chan1: dwc_alloc_chan_resources: allocated 64 descriptors
> dmaengine: __dma_request_channel: success (dma0chan1)
> pxa2xx-spi pxa2xx-spi.0: registered master spi0
> xxx spi.c acpi_register_spi_devices acpi_handle is ffff8802650bdcd0 (INT33C1:00)
> xxx spi.c acpi_spi_add_device() start
> xxx spi.c *spi_alloc_device() start
> xxx spi.c acpi_spi_add_device acpi_dev_name=APP000D:00
> xxx spi.c acpi_spi_add_resource() start
> xxx spi.c acpi_spi_add_resource spi->irq = -1
> xxx spi.c acpi_spi_add_resource failed check: ares->type ==
> ACPI_RESOURCE_TYPE_SERIAL_BUS
> xxx spi.c acpi_spi_add_resource :else if (spi->irq < 0)
> xxx spi.c acpi_spi_add_resource return 1
> xxx resource.c acpi_dev_get_resources acpi_dev_name=APP000D:00 returns
> c.count 0...
> xxx spi.c acpi_spi_add_device ret returns 0
> xxx spi.c acpi_spi_add_device spi->max_speed_hz is 0
> xxx spi.c acpi_spi_add_device  (ret < 0 || !spi->max_speed_hz) --->
> spi_dev_put(spi) --> return AE_OK
>
>
> I assume it's looking for SpiSerialBus in  the _CRS method,  not sure
> why it can't find it. I wonder if there's a way to just manually
> configure the slave device.
>
>
>  Device (SPIT)
>    {
>      Name (_HID, EisaId ("APP000D"))  // _HID: Hardware ID
>      .....
>
>     Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
>     {
>         Name (UBUF, ResourceTemplate ()
>         {
>             SpiSerialBus (0x0000, PolarityLow, FourWireMode, 0x08,
>                 ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                 ClockPhaseFirst, "\\_SB.PCI0.SPI1",
>                 0x00, ResourceConsumer, ,
>                 )
>             Interrupt (ResourceConsumer, Level, ActiveLow, Exclusive, ,, )
>             {
>                 0x0000001E,
>             }
>         })
>         Name (ABUF, ResourceTemplate ()
>         {
>         })
>         If (!OSDW ())
>         {
>             Return (UBUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.UBUF */
>         }
>
>        Return (ABUF) /* \_SB_.PCI0.SPI1.SPIT._CRS.ABUF */
>    }
>
> On Tue, Mar 1, 2016 at 5:07 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> Hi Leif,
>>
>> On Tue, Mar 01, 2016 at 04:42:18PM +0100, Leif Liddy wrote:
>>> Do you know how I could print out the the name or id of the ACPI
>>> device from the acpi_device pointer?
>>
>> printk("acpi_dev_name=%s\n", acpi_dev_name(adev));
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/acpi.h#n83
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/acpi/acpi_bus.h#n354
>>
>> Best regards,
>>
>> Lukas
