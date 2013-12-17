From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 0/5] hooking udev to SW_TABLET_MODE changes
Date: Tue, 17 Dec 2013 17:16:30 -0200
Message-ID: <20131217191630.GA32623@khazad-dum.debian.net>
References: <1387234814-17716-1-git-send-email-carlosg@gnome.org>
 <20131217000332.GA10466@khazad-dum.debian.net>
 <1387282004.15078.59.camel@sacarino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43233 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750866Ab3LQTQe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Dec 2013 14:16:34 -0500
Content-Disposition: inline
In-Reply-To: <1387282004.15078.59.camel@sacarino>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Garnacho <carlosg@gnome.org>
Cc: linux-acpi@vger.kernel.org

On Tue, 17 Dec 2013, Carlos Garnacho wrote:
> On lun, 2013-12-16 at 22:03 -0200, Henrique de Moraes Holschuh wrote:
> > On Tue, 17 Dec 2013, Carlos Garnacho wrote:
> > > The following patches make it possible to have udev/userspace notified when
> > > SW_TABLET_MODE changes on the switch device, without having to resort to
> > > poll()/select() for such sparse events. I've got udev patches locally to
> > > complement this.
> > 
> > I don't like this.  We moved away from uevents for this kind of stuff (in
> > the general sense) because they, to put it lightly, are NOT appropriate for
> > input-event-like events.
> 
> I would like to know... not appropriate how? I can understand this rule

uevents are: heavy-weight, slow, the wrong layer for this stuff (we ended up
mixing important device infrastructure topology/configuration change events
(what it was designed to be used for) with misc user-interface events, thus
making everything more brittle since userspace has to handle it all in the
same place).  They are not power-management-friendly, not scalable as
implemented, not filterable kernel-side, and not versioned.  uevents also
have closer ties to internal kernel models than necessary for
non-device-infrastructure related events (sysfs has it much worse, but
still).

All of those issues are much better addressed by the input events layer,
which was designed from the ground up to better deal with moderate-frequency
user-interface/input events.

> applies for too often events, as some input devices can get quite
> chatty, but the frequency of these uevents is tremendously low. FWIW,

All you need to do is to spin the tablet/laptop/mobile device.  We once
thought backlight change events would be low-frequency too, and it is
causing real problems...

I don't think it is wise to be one sucessfull game away ("spintron, the new
game where you take a photo of something/someone and spin your tablet to do
funny things to it") from that much pain.  So, you need to add
rate-limiters, and since it *is* input events we're talking about, these are
low-latency, state-preserving rate-limiters (which must emit the first and
last events in a chain without much extra latency or it will feel sluggish
to the user, must break long chains, and preserve the effects of supressed
events).

> there is precedence of uevents on input devices in the asus-laptop
> module [1], where the accelerometer reports uevents on "coarse
> orientation changes".

That doesn't make it a good idea.

> > Moving any sort of input event back to uevents is something I do NOT want to
> > support, ever.  Any userspace that wants it for backwards compatibility can,
> > and DOES synthesize uevents from input events.
> 
> I'm not proposing "moving back", but "complementing", the device still
> has to be poked. The problem I see with awaiting for input events in
> userspace in this case is that there is no good place to have this done.

You'd just have to deploy a proper generic input event handler that could
map any sort of native X, native Linux input events, or native Wayland input
events to actions.  Indeed, if there is no such beast already, you'd need to
add it.

> My first attempt time ago was doing this in UPower, because it is
> already in the business of reading input events, but it was deemed too
> unrelated [2]. The next option is having a dedicated daemon, listening
> for an event that's very probably not doing to happen at all during
> uptime... sounds pretty wasteful to me.

Well, a dedicated daemon IS the unix way, and it is only wasteful if you
want it to be.  You could make it the xinetd of input events (probably with
builtin actions that generate DBUS events and other up-to-date desktopish
stuff), and it would be of general use (and rather useful at that, IMHO).

Or you could make it a very specialized small utility where the entire bloat
comes from the fact that it is linked to glibc, and it will have a very
small RSS... there are several like that already, I believe.

> > So, can you make a very strong case for this uevent?
> 
> Well, the above. I could add that the accelerometer uevent I pointed out
> is put in use in udev and the GNOME stack, I think it makes sense to
> give tablet-mode changes a similar treatment, so establishing policies
> and whatnot is saner. And I think most of the userspace that's
> interested in these events would want that too, with maybe exotic
> exceptions.

The big deal here is that, if we do that, we will basically have to live
with it for a decade or more... and we already know uevents are not a very
suitable event delivery system for low-frequency user-interface/input
events, and it is utterly unsuitable for high-frequency events regardless of
type (you need to compress/supress them into low-frequency events).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
