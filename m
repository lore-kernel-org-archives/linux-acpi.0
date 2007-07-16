From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: make the input event
	mode the default
Date: Sun, 15 Jul 2007 21:12:40 -0300
Message-ID: <20070716001239.GA31604@khazad-dum.debian.net>
References: <11844223341511-git-send-email-hmh@hmh.eng.br> <20070714223315.GB25782@srcf.ucam.org> <20070715180529.GF14134@khazad-dum.debian.net> <20070715183823.GC3235@srcf.ucam.org> <20070715200948.GC19066@khazad-dum.debian.net> <20070715201346.GB5518@srcf.ucam.org> <20070715211421.GG19066@khazad-dum.debian.net> <20070715211953.GA6527@srcf.ucam.org> <20070715220801.GK19066@khazad-dum.debian.net> <20070715224914.GB7164@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60988 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758666AbXGPAMp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 20:12:45 -0400
Content-Disposition: inline
In-Reply-To: <20070715224914.GB7164@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, dmitry.torokhov@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 07:08:01PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > > Right now, the hotkey functionality of the driver is not terribly useful 
> > > without (bleeding-edge) userspace. This is inconsistent with the 
> > > majority of input drivers which do something broadly sane in that 
> > > situation.
> > 
> > It works better with non-bleeding-edge userspace the way I did it, as far as
> > I know. So I'll need some explanations about what I should be doing
> > differently.
> > 
> > Here's my view on things:
> > 
> > Non-bleeding-edge userspace screws up volume control if I send events.  And
> > so does bleeding-edge userspace for that matter, AFAIK.
> 
> No, it doesn't. It interacts in a way that you may not consider to be 
> ideal - the vast majority of our users appear to prefer it to the 
> previous behaviour, so it's better than nothing.

I don't go for "better than nothing", when there is a way to have it right
(and there is: an alsa mixer, or an extension to the input layer).

> > Non-bleeding-edge userspace screws up brightness control if I send events.
> 
> No. Nothing will screw up if you send brightness events.

It can, if it feed backs a brightness up order to the kernel, either
through thinkpad-acpi, or through the ACPI video driver at the wrong time
(before the thinkpad firmware did it).  And before you think the firmware
might be doing something sane for a change, I've had reports of more than
half-a-second delay on a X60s without the latest EC between a brightness
change order, and the hardware responding to it.

A bad feedback will either increase brightness once with two writes (waste
of resources, but the user won't notice, and I hope the thinkpad hardware is
not so crappy as to bother the inverter in this case), increase twice, or
cause a loop (got a report, don't know how it happened, but I *do* know the
code has no defense --yet-- against such a loop) that makes it increase the
brightness all the way up or all the way down until you press some other key
that disturbs the loop.

I actually prefer Lenovo's idea of not handling brightness up/down in
firmware anymore, and just reporting the keys...

> > Bleeding-edge userspace needs to be told it exists, anyway, to make proper
> > use of it, and can be told to enable it on the driver while at it.
> 
> We've been listening for KEY_BRIGHTNESS* on Thinkpads for over a year. 
> It's already implemented and works fine.

If everything did it right, I would have never heard of it.  Note that I am
not accusing HAL of breakage, I am talking about *userspace*.  I am *not*
sure if hal is what broke it, and, if it indeed was hal, whether it was new
enough.  I am sure bleeding-edge hal does something sensible for brightness,
and I have no reasons not to believe you that one-year-old hal will do
something wrong, either.  But there is other userspace, AND much older hal.

> > Non-bleeding-edge userspace that is not broken can remap keys already.
> > FN+F1 generating KEY_FN_F1 makes a lot more sense to someone which has a
> > blank FN+F1 key, than it generating "KEY_FOOBAR".
> 
> That's fine. Send KEY_FN_F1 if there's no label.

Isn't that what I am doing right now?  That's why I asked you which key
codes I was missing when you complained about it. I really don't know of
any.

> > So exactly what should I be changing to make it more useful?  WHAT hot keys
> > do you want mapped by default, and to which key codes?  And forget the ones
> > that need passive handling, these are not mapped for a very different
> > reason.
> 
> On a machine with a glyph, the driver should generate a keycode 
> appropriate for that glyph.

It already does so for every key with a glyph that requires active handling
AND which is present on most thinkpads AND for which I could find a sensible
keycode.

Oh, I miss an undock/eject generic device keycode, too.  Can't use EJECTCD
to undock...

Again, what you want me to change in that default key code matrix that is
not a passive-action key?  I aimed to do the best I could according to the
info I have (http://thinkwiki.org/wiki/Default_meanings_of_special_keys).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
