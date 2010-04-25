From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Fix mute key on older Thinkpads by OSI blacklisting
 them
Date: Sat, 24 Apr 2010 23:28:32 -0300
Message-ID: <20100425022832.GA27607@khazad-dum.debian.net>
References: <1272062884.1594.73.camel@laptop>
 <20100424160114.GA13867@srcf.ucam.org>
 <1272142178.1839.138.camel@laptop>
 <20100424211601.GA16731@srcf.ucam.org>
 <1272154109.1839.345.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53836 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750994Ab0DYC2h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Apr 2010 22:28:37 -0400
Content-Disposition: inline
In-Reply-To: <1272154109.1839.345.camel@laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerone Young <jerone.young@canonical.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

On Sat, 24 Apr 2010, Jerone Young wrote:
> On Sat, 2010-04-24 at 22:16 +0100, Matthew Garrett wrote:
> > On Sat, Apr 24, 2010 at 03:49:38PM -0500, Jerone Young wrote:
> > 
> > > The issue is the way Windows does it is through a userspace daemon.  By
> > > making it OSI=Linux (just as with the Thinkpads currently already in
> > > blacklist.c ..*61 line) the machines just send the OS a key press.
> > 
> > And how does that userspace daemon receive the event?
> 
> Well it's a daemon and a suite. Don't know if you have ever seen a
> Thinkpad with Windows? .. but has a lot of Think tools & such. Apart of
> these tools is an OSD as well.

Matthew is quite used to ThinkPads, and so am I.  Believe me, it should
be an ACPI event, either HKEY or GPE.  They don't do direct EC access in
Windows if they can help it, least of all polled access...

Comparing GPEs across several IBM-heritage DSDTs (ignore the X100e and
other OEM crap with a thinkpad name), I think it comes in as 'hotkeys'
(i.e. 0x10xx HKEY events).  Please enable the high eight bits on the
thinkpad-acpi hotkey mask, assign keycodes to those keys, and tell me
what you find.  Make sure to have OSI(Linux) *disabled*, I very much
doubt it works in "Linux" mode.

> event happens and changes things at that Level (maybe by sending a mute
> key press??) .. but at the Windows userspace Level things get muted and

Most likely it will mute the mixer directly.  And so should we, trying
to sync states over the input layer using EV_KEY is UTTERLY BROKEN, and
fully into Don't Ever Do That territory.

I will provide proper support through thinkpad-acpi (which is *NOT* a
EV_KEY. EV_SW, a thinkpad-specific event, a poll()'able sysfs
attribute...), if there is a need.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
