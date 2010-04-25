From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sun, 25 Apr 2010 13:28:11 -0500
Message-ID: <1272220091.1274.94.camel@laptop>
References: <1272062884.1594.73.camel@laptop>
	 <20100424160114.GA13867@srcf.ucam.org> <1272142178.1839.138.camel@laptop>
	 <20100424211601.GA16731@srcf.ucam.org> <1272154109.1839.345.camel@laptop>
	 <20100425022832.GA27607@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:54812 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab0DYS2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Apr 2010 14:28:17 -0400
In-Reply-To: <20100425022832.GA27607@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

I'll provide more data here.

I think it's not really possible to get it correct with thinkpad-acpi .
The reason is the userspace sound server. In our case it's pulse audio.
So we are no longer just dealing with ALSA anymore. So if the OS gets a
proper hotkey event it is able to mute at the pulse audio level then,
pulse audio does work at the ALSA level (toggling the mixer).
thinkpad-acpi has no way to check on the status of pulse audio.

Under Windows Vista and above the userspace daemon is basically keeping
the higher level userspace sound server in sync with what is going on at
the hardware level. Microsoft moved to a userspace sound server with
Windows Vista.

				Thanks,
					Jerone



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
> 
> Comparing GPEs across several IBM-heritage DSDTs (ignore the X100e and
> other OEM crap with a thinkpad name), I think it comes in as 'hotkeys'
> (i.e. 0x10xx HKEY events).  Please enable the high eight bits on the
> thinkpad-acpi hotkey mask, assign keycodes to those keys, and tell me
> what you find.  Make sure to have OSI(Linux) *disabled*, I very much
> doubt it works in "Linux" mode.
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
> 


