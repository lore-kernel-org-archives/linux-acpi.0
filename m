From: Jindrich Makovicka <makovick@gmail.com>
Subject: Re: No c2-c7 states on core i7
Date: Tue, 24 Nov 2009 14:34:59 +0100
Message-ID: <20091124143459.385a0bc9@starbug.prg01.itonis.net>
References: <4B06A7A8.109@slagter.name>
	<1258945512.3773.33.camel@localhost.localdomain>
	<4B0A4D62.2040001@slagter.name>
	<alpine.LFD.2.00.0911231101150.858@localhost.localdomain>
	<4B0AE1FD.4030108@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50467 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbZKXNj6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Nov 2009 08:39:58 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NCvch-0002ol-LZ
	for linux-acpi@vger.kernel.org; Tue, 24 Nov 2009 14:40:03 +0100
Received: from 193.239.0.25 ([193.239.0.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2009 14:40:03 +0100
Received: from makovick by 193.239.0.25 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2009 14:40:03 +0100
In-Reply-To: <4B0AE1FD.4030108@slagter.name>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Mon, 23 Nov 2009 20:26:53 +0100
Erik Slagter <erik@slagter.name> wrote:

>  > No, that isn't normal. C-states on modern processors generally
>  > save a lot of energy.
>  >
>  > If you run powertop and you find that you are over 99% idle
>  > and you save no energy compared to when you are 0% idle
>  > (say a copy of "cat /dev/zero>  /dev/null" for each core)
>  > then something is wrong with your system.
> 
> I just removed a large story here, I guess the table from my other 
> message is a lot more informative.
> 
>  > It is possible, but as soon as you reverse engineer and over-ride
>  > something in the BIOS, you are on very thin ice.  Presumably
>  > the BIOS engineer made a concious decision to disable C-states
>  > when you over-clock your board and had a reason to do so.
> 
> As long as nothing gets fried that's no problem for me.
> 
>  > Maybe the more important question is what measurable benefit
>  > you get when you over-clock your board, and if you really need
>  > that...
> 
> I can understand your doubts on this matter, but I think I do have a 
> legitimate reasoning. This is a server that almost all of the time
> does next to nothing. Load 0.02 or similar. It needs to be running
> 24/24 though because it receives e-mail and answers the telephone. So
> that's why I want it to be low on power usage. On the other hand I
> need to transcode movie clips to h264 very regularly. I can use every
> 4*2 core for the process using x264 and indeed it works very fast.
> Also I noticed that every mhz higher clock means shorter encoding
> time, all (virtual-)cores get completely loaded. The "normal" speed
> of the 920 is 2.8 Ghz (or in fact 2.63 Ghz) and a change to 3.4 Ghz
> really does make a difference in encoding speed, theoretically 30%,
> in practise even more.
> 
> Intel would really make me happy if they would design a processor
> with four or more cores and a chipset that would implement C7 and
> also could scale from 100 Mhz to 3.6 Ghz, in two or three steps, I
> wouldn't mind, and then would use something like 20 watts in idle,
> like my laptop does.

Most of the overclockers disable C3/C6/C7 anyway for stability reasons,
probably because sudden changes in core voltage disturb the CPU
operation. My i5 Lynnfield desktop was actually unusable with C3/C6/C7
even with default settings (fsck reporting random errors etc.).  I
ended up disabling the higher C-states and just raised the Base clock
so I do not need the Turbo mode. As long as you do not disable C1,
the difference in idle power consumption is rather small.

-- 
Jindrich Makovicka


