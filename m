From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Mon, 26 Apr 2010 07:38:55 -0300
Message-ID: <20100426103855.GB2614@khazad-dum.debian.net>
References: <1272062884.1594.73.camel@laptop>
 <20100424160114.GA13867@srcf.ucam.org>
 <1272142178.1839.138.camel@laptop>
 <20100424211601.GA16731@srcf.ucam.org>
 <1272154109.1839.345.camel@laptop>
 <20100425022832.GA27607@khazad-dum.debian.net>
 <1272222168.1640.33.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36745 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754437Ab0DZKi7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Apr 2010 06:38:59 -0400
Content-Disposition: inline
In-Reply-To: <1272222168.1640.33.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Sun, 25 Apr 2010, Jerone Young wrote:
> No ACPI event is sent by the mute key. This is on my X301 & T61 (already
> in blacklist.c). They must be doing some polling, as I remember there
> being a slight delay when you press the mute key and Windows getting the
> update from the userspace daemon.

Please test on the T400 and T410, if possible.

> > Comparing GPEs across several IBM-heritage DSDTs (ignore the X100e and
> > other OEM crap with a thinkpad name), I think it comes in as 'hotkeys'
> > (i.e. 0x10xx HKEY events).  Please enable the high eight bits on the
> > thinkpad-acpi hotkey mask, assign keycodes to those keys, and tell me
> > what you find.  Make sure to have OSI(Linux) *disabled*, I very much
> > doubt it works in "Linux" mode.
> 
> Since it sends no acpi event there is no way for it to catch it. Could
> I be wrong?

There are three new HKEY events on some of the newer thinkpads (I don't know
if they exist in the X300/X301).  They're hooked to suspicious GPEs that are
the same as the ones for volume feedback on all other thinkpads.

Whatever solution I will adopt, won't be one for the X300 in particular.  It
needs to be one that won't be a hindrance in the next two years at least.

I need more data on the newest models first, to make an informed decision.
It is entirely possible that the X300/T61 generation require a different
solution than the earlier models.  And it is entirely possible that the T410
and newer allow for a better solution than the X300/T61.

EC polling is bad, hardware state unsynced is worse.  And any polling done
in userspace is Ugly, Bad, and will bite us back when it is not needed
anymore.

thinkpad-acpi is perfectly capable of doing polling on its own so that it
becomes transparent to userspace, and userspace won't screw over the owners
of thinkpads that don't need polling.

So, it is not that I am against the OSI(Linux) patch.  But I *do* want the
full data...

> The problem here as I describe in my last email is that thinkpad-acpi
> cannot full fix this issue. You need to have a userspace daemon to
> interact with the userspace sound server.

But you can send full state messages using EV_SW or some other channel, to
force userspace into sync with the hardware state (if we can get to the
hardware state).  I'd rather find out whether we need that on the newest
generation of thinkpads *before* userspace starts expecting a certain
behaviour from the thinkpad.

> What is getting me guys is that we have machines already doing this
> right now in the code from the same time period (They where put there to
> solve the exact same issue). This is just an extension of those
> machines. I think what we are discussing now is a separate possible
> solution. But for the short term we should black list these machines
> also, till can sort it out. Once it is we can unblack list all of them.

I don't mind short-term solutions.  But I *do* mind any future pressure to
keep them around instead of fixing things properly even if we will need to
break userspace hacks.  I am not yet sure this won't be the case, here.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
