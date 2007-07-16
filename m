From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: make the input event
	mode the default
Date: Mon, 16 Jul 2007 00:02:54 -0300
Message-ID: <20070716030254.GD31604@khazad-dum.debian.net>
References: <20070715180529.GF14134@khazad-dum.debian.net> <20070715183823.GC3235@srcf.ucam.org> <20070715200948.GC19066@khazad-dum.debian.net> <20070715201346.GB5518@srcf.ucam.org> <20070715211421.GG19066@khazad-dum.debian.net> <20070715211953.GA6527@srcf.ucam.org> <20070715220801.GK19066@khazad-dum.debian.net> <20070715224914.GB7164@srcf.ucam.org> <20070716001239.GA31604@khazad-dum.debian.net> <20070716002420.GA8140@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49629 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758999AbXGPDC7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 23:02:59 -0400
Content-Disposition: inline
In-Reply-To: <20070716002420.GA8140@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, dmitry.torokhov@gmail.com, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 16 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 09:12:40PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > > No, it doesn't. It interacts in a way that you may not consider to be 
> > > ideal - the vast majority of our users appear to prefer it to the 
> > > previous behaviour, so it's better than nothing.
> > 
> > I don't go for "better than nothing", when there is a way to have it right
> > (and there is: an alsa mixer, or an extension to the input layer).
> 
> Certainly. Once it's possible to do it the right way, we can do it the 
> right way :)

I can priorize one thing over another.  HAL guys, please chose which one I
shall work on first (non-zero chance of it getting ready before the merge
window closes):

1. ALSA mixer interface for the thinkpad speakers-and-headphone-out volume
control

2. CMOS NVRAM snooping support for transparent handling of non-acpi-event-
enabled hot keys (i.e. "tpb functionality").  Needed by every thinkpad
before the T43, and apparently, by the R60 for the thinkpad button.

> The only code currently listening for KEY_BRIGHTNESS* on Thinkpads is 
> gnome-power-manager, and that uses the Hal information to check whether 

What about KDE? Doesn't it have any helpers?

> > > We've been listening for KEY_BRIGHTNESS* on Thinkpads for over a year. 
> > > It's already implemented and works fine.
> > 
> > If everything did it right, I would have never heard of it.  Note that I am
> > not accusing HAL of breakage, I am talking about *userspace*.  I am *not*
> > sure if hal is what broke it, and, if it indeed was hal, whether it was new
> > enough.  I am sure bleeding-edge hal does something sensible for brightness,
> > and I have no reasons not to believe you that one-year-old hal will do
> > something wrong, either.  But there is other userspace, AND much older hal.
> 
> We had a broken version of hal in a development version of Ubuntu. No 
> release version (of Ubuntu or hal) has ever had this bug.

What about other distros?  Ubuntu isn't the world, anymore than HAL is all
that matters in userspace.

A broken version of HAL might explain the bug report, or it might not. I'd
have to track it down, and frankly, I'd rather spend precious kernel hacking
time with either option (1) or option (2) above instead.

> > Oh, I miss an undock/eject generic device keycode, too.  Can't use EJECTCD
> > to undock...
> > 
> > Again, what you want me to change in that default key code matrix that is
> > not a passive-action key?  I aimed to do the best I could according to the
> > info I have (http://thinkwiki.org/wiki/Default_meanings_of_special_keys).
> 
> Having checked other drivers, it looks like KEY_SWITCHVIDEOMODE is the 
> one used for video toggling. If that's not actually how people are using 
> it, we need to fix that - if it is, I'd just go for it.

This looks like a breakage warning to me.  Better decide once and for all
what this keycode is supposed to do, and document it.  Because switching
video mode is not "switch video output mode", and can easily be confused
with "switch screen resolution", "switch video mode between expanded and
normal" or whatever.

> As for the passive keys - I can (with a very high level of certainty) 
> assert that there is no existing userspace that will be broken by 
> sending the brightness keys. We can quibble over the volume ones, but 
> even there the breakage is minimal.

Can't we just fix the damn thing instead?  I am really, really grossed out
by that abuse of the input layer.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
