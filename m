From: Erik Slagter <erik@slagter.name>
Subject: Re: No c2-c7 states on core i7
Date: Mon, 23 Nov 2009 20:26:53 +0100
Message-ID: <4B0AE1FD.4030108@slagter.name>
References: <4B06A7A8.109@slagter.name> <1258945512.3773.33.camel@localhost.localdomain> <4B0A4D62.2040001@slagter.name> <alpine.LFD.2.00.0911231101150.858@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eriks.xs4all.nl ([83.160.41.216]:44780 "EHLO eriks.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457AbZKWT0v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Nov 2009 14:26:51 -0500
In-Reply-To: <alpine.LFD.2.00.0911231101150.858@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, ykzhao <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

 > No, that isn't normal. C-states on modern processors generally
 > save a lot of energy.
 >
 > If you run powertop and you find that you are over 99% idle
 > and you save no energy compared to when you are 0% idle
 > (say a copy of "cat /dev/zero>  /dev/null" for each core)
 > then something is wrong with your system.

I just removed a large story here, I guess the table from my other 
message is a lot more informative.

 > It is possible, but as soon as you reverse engineer and over-ride
 > something in the BIOS, you are on very thin ice.  Presumably
 > the BIOS engineer made a concious decision to disable C-states
 > when you over-clock your board and had a reason to do so.

As long as nothing gets fried that's no problem for me.

 > Maybe the more important question is what measurable benefit
 > you get when you over-clock your board, and if you really need that...

I can understand your doubts on this matter, but I think I do have a 
legitimate reasoning. This is a server that almost all of the time does 
next to nothing. Load 0.02 or similar. It needs to be running 24/24 
though because it receives e-mail and answers the telephone. So that's 
why I want it to be low on power usage. On the other hand I need to 
transcode movie clips to h264 very regularly. I can use every 4*2 core 
for the process using x264 and indeed it works very fast. Also I noticed 
that every mhz higher clock means shorter encoding time, all 
(virtual-)cores get completely loaded. The "normal" speed of the 920 is 
2.8 Ghz (or in fact 2.63 Ghz) and a change to 3.4 Ghz really does make a 
difference in encoding speed, theoretically 30%, in practise even more.

Intel would really make me happy if they would design a processor with 
four or more cores and a chipset that would implement C7 and also could 
scale from 100 Mhz to 3.6 Ghz, in two or three steps, I wouldn't mind, 
and then would use something like 20 watts in idle, like my laptop does.
