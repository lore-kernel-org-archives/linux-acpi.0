From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.20-rc6-mm3
Date: Wed, 31 Jan 2007 14:22:45 +0100
Message-ID: <20070131132245.GA26066@elte.hu>
References: <20070129204528.eb8d695e.akpm@osdl.org> <45BFC442.5000903@gmail.com> <20070130142714.9f8dd5da.akpm@osdl.org> <200701310155.05474.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:54434 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933251AbXAaNYo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Jan 2007 08:24:44 -0500
Content-Disposition: inline
In-Reply-To: <200701310155.05474.fzu@wemgehoertderstaat.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Andrew Morton <akpm@osdl.org>, Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Similar weirdness here on rc6-mm2 and rc6-rt*: resume from disk waits 
> unduly long.

i'm wondering whether the jiffies update fix from Thomas fixes this bug 
for you.

If not then do you have a serial console enabled?

> Some waiting times from rc6-rt6 from memory:
> 
> Config		| HZ			| NO_HZ + HRESTIMERS
> cmos clock unchanged	| 2s			| 6s
> cmos clock += 10min	| 			| 2 minutes
> cmos clock += 2 month	| 20s			| > 4minutes, test interrupted

i've seen something like this on -rt (and incorrectly attributed it to 
-rt) when running on a system which has a serial port and which has a 
kernel console on that serial port. What happens is that after resume 
(and straight after console suspend) every serial character printed 
takes /alot/ of time - and resume does print a number of kernel messages 
to the console. I didnt get any further in debugging this though, but 
disabling the serial console made the problem go away.

a possibly related thing: the serial code is sensitive to jiffies 
updates and timers, i saw that during early revisions of the dynticks 
code - but the specifics escape me.

the slowdown could also be something like the kernel somehow wrapping 
around jiffies and thus doing /alot/ of jiffy ticks? Or it could be a 
miscalculation in the amount of jiffies that need updating, resulting in 
a similar number of loops in the jiffy update code.

(i'll try to figure out this regression - but wanted to describe to you 
the known things so far, maybe you'll figure it out faster than me.)

	Ingo
