From: Mattia Dongili <malattia@linux.it>
Subject: Re: [RFH,Status] Sony Vaio VGN-Z11 support
Date: Sat, 1 Nov 2008 14:25:16 +0900
Message-ID: <20081101052516.GD3986@inferi.kami.home>
References: <20081025214602.GB27030@gamma.logic.tuwien.ac.at> <Pine.LNX.4.63.0810251854180.10973@dashnine.joshuawise.com> <20081025233118.GA31722@gandalf.dynalias.org> <20081027232051.GI22083@gamma.logic.tuwien.ac.at> <20081028014148.GB28057@inferi.kami.home> <20081028014708.GA2649@gamma.logic.tuwien.ac.at> <20081028131220.A89C9E072@master.hanzubon.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:58341
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750716AbYKAFZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Nov 2008 01:25:26 -0400
Content-Disposition: inline
In-Reply-To: <20081028131220.A89C9E072@master.hanzubon.jp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ISHIKAWA Mutsumi <ishikawa@hanzubon.jp>
Cc: preining@logic.at, joshua@joshuawise.com, linux-acpi@vger.kernel.org

On Tue, Oct 28, 2008 at 10:12:20PM +0900, ISHIKAWA Mutsumi wrote:
> >>>>> In <20081028014708.GA2649@gamma.logic.tuwien.ac.at> 
> >>>>>	Norbert Preining <preining@logic.at> wrote:
> >> Hi Mattia,
> >>
> >> (taking the MMC guy out, this is not about the SD card reader anymore)
> >>
> >> On Di, 28 Okt 2008, Mattia Dongili wrote:
> >> > Yes, I am. But I have no idea what might be wrong. Did you also try
> >> > xbacklight while in X and using the Intel card?
> >>
> >> I am a step further on. Thanks to Ishikawa-san I have an sony-laptop.c
> >> file which allows setting the backlight using the
> >> /sys/devices/backlight/{sony,acpi_video0}/backlight files
> >> (interestingly, they do not agree on their behaviour, xbacklight can
> >> change in 12.5% jumps, that makes 9 different values, but allowed are
> >> only 8 (from 0 to 7). In sony the 0% is missing, in acpi_video0 the 100%
> >> is missing -- i.e., sony/brightness 0 is brighter than
> >> acpi_video0/brightness 0, and so on).
> 
>  There are two points of roblems to enable backlight control on VGN-Z
> 
>   1)
> 
>       VGN-Z have SNC, but it is not enabled.
>         - prevoius patch posted.
>         - add VGN-Z entry to sony_nc_ids table
> 
>   2)
> 
>        In sony_pic_detect_device_type() function, VGN-Z's SPIC is
>      detected as SONYPI_DEVICE_TYPE2 (per default).
> 
>        But it does not work for me.
> 
>        I've checkd throug TYPE1 to TYPE4. Only Type3 and Type4 does
>      work (but it is possible to control backlight only, other
>      function does not work...)
> 
>        I do not have datasheet for this model, but I think SPIC on
>      this model is not TYPE2. It is same or variant of  Type3 or
>      Type4 SPIC.

I have adopted a different approach (merge type3 and type4) but I have
included your other changes to my local tree. Hopefully I'll be able to
send a patchset for acpi-test later today.

thanks
-- 
mattia
:wq!
