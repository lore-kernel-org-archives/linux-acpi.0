From: Erik Slagter <erik@slagter.name>
Subject: Re: No c2-c7 states on core i7
Date: Tue, 24 Nov 2009 14:55:04 +0100
Message-ID: <4B0BE5B8.7060402@slagter.name>
References: <4B06A7A8.109@slagter.name>	<1258945512.3773.33.camel@localhost.localdomain>	<4B0A4D62.2040001@slagter.name>	<alpine.LFD.2.00.0911231101150.858@localhost.localdomain>	<4B0AE1FD.4030108@slagter.name> <20091124143459.385a0bc9@starbug.prg01.itonis.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:51443 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932912AbZKXNzG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Nov 2009 08:55:06 -0500
In-Reply-To: <20091124143459.385a0bc9@starbug.prg01.itonis.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jindrich Makovicka <makovick@gmail.com>
Cc: linux-acpi@vger.kernel.org

> Most of the overclockers disable C3/C6/C7 anyway for stability reasons,
> probably because sudden changes in core voltage disturb the CPU
> operation. My i5 Lynnfield desktop was actually unusable with C3/C6/C7
> even with default settings (fsck reporting random errors etc.).  I
> ended up disabling the higher C-states and just raised the Base clock
> so I do not need the Turbo mode. As long as you do not disable C1,
> the difference in idle power consumption is rather small.

This is very interesting.

I really would not want to disable the higher C states because according 
to intel marketing, but also according to tech sheets these promise to 
save a lot of energy by progressively completely turning off parts of 
the core(s).

What you describe is actually exactly what I see, power usage differs 
greatly from C0 to C1E (between 150 and 100 wats, 50%...), after that, 
in higher C states, the power usage doesn't change that much.

It seems I have a combination of a very stable power supply and a very 
stable motherboard because I have all features enabled that make the 
power supply fluctuate (c3-c7, cpufreq), and even more, until yesterday 
I used to use overclocking to 3.2 Ghz with very slightly raised cpu 
voltage, that combination has been running for months now without any 
flaw or any related kernel message.

Yesterday I raised the clock to 3.4 Ghz and I set all voltages to 
"normal" and it seems to run fine. I will have to check under really 
heavy load yet, I will do that tonight. My motherboard has an option 
"power line load calibration", I guess that has something to do with it :-)

Interesting: I pulled out a "modern" (but cheapo, no fans) pcie vga card 
and replaced it with a very old pci card (I guess from 1996) and that 
saves me 20 watts! That's more power than I problably ever could save 
using C states!

BTW on my ancient athlon-mp board, I could enable c2/c3 (although not 
supported by the bios) and that would save about ~40 watts of power. But 
it looks I won't see such a difference on modern CPU's, maybe because of 
the dynamic frequency scaling and enhanced c1? Is there anyone who can 
give me an indication of what to expect in powersavings by c2-c7 on 
modern cpu's?
