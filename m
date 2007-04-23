From: Lex Neva <acpi@lexneva.name>
Subject: C2 and C3 processor states cause mouse desynchronization
Date: Sun, 22 Apr 2007 22:57:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704222237480.25154@lexneva.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lexneva.name ([207.210.101.78]:2015 "EHLO lexneva.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030971AbXDWC5w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Apr 2007 22:57:52 -0400
Received: from localhost ([127.0.0.1])
	by lexneva.name with esmtp (Exim 4.62 #1 (Debian))
	id 1HfokQ-0006a0-Iq
	for <linux-acpi@vger.kernel.org>; Sun, 22 Apr 2007 22:57:51 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently bought one of these beauties:

http://www.sagernotebook.com/pages/notebooks/product2.cfm?ProductType=2030&SubType=C

Mine's got a T7200 Core 2 Duo 2.0ghz processor and a gig of ram.

It works pretty beautifully in linux, and acpi support seems to work well.  No 
throttling (thanks, intel), but battery and power button and all that work 
beautifully.  All hardware is supported save the SD card reader, webcam, and 
possibly pcmcia (it froze the one time I tried it, and I haven't bothered 
messing with it).

One thing that's caused a pretty nasty problem is that the mouse driver 
desynchronizes fairly frequently.  Symptoms include a mouse going nuts all 
over my X session, usually doing exciting things like opening 30 xterms and 
pasting code all over my shell, along with triggering wonderful bugs in 
Enlightenment that cause it to freeze.  The kernel usually shows messages like 
this:

Apr 22 22:12:20 lextop psmouse.c: Wheel Mouse at isa0060/serio4/input0 lost 
synchronization, throwing 3 bytes away.

Sometimes this is followed by a message like this:

psmouse.c: resync failed, issuing reconnect request

>From what I can tell, the mouse-going-nuts part happens BEFORE the "lost 
synchronization" message.  I'm not clear on why the psmouse driver doesn't 
figure out that it's getting tons of junk data.

I've tried TONS of things to narrow down and fix the problem, up to and 
including hacking some suggested workarounds into my psmouse driver, to no 
avail.  The thing desynchronizes, and there's not much I could figure out to 
do about it with my meager kernel knowledge.

I tried many different kernel options, such as PM_TIMER, disabling SMP, etc. 
I've compiled more kernels for this thing than I've had to in ages.  I tried 
isolating and removing many different factors one at a time, including the 
nvidia drivers, sound drivers (hda_intel in ALSA), network (wireless and 
wired), etc... no luck.  I've spent days on this problem.

The only clue I had was that Puppy Linux (puppylinux.org, a livecd distro) 
didn't seem to trigger the problem no matter how long I waggled the touchpad 
(usually 30 seconds is enough to do it)... even with a 2.6.18 kernel (mine is 
2.6.20.6).  Not much has changed in the psmouse driver since then.  I tried 
using their kernel configuration on the 2.6.20.7 kernel, and with a little 
tweaking, I FINALLY discovered what the big difference was: the processor ACPI 
module.  If it's in, the mouse goes nuts frequently.  If it's not, the mouse 
only goes nuts if I waggle it for 5-10 minutes straight (my finger's tired!)

My CPU has 3 Cstates:

active state:            C1
max_cstate:              C1
bus master activity:     00000000
maximum allowed latency: 5850 usec
states:
    *C1:                  type[C1] promotion[C2] demotion[--] latency[001] usage[00902132] duration[00000000000000000000]
     C2:                  type[C2] promotion[C3] demotion[C1] latency[001] usage[00000000] duration[00000000000000000000]
     C3:                  type[C3] promotion[--] demotion[C2] latency[057] usage[00000000] duration[00000000000000000000]

I think you can already see what the (unfortunate) solution is.  If I set 
max_cstate to 2, the problem's still there.  Set it to 1, and it goes away. 
So does 5-6% more of my battery per hour. :(  All told, I guess that's not 
that much, considering.  It could be worse.

So, the questions I have:

Is this a problem anyone's seen before?

Is this a bug?  If so, is it in linux-ACPI or psmouse (or something else)?

Is there anything I can do to get my power savings and still make the mouse 
driver happy?

Is there any chance that I can work with the linux-ACPI developers to get a 
fix produced?



For reference, windows doesn't seem to have any kind of 
mouse-desynchronization problems.  I haven't seen the mouse stutter or 
anything that would indicate a quiet reset behind the scenes.  I'm not sure 
what they're doing that Linux isn't.  I sure don't want to use Windows just to 
avoid a flakey touchpad :P

Let me know if you need any more information about my laptop.  I'm rather 
linux-savvy from an administration standpoint, although I'm no kernel hacker. 
I'd be glad to run tests for you, try bleeding-edge kernels, and provide you 
pages of diagnostic data.  Just let me know how I can help.

--Lex Neva
