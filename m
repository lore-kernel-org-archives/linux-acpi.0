From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sun, 25 Apr 2010 14:02:48 -0500
Message-ID: <1272222168.1640.33.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
	 <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop>
	 <20100425022832.GA27607@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:60259 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0DYTCx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Apr 2010 15:02:53 -0400
In-Reply-To: <20100425022832.GA27607@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

Providing more data here.

On Sat, 2010-04-24 at 23:28 -0300, Henrique de Moraes Holschuh wrote: 
> On Sat, 24 Apr 2010, Jerone Young wrote:
> > On Sat, 2010-04-24 at 22:16 +0100, Matthew Garrett wrote:
> > > On Sat, Apr 24, 2010 at 03:49:38PM -0500, Jerone Young wrote:
> > > 
> > > > The issue is the way Windows does it is through a userspace daemon.  By
> > > > making it OSI=Linux (just as with the Thinkpads currently already in
> > > > blacklist.c ..*61 line) the machines just send the OS a key press.
> > > 
> > > And how does that userspace daemon receive the event?
> > 
> > Well it's a daemon and a suite. Don't know if you have ever seen a
> > Thinkpad with Windows? .. but has a lot of Think tools & such. Apart of
> > these tools is an OSD as well.
> 
> Matthew is quite used to ThinkPads, and so am I.  Believe me, it should
> be an ACPI event, either HKEY or GPE.  They don't do direct EC access in
> Windows if they can help it, least of all polled access...

No ACPI event is sent by the mute key. This is on my X301 & T61 (already
in blacklist.c). They must be doing some polling, as I remember there
being a slight delay when you press the mute key and Windows getting the
update from the userspace daemon.

I've also described this in the past. For any machine past the *61 line
of Thinkpads when Lenovo took over, the up down volume keys send soft
kepresses. But the mute key does not send an event to the OS. Well
unless OSI(Linux).


> 
> Comparing GPEs across several IBM-heritage DSDTs (ignore the X100e and
> other OEM crap with a thinkpad name), I think it comes in as 'hotkeys'
> (i.e. 0x10xx HKEY events).  Please enable the high eight bits on the
> thinkpad-acpi hotkey mask, assign keycodes to those keys, and tell me
> what you find.  Make sure to have OSI(Linux) *disabled*, I very much
> doubt it works in "Linux" mode.

Since it sends no acpi event there is no way for it to catch it. Could
I be wrong?


I have do not have OSI(Linux) on. Also I see the other keys like lock &
battery sending acpi events for thinkpad-acpi to catch. But the for the
sound keys. Volume up & down send soft key presses. Mute sends nothing
at all.



> 
> > event happens and changes things at that Level (maybe by sending a mute
> > key press??) .. but at the Windows userspace Level things get muted and
> 
> Most likely it will mute the mixer directly.  And so should we, trying
> to sync states over the input layer using EV_KEY is UTTERLY BROKEN, and
> fully into Don't Ever Do That territory.
> 
> I will provide proper support through thinkpad-acpi (which is *NOT* a
> EV_KEY. EV_SW, a thinkpad-specific event, a poll()'able sysfs
> attribute...), if there is a need.

The problem here as I describe in my last email is that thinkpad-acpi
cannot full fix this issue. You need to have a userspace daemon to
interact with the userspace sound server.

By using OSI(Linux) for these in particular. While they do not get
hardware mute to the speakers, it provides a superior user experience
with the big Linux Based Desktops OS of today. Also the big thing for
users is the headphones don't mute. Also this is what new Thinkpads are
doing out of the box.

What is getting me guys is that we have machines already doing this
right now in the code from the same time period (They where put there to
solve the exact same issue). This is just an extension of those
machines. I think what we are discussing now is a separate possible
solution. But for the short term we should black list these machines
also, till can sort it out. Once it is we can unblack list all of them.

But most users just think something is wrong with Linux.

Thanks,
Jerone 
> 



