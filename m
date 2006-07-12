From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 15:18:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121509180.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6F7630D@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750744AbWGLWSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Jul 2006 18:18:09 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6F7630D@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>



On Wed, 12 Jul 2006, Brown, Len wrote:
>
> Does /proc/interrupts show that the acpi interrupt is ticking along
> at the same rate as the kacpid_notify build-up?

It's really hard to tell.

The machine starts out fine, with no kacpid_notify buildup AT ALL.

Then, at some point, something changes. I dunno what, but I'm guessing the 
temperature goes up, and it gets a temp event and wants to turn on the 
fan.

And when that happens, things go to hell very quickly, and the whole 
machine becomes undebuggable quite soon. And it's really hard to hit the 
window between "uhhuh, bad things are starting to happen" and the "oops, 
the machine is now totally deal, only the magic scrolllock keys work any 
more".

So I can give you info about what the machine dos _before_ things go bad, 
and I can give limited register info about what happens when the machine 
is totally hosed, but I've only been able to get very lucky a few times 
(usually it's a "ps ax" that I had running to try to trigger it, and it 
locks up in the _middle_ of the "ps", showing tens of the kacpid_notify 
things - there are probably thousands, but the "ps ax" takes long enough 
that the machine runs out of memory before it even finishes.

> If you run with  CONFIG_ACPI_THERMAL=n or otherwise nuke
> the thermal module, does the interrupt and the kacpid_notify symptom go
> away?

I'll try that. Right now I've started a "git bisect" run, since it seemed 
to be the easiest way to get _some_ information about the problem, without 
having to know much else about it.

The problem, of course, is that there are those 6000 commits (fine, that's 
about 13 kernels to be tested), but more importantly that I'm not 100% 
sure how repeatable it all is (see above - it's not like it locks up 
immediately on boot, there seems to be something that triggers it, usually 
while doing a kernel compile or a big grep), and if I ever get that answer 
wrong, I'll be doing it all in vain.

		Linus
