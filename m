From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH - 2.6.19 -0/1] Backport of psmouse suspend/shutdown
	cleanups
Date: Mon, 26 Feb 2007 15:21:12 +0100
Message-ID: <1172499672.10619.346.camel@d36.suse.de>
References: <1172077685.10619.101.camel@d36.suse.de>
	 <d120d5000702210926j7e7f1ccjb8c2689640b870e8@mail.gmail.com>
	 <1172148739.10619.196.camel@d36.suse.de>
	 <d120d5000702220702r44894a51lfb5499b5c59d8563@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:52626 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030266AbXBZOVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Feb 2007 09:21:18 -0500
In-Reply-To: <d120d5000702220702r44894a51lfb5499b5c59d8563@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

On Thu, 2007-02-22 at 10:02 -0500, Dmitry Torokhov wrote:
> On 2/22/07, Thomas Renninger <trenn@suse.de> wrote:
> >
> > When adding the .shutdown workaround I went down and realized it must be
> > this:
> >        psmouse_set_state(psmouse, PSMOUSE_CMD_MODE);
> > or this:
> >        psmouse_set_state(psmouse, PSMOUSE_IGNORE);
> >
> > as I added the stuff in serio.c, I didn't realize that your psmouse
> > patch is enough...
> >
> > So it's the first command that is needed on shutdown(PSMOUSE_CMD_MODE)?
> > Dmitry: Could you explain me in a short sentence what this is doing, so
> > that I can explain HP the problem again more detailed (without reading
> > specs...).
> >
> 
> Actually there are 2 pieces that are needed for HP laptops:
> 
> 1. They really get upset if mouse (integrated synaptics touchpad) is
> disabled when they about to reboot. The original code was simply doing
> psmouse_reset() which issues reset command to clear state of the
> device so it will be "closer" to the boot state. Hovewer (in
> accordance to the spec) after reset mice stay disabled, so we have to
> issue:
> 
>       ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> 
> to keep HP laptops happy. Why it would make any difference is a mystery to me.
> 
> 2. Synaptics touchpads do not get fully reset by 0xff, we need to
> explicitely enable gestures - again, HP only (there may be other boxes
> with this problem of course). So we call psmouse->cleanup(psmouse) to
> activate protocol-specific cleanup.
> 
> Hope this makes sense (I must admit it makes little sense to me ;) ).

Same for me at the beginning.
I tracked two of the HP problems (wrong temperature, wrong _PPC value)
down to wrong EC reads -> BIOS issue.

Someone (this is the guy who actually solved this) reported that
unloading psmouse helps. When I saw this report confirmed by other
people a .shutdown workaround was easy and got also confirmed working...

And now it even makes a bit sense...
There is a little microprocessor (Embedded Controller) pre-processing
sensor or other data which gets accessed via ACPI. This one also access
mouse/keyboard hardware (described a bit in ACPI specs).
This post makes things a bit more clear:
http://forum.thinkpads.com/viewtopic.php?t=20958
--------------------------
On a T43p (and probably several others) this is a Renesas H8S/2161BV, a
16-bit single-chip micro-controller located below the
ExpressCard/CardBus slots. It has its own OS in 128 KB flash memory and
since this OS is available in the EC updates, it is possible to analyze
and modify it. Or we will at least be able to better understand how it
can be configured since there doesn't seem to be much documentation
available about the EC. 
--------------------------

FYI:
You might stumble again over the EC in future...
I saw reports where mouse jittering or similar bugs where fixed in
drivers/acpi/ec.c
If trying ec_intr=0 boot param, not loading any ACPI modules or the big
hammer: acpi=off helps to solve mouse or keyboard problems it's probably
Embedded Controller related (which might need a fix in ec.c, AML or EC
BIOS code (in this case we seem to have the latter problem :) )...).

I expect the EC accesses keyboard/mouse registers at late shutdown and
gets confused if it's in wrong state. The EC seem to hold it's confused
state in some kind of volatile memory as long as it can drain some power
from battery (unplugging AC and battery for several minutes when machine
is shut down was reported to fix the issue...) and does not get fully
reinitialized on next boot.

   Thomas

