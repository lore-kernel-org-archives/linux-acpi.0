From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Sun, 15 Jul 2007 23:47:36 -0300
Message-ID: <20070716024736.GB31604@khazad-dum.debian.net>
References: <11844223334107-git-send-email-hmh@hmh.eng.br> <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net> <20070715210405.GA6216@srcf.ucam.org> <20070715215453.GJ19066@khazad-dum.debian.net> <20070715224511.GA7164@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41834 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758572AbXGPCrk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jul 2007 22:47:40 -0400
Content-Disposition: inline
In-Reply-To: <20070715224511.GA7164@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Sun, 15 Jul 2007, Matthew Garrett wrote:
> On Sun, Jul 15, 2007 at 06:54:53PM -0300, Henrique de Moraes Holschuh wrote:
> > On Sun, 15 Jul 2007, Matthew Garrett wrote:
> > > Hal is the only piece of userspace that knows how to speak to more than 
> > > one type of backlight in any useful way, which makes it the de-facto 
> > > reference for how userspace interprets these keys.
> > 
> > Since when does system-specific programs not count?
> 
> If they're Thinkpad-specific, they're already doing the right thing. If 
> they're specific to another model, they're not running on a Thinkpad.

True. I missed that angle.

> > > The fact that keys share event codes doesn't mean that these keycodes 
> > > are going to have identical semantics on all hardware. One solution to 
> > > that would be to avoid ever sending these keycodes, but that would make 
> > > having them defined in the first place a bit silly. Since they /are/ 
> > > there, it makes sense to use them.
> > 
> > I see a keycode defined in the USB HID spec for use in stuff that only knows
> > active handling -- passive doesn't even make any sense for them -- and its
> > reflect on the kernel input layer.
> > 
> > There _are_ a few platforms where *one* of the built-in devices need a
> > different handling, and that's just because the firmware won't cooperate.
> > But if I plug a USB keyboard on a thinkpad, for example, I need the proper
> > (active) handling of the event.
> 
> That's fine. You know that the event came from an external keyboard, so 
> you know that it has to be handled actively.
> 
> > I definately think "avoid ever sending these keycodes" in this instance is
> > the right way to go, until we can actually issue a "this is a passive key
> > press" event.
> 
> As I said, the existing userspace implementation disagrees. I'd prefer 
> to avoid breaking that.

I have not nearly as much patience as you do with broken designs.  The input
layer interface was *not* made to convey the idea of passive keys.  *This*
was not broken (it just wasn't generic enough, and the fact that you don't
have an extensible "flags" field that you could use to extend it *is* the
real design shortcoming).

However, abusing that interface to send passive events *is* broken.
Especially because the other side has to know by itself what is active and
what is passive, and this changes from system model to model, and maybe even
from bios version to bios version.

IMHO, it should NEVER have been done like that in the first place.  You
start walking such a road, you will have to work thrice to fix it.  The
correct thing to do is to fix the interface.  It can be done in a backwards
compatible way.  It won't be anywhere as pretty as it could have been if
input layer events were friendly to being extended, but it can be done.

Please correct me if I am mistaken, but AFAIK, nothing I do in thinkpad-acpi
that doesn't start generating *new* passive-masquerated-as-active events
around will break any old system, as these are ALREADY working using tpb or
somesuch. 

Since thinkpad-acpi not generating such broken events by default that
doesn't stop (or even make it more difficult) for new HAL to get the driver
to produce them if it wants to, and it also doesn't stop old HAL from
working just fine (using tpb, etc), it looks to me like the best path.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
