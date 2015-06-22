From: Christian Hartmann <cornogle@googlemail.com>
Subject: Re: Fwd: ASoC : WM5102 Audio Codec needs ACPI support and a baytrail
 machine driver
Date: Mon, 22 Jun 2015 11:55:13 +0200
Message-ID: <CAKor6TcfpAhzWeJdoyzwEG79BLvx-9jhunbaYdE5GUTH4k7qVg@mail.gmail.com>
References: <CAKor6TdbnLuJCsBPykPEmhGk-zBLggKxw4Z+=QuBb6Mz2ThD3g@mail.gmail.com>
	<CAKor6TeP2HfqpHiKK86GLYLpCNk87y66bdjye_mAqXuMXxPMWA@mail.gmail.com>
	<CAKor6Tdg5yHaLVrCrWFVuydVcYUUtYr=oSj+k37Yd9O64+tg6A@mail.gmail.com>
	<20150616144732.GN32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:32844 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176AbbFVJzO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2015 05:55:14 -0400
Received: by qged89 with SMTP id d89so50803182qge.0
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2015 02:55:13 -0700 (PDT)
In-Reply-To: <20150616144732.GN32730@opensource.wolfsonmicro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com, linux-acpi <linux-acpi@vger.kernel.org>

hi list,

FYI - I have some local patches (currently not ready to sent && merge) but
want to let you know about the new status:

the init messages I have now from the arizona-spi for the audio codec
WM5102  in dmesg of my local patched 4.1.0 (mainline aka
torvals/master) are:

[    6.067993] pxa2xx-spi 80860F0E:00: no DMA channels available, using PIO
[    6.068072] pxa2xx-spi 80860F0E:00: registered master spi32766 (dynamic)
[    6.068216] spi spi-WM510205:00: 8333333 Hz actual, PIO
[    6.068224] spi spi-WM510205:00: setup mode 0, 8 bits/w, 8000000 Hz max --> 0
[    6.068284] spi spi-WM510205:00: checking WM510205 with wm8310
[    6.068290] spi spi-WM510205:00: checking WM510205 with wm8311
[    6.068295] spi spi-WM510205:00: checking WM510205 with wm8312
[    6.068299] spi spi-WM510205:00: checking WM510205 with wm8320
[    6.068304] spi spi-WM510205:00: checking WM510205 with wm8321
[    6.068308] spi spi-WM510205:00: checking WM510205 with wm8325
[    6.068312] spi spi-WM510205:00: checking WM510205 with wm8326
[    6.068316] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    6.068322] spi spi-WM510205:00: checking WM510205 with bmp180
[    6.068327] spi spi-WM510205:00: checking WM510205 with bmp181
[    6.068331] spi spi-WM510205:00: modalias WM510205 in id_table not
found, returns NULL
[    6.068337] pxa2xx-spi 80860F0E:00: registered child spi-WM510205:00
[    6.143633] arizona spi-WM510205:00: acpi_match_device() first,
than via spi_get_device_id().
[    6.143643] arizona spi-WM510205:00: matched ACPI ID and data
[    6.143648] arizona spi-WM510205:00: using 1 as type for arizona audio codec
[    6.143652] arizona spi-WM510205:00: regmap set to wm5102_spi
[    6.144461] arizona spi-WM510205:00: arizona_spi_probe done, call
and return of  arizona_dev_init
[    6.144576] spi-WM510205:00 supply AVDD not found, using dummy regulator
[    6.144761] spi-WM510205:00 supply DBVDD1 not found, using dummy regulator
[    6.144784] spi-WM510205:00 supply DCVDD not found, using dummy regulator
[    6.176047] arizona spi-WM510205:00: Unknown device ID: ffff
[    6.194727] sst-acpi 80860F28:00: No matching ASoC machine driver found

Note : most of the messages here are by local dev_err() added into
some functions used to see whats going
on there...

It seems that I have to patch arizona_core again: the function
arizona_dev_init() to, so it will find and use the correct device
ID...
So going on and will report soon again

That all but not trivial...


cheers
Christian H.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
