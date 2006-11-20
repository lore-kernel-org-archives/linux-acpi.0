From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ACPI breakage (Re: 2.6.19-rc6: known regressions (v2))
Date: Mon, 20 Nov 2006 10:27:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611201020320.3692@woody.osdl.org>
References: <B41635854730A14CA71C92B36EC22AAC5AD485@mssmsx411>
 <Pine.LNX.4.64.0611181104030.3692@woody.osdl.org> <455FB44C.8050103@linux.intel.com>
 <Pine.LNX.4.64.0611182048560.3692@woody.osdl.org> <456043F7.1030105@linux.intel.com>
 <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:1685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966362AbWKTS1M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Nov 2006 13:27:12 -0500
In-Reply-To: <Pine.LNX.4.64.0611201003540.3692@woody.osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org


[ Digression from testing Alexey's patch that makes the Evo work again 
  with two separate threads ]

On Mon, 20 Nov 2006, Linus Torvalds wrote:
> 
> Ok, this one works for me too, and looks much simpler.

Hmm. Some more testing shows that fan behaviour after a suspend-to-ram 
event seems broken, but I suspect the breakage isn't new.

It seems that ACPI remembers fan state from before the suspend, and then 
(incorrectly) uses that to decide whether it should turn fans on or off. 
So for example, it seems to remember that the fan was already on, so it 
won't ever turn it on again - even though the suspend will obviously have 
turned off all fans too.

So after running for a while, I get (for example):

	cat /proc/acpi/thermal_zone/TZ1/*

	..
	state:                   active[0]
	temperature:             92 C
	critical (S5):           99 C
	passive:                 95 C: tc1=1 tc2=2 tsp=100 devices=0xf7e42338
	active[0]:               80 C: devices=0xc18d78ec
	active[1]:               70 C: devices=0xc18d7888
	active[2]:               60 C: devices=0xc18d7838
	active[3]:               45 C: devices=0xc18d77e8

(it thinks all fans are on), but no fans are actually on:

	cat /proc/acpi/fan/*/*

	status:                  off
	status:                  off
	status:                  off
	status:                  off

Of course, I'm not exactly having a lot of trust in ACPI in general, so 
for all I know this is just more unfixable crap from the firmware. But it 
smells like "I remember state from before the suspend".

			Linus
