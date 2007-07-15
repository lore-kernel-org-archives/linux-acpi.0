From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Sun, 15 Jul 2007 18:54:53 -0300
Message-ID: <20070715215453.GJ19066@khazad-dum.debian.net>
References: <11844223322928-git-send-email-hmh@hmh.eng.br> <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net> <20070715210405.GA6216@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49643 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752345AbXGOVy7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 17:54:59 -0400
Content-Disposition: inline
In-Reply-To: <20070715210405.GA6216@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 05:59:34PM -0300, Henrique de Moraes Holschuh wrote:
> > *HAL* does.  HAL is *not* all there is to userspace.  The input layer is not
> > an interface between the kernel and HAL, it is an interface between kernel
> > and userspace.
> 
> Hal is the only piece of userspace that knows how to speak to more than 
> one type of backlight in any useful way, which makes it the de-facto 
> reference for how userspace interprets these keys.

Since when does system-specific programs not count?

Anyway, the idea of "special cases" that are not exposed anywhere and
requires out-of-band information to be handled correctly is just broken IMO.
This goes triple for an interface whose only canon documentation is the
current kernel code, so you can't even tell people to read somewhere how to
properly use it.

Since we have detected the need for passive events, I'd much rather that
information was added to the input layer itself, instead of being
synthesized later.

> > Add that knowledge to the input layer, and I will agree.  Add it to every
> > consumer of input events, and I will concede.  Until then, it is good that
> > HAL can overcome the lack of such information in the input layer, but that
> > doesn't make it the right way to use the input layer.
> 
> The fact that keys share event codes doesn't mean that these keycodes 
> are going to have identical semantics on all hardware. One solution to 
> that would be to avoid ever sending these keycodes, but that would make 
> having them defined in the first place a bit silly. Since they /are/ 
> there, it makes sense to use them.

I see a keycode defined in the USB HID spec for use in stuff that only knows
active handling -- passive doesn't even make any sense for them -- and its
reflect on the kernel input layer.

There _are_ a few platforms where *one* of the built-in devices need a
different handling, and that's just because the firmware won't cooperate.
But if I plug a USB keyboard on a thinkpad, for example, I need the proper
(active) handling of the event.

I definately think "avoid ever sending these keycodes" in this instance is
the right way to go, until we can actually issue a "this is a passive key
press" event.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
