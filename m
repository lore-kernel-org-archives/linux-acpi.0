From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: Fwd: ASoC : WM5102 Audio Codec needs ACPI support and a
	baytrail machine driver
Date: Wed, 24 Jun 2015 09:48:12 +0100
Message-ID: <20150624084812.GC6321@opensource.wolfsonmicro.com>
References: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com> <CAKor6TeP2HfqpHiKK86GLYLpCNk87y66bdjye_mAqXuMXxPMWA@mail.gmail.com> <CAKor6Tdg5yHaLVrCrWFVuydVcYUUtYr=oSj+k37Yd9O64+tg6A@mail.gmail.com> <20150616144732.GN32730@opensource.wolfsonmicro.com> <CAKor6TcfpAhzWeJdoyzwEG79BLvx-9jhunbaYdE5GUTH4k7qVg@mail.gmail.com> <20150622120020.GB32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38714 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752102AbbFXIsP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2015 04:48:15 -0400
Content-Disposition: inline
In-Reply-To: <20150622120020.GB32730@opensource.wolfsonmicro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Hartmann <cornogle@googlemail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, patches@opensource.wolfsonmicro.com

On Mon, Jun 22, 2015 at 01:00:20PM +0100, Charles Keepax wrote:
> On Mon, Jun 22, 2015 at 11:55:13AM +0200, Christian Hartmann wrote:
> > hi list,
> > 
> > FYI - I have some local patches (currently not ready to sent && merge) but
> > want to let you know about the new status:
> > 
> > the init messages I have now from the arizona-spi for the audio codec
> > WM5102  in dmesg of my local patched 4.1.0 (mainline aka
> > torvals/master) are:
> > 
> > [    6.067993] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
> > [    6.068072] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
> > [    6.068216] spi spi-WM510205:00: 8333333 Hz actual, PIO
> > [    6.068224] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
> > [    6.068284] spi spi-WM510205:00: checking WM510205 with wm8310
> > [    6.068290] spi spi-WM510205:00: checking WM510205 with wm8311
> > [    6.068295] spi spi-WM510205:00: checking WM510205 with wm8312
> > [    6.068299] spi spi-WM510205:00: checking WM510205 with wm8320
> > [    6.068304] spi spi-WM510205:00: checking WM510205 with wm8321
> > [    6.068308] spi spi-WM510205:00: checking WM510205 with wm8325
> > [    6.068312] spi spi-WM510205:00: checking WM510205 with wm8326
> > [    6.068316] spi spi-WM510205:00: modalias WM510205 in id_table not
> > found, returns NULL
> > [    6.068322] spi spi-WM510205:00: checking WM510205 with bmp180
> > [    6.068327] spi spi-WM510205:00: checking WM510205 with bmp181
> > [    6.068331] spi spi-WM510205:00: modalias WM510205 in id_table not
> > found, returns NULL
> > [    6.068337] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
> > [    6.143633] arizona spi-WM510205:00: acpi_match_device() first,
> > than via spi_get_device_id().
> > [    6.143643] arizona spi-WM510205:00: matched ACPI ID and data
> > [    6.143648] arizona spi-WM510205:00: using 1 as type for arizona audio codec
> > [    6.143652] arizona spi-WM510205:00: regmap set to wm5102_spi
> > [    6.144461] arizona spi-WM510205:00: arizona_spi_probe done, call
> > and return of  arizona_dev_init
> > [    6.144576] spi-WM510205:00 supply AVDD not found, using dummy regulator
> > [    6.144761] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
> > [    6.144784] spi-WM510205:00 supply DCVDD not found, using dummy regulator
> > [    6.176047] arizona spi-WM510205:00: Unknown device ID: ffff
> 
> My guess here is that the GPIOs for the reset and LDOENA lines
> are not specified. I think the Windows guys specify very little
> through ACPI and hard-code most of it into the driver, so you are
> probably going to need to find a way to define some pdata for the
> CODEC to get things going here.
> 
> Also not finding DCVDD is a bit odd make sure you have the
> arizona-ldo1 driver built into your system.
> 

I had a bit of a chat with Mark last night about this seems like
the best way to handle this is going to be to hard-code a pdata
structure into the driver and have that selected when we see the
appropriate ID.

Probably the bear minimum you want to define are the reset and
ldoena GPIOs as I said before. I also have a vague memory in the
back of my head that the Intel processors only support edge
driven IRQs so you probably want to add the irq_flag
IRQF_TRIGGER_RISING/FALLING, and irq_gpio which is the GPIO pin
that corresponds to the interrupt.

static struct arizona_pdata wm5102_pdata = {
	.reset = ????,
	.ldoena = ????,
	.irq_flags = ????,
	.irq_gpio = ????,
};

Thanks,
Charles
