From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ltp] Re: [PATCH] Set osi=Linux for the ThinkPad X200s
Date: Tue, 10 Nov 2009 15:49:08 -0200
Message-ID: <20091110174908.GC23283@khazad-dum.debian.net>
References: <cb0375e10911090847n4880f048ga0ef68bf41f968c9@mail.gmail.com>
 <20091109165420.GA28672@srcf.ucam.org>
 <cb0375e10911090949o4a51cfd5x4f896d983398a7bc@mail.gmail.com>
 <20091109175416.GA29887@srcf.ucam.org>
 <20091110092418.GC1872@khazad-dum.debian.net>
 <cb0375e10911100532l484e69aeyd78e422c23d730ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58334 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757417AbZKJRtH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2009 12:49:07 -0500
Content-Disposition: inline
In-Reply-To: <cb0375e10911100532l484e69aeyd78e422c23d730ce@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Lutomirski <luto@mit.edu>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-thinkpad@linux-thinkpad.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, 10 Nov 2009, Andrew Lutomirski wrote:
> On Tue, Nov 10, 2009 at 4:24 AM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
> > On Mon, 09 Nov 2009, Matthew Garrett wrote:
> >> When you hit the mixer button, does the ACPI interrupt count incre=
ase?
> >> If so, we're certainly in a position to do something with it.
> >
> > It is supposed to go over the KDC. =A0But I would be _really_ inter=
ested on
> > any events related to volume key presses on the X200s. =A0I expect =
it is
> > issuing one of the ACPI volume notification events with OSI(Linux),=
 and none
> > without.
>=20
> On brief inspection, with OSI(Linux), mute generates no ACPI
> interrupts.  Without OSI(Linux), I see an ACPI interrupt only when th=
e
> mixer (the one in /proc/acpi/ibm/volume) changes as a result of
> muting.  So pushing mute once generates an interrupt, but then there
> are no more interrupts until I push volume up.

This makes sense.  Mute is for muting, volume up/down is for unmuting a=
nd
volume control.  Likely, after the unmute happened, futher presses of
volume up/down will go through the KDC and be reported as normal key
presses.

We just need to track down where that ACPI interrupt is going, then.

> What's the point of the IBM mixer (/proc/acpi/ibm/volume)?  We have a
> perfectly good mixer in the form of ALSA, which already knows how to
> mute and unmute the sound and even comes with nice user interfaces
> these days.

I need to finish cleaning up volume, so that I will haver enough courag=
e to
export it as an ALSA mixer.  I am working on that right now, actually, =
and
now that I figured out why I had this queasy feeling that caused me to =
never
merge ALSA support and I am in the process of fixing the code in questi=
on,
the ALSA mixer should finally get merged for real.

> volume key.  But pressing that different hardware volume key *also*
> changes the ALSA mixer because it generates a keypress.  In my book,
> that means that the mute button messes up the sound hardware.

Please test WITHOUT OSI(Linux).  When you press volume up/down to UNMUT=
E,
does it still send the key over the KDC as well?  It should "eat" that
keypress and not report it anywere...

> Do we really want every thinkpad to need a special UI to indicate the
> state of the extra hardware muting function?

We want an ALSA mixer, and it will happen, now that I am rewriting the
volume code into something that won't give me nightmares.  The other
difficult stuff has been taken care of already (such as decoupling firm=
ware
events from userspace-visible events).

Just remember one thing: thinkpad-acpi is _OLD_.  It used to be called
ibm-acpi, and it has been around since 2.6.12.  It has private interfac=
es
for a lot of stuff because it predates the generic interfaces for quite=
 a
bit. I don't know if we had ALSA on 2.6.12, but I do know we were not b=
ig on
ALSA or generic interfaces back then.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
