From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Wed, 21 Apr 2010 14:46:01 +0200
Message-ID: <1271853961.1537.1781.camel@pancake>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
	 <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
	 <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
	 <1271762498.1537.215.camel@pancake>
	 <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:53712
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0DUMqG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2010 08:46:06 -0400
In-Reply-To: <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

Hello again,

> Hum .. maybe, the best way to know would be to dump it in various
> hardware states.
I've found some time yesterday to give it a try and first had a look at the EC
register space. I've actually managed to find a register which reflects
the state of the hotkeys - it's register 0xE6. I could probably now just
write a driver to poll this at 5 or 10 Hz and be done with it, but that
solution seems a little hackish. The EC register space is probably still
necessary for accelerometer access (I'll try to set the X/Y/ZALM bits to
1 later and see what happens), but I think for hotkeys, an event-based
solution would be better.

> >> > ERQ0 (present in BUF1) is compared to Arg2 (BY09) == 0x1
> >> > if true, it will store some values and call notify
> > So this would then trigger the WMI event in the driver, right?
> > I'd assume that EVID is the EVent ID - would make sense, since somewhere
> > in the embedded controller code, there's this snippet:
> >
> >        Method (_QEF, 0, NotSerialized)
> >        {
> >                Store (0xEF, P80H)
> >                \_SB.WMI2.CMD2 (0x2D, 0x01, 0x01)
> >        }
> >
> >        Method (_QF1, 0, NotSerialized)
> >        {
> >                Store (0xF1, P80H)
> >                \_SB.WMI2.CMD2 (0x2C, 0x01, 0x01)
> >        }
> >
> > AFAICT the problem might be that ERQ0 is never initialized.. so it's
> > probably zero from the start and the first code branch in CMD0 will
> > never be called.
> 
> ERQ0 is initialized here (with 0x00):
>                         Name (BUF1, Buffer (0x40)
AFAICT it's never accessed anywhere else, right? So it's going to sit
there at 0x00 and the Notify (\_SB.WMI2, 0x80) code will never be
called.

I still have a bit of confusion going on with respect to the difference
between WMI notifications and EC notifications. The Notify() call above
would trigger the WMI notification, but in what way would the kernel be
notified about something like the following:

	Method (_Q8F, 0, NotSerialized)
	{
		Store ("_Q8F : Hot Key Event", Debug)
		Store (0x8F, P80H)
		DSGO ()
		DSSV ()
		Store ("_Q8F : Hot Key Event Finished", Debug)
	}

IIRC all _Qxx methods are also some kind of notification system, right?

Thanks, Yours, Florian
-- 
0666 - Filemode of the Beast

