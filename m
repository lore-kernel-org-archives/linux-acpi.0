From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] ACPI: thinkpad-acpi: add input device support
	to hotkey subdriver
Date: Mon, 16 Jul 2007 15:19:11 -0300
Message-ID: <20070716181911.GA13710@khazad-dum.debian.net>
References: <20070714223144.GA25782@srcf.ucam.org> <20070715181233.GG14134@khazad-dum.debian.net> <20070715184519.GD3235@srcf.ucam.org> <20070715200338.GB19066@khazad-dum.debian.net> <20070715201201.GA5518@srcf.ucam.org> <20070715205934.GF19066@khazad-dum.debian.net> <20070715210405.GA6216@srcf.ucam.org> <20070715215453.GJ19066@khazad-dum.debian.net> <d120d5000707160846m541ddd33uccdb5387ee9ee1c3@mail.gmail.com> <20070716155103.GB19199@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38877 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751047AbXGPSTQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2007 14:19:16 -0400
Content-Disposition: inline
In-Reply-To: <20070716155103.GB19199@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Mon, 16 Jul 2007, Matthew Garrett wrote:
> On Mon, Jul 16, 2007 at 11:46:26AM -0400, Dmitry Torokhov wrote:
> > How do you know that this is a "passive keypress"? Can you put another
> > (better) soundcard in a docking station? Woudl the firmware still
> > control that card (doubtful)? Do we want the same keys to control that
> > card's volume?
> 
> This is absolutely possible. In that case I'd expect the hotkeys to 
> start controlling the card mixer's volume, but that's a policy decision 
> that would have to be taken in userspace by an application aware of 
> everything that's happened.

The moment you screw up with the thinkpad builtin mixer, you are screwing
with the emergency notification system (system beeps).  They go *only*
through that mixer, and their signal is not routed through the builtin AC97
(and probably not through HDA either) mixers.   I would stay well away from
trying to override what these buttons do.

In fact, the thinkpad volume buttons are (in most thinkpads, I don't speak
for the new *61 models, they may be different) the "button version" of a
small volume dial near the headphone jack.

They were NOT made to be used in any other way, they DO NOT work in any
other way in Windows, and the firmware does NOT cooperate to let you use
them in any other way.

This whole issue is mainly caused by a refusal to understand this simple
fact.  THOSE BUTTONS ARE NOT GENERIC VOLUME CONTROL BUTTONS unless you hack
the firmware on anything but the very newest X61, R61 and T61... and maybe
even on them.

(and if you hack the firmware, you can get thinkpad-acpi to do what you want
with just the right sysfs setting).

IMO, if you want to use hot keys to control the AC97/HDA/soundcard mixer
volume in a typical thinkpad where the volume buttons are handled in
firmware, just assign Fn+Insert and Fn+delete to VOLUME_UP and VOLUME_DOWN,
they are right to the side of HOME/END (brightness up/down) anyway.

Anyway, if the input layer is really not the place for "passive key
presses", then my decision to not issue input events for such stuff is the
correct one.

Brightness can be notified through ACPI (ACPI 3.0b has standard events for
this), or it could be done through an improved backlight sysfs class.  It
will require work either way, because you don't want ACPI video processing
these synthezised events, or because you need to get backlight to be
poll()/select() or inotify()-friendly if you don't want to add another
dumbass userspace polling loop.

Built-in headphone/speaker volume can be notified and controlled through an
ALSA mixer.  It won't be a nice poll-less thing, but I can trap the ACPI hot
key events as a hint to update the mixer state, and if ALSA lets me do it,
issue mixer changed notifications.

And thinklight toggle key presses can be notified through the LED class,
although that one is such an useless notification, that I simply don't know
if I should bother with it.

That covers all thinkpad "passive" EV_KEY events.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
