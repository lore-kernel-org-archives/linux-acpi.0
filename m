From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 03:33:41 +0100
Message-ID: <20070824023340.GA7025@srcf.ucam.org>
References: <20070824013220.GA6242@srcf.ucam.org> <200708240151.l7O1pcCP026098@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 78-32-9-130.no-dns-yet.enta.net ([78.32.9.130]:50101 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S933162AbXHXCds (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Aug 2007 22:33:48 -0400
Content-Disposition: inline
In-Reply-To: <200708240151.l7O1pcCP026098@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org

On Fri, Aug 24, 2007 at 11:21:38AM +0930, Jonathan Woithe wrote:
> > This probably wants to be exported as an ALSA mixer rather than a 
> > special device in /proc.
> 
> Or dropped altogether.  As I mentioned, this patch is simply something I
> picked up off the net.  The only really important component I need from it
> is the brightness control which will allow resume from suspend-to-ram to
> turn the backlight back on.  I personally don't see much point in the volume
> control because the sound chipset (at least on my laptop) already works fine
> through ALSA.  Unless this is a totally separate volume control.

Yeah. It would be good if you could figure out if it alters behaviour 
entirely independently of the rest of the mixer hardware (Thinkpads do 
that) - the easiest way is probably to set it to 0 and see if you can 
still get the machine to make noise after playing with the soundcard 
mixers. If not, it's worth exporting. If it still is, do it.

> > And this certainly wants to use the backlight class.
> 
> Sounds fine to me - I'm all for standardisation.  Do you have any pointers
> as to how I might get started on doing this?  A "typical" driver I could
> look at perhaps?

Take a look at asus_acpi in recent kernels, and also the drivers under 
drivers/video/backlight

> > Less sure about this one, but I'm not sure exactly what it's meant to 
> > do - control whether the mouse pointer is enabled?
> 
> As far as I can tell yes - it controls the (hardware) mouse pointer.  Again,
> I'm happy to loose this one since I can see very little (if any) practical
> use for it.

It sounds potentially useful (some users seem to like toggling that for 
some reason), but I'm not sure what the best way of exporting it would 
be. Is there a key on the keyboard that controls it? If so, does it work 
without needing a driver?

> > There's some disagreement over how to do this correctly. The currently 
> > implemented way is for you to send KEY_BRIGHTNESSUP or 
> > KEY_BRIGHTNESSDOWN and then let any userspace application check HAL to 
> > determine whether it should do anything (we'd add an entry for Fujitsus 
> > to indicate that the keys were merely notifications rather than 
> > instructions), but there's also the argument that these keys should only 
> > be used if they're acting as instructions to the software.
> 
> In the first instance I suspect there's probably no need to notify userspace
> of when these keys are pressed.  The keys themselves already affect the
> screen brightness via the hardware so there seems little point on
> complicating things by passing them onto userspace.

The main reason for doing so is to let a userspace application pop up a 
little box to show what the screen brightness is.

> > The idea here is to present consistent interfaces whenever possible, 
> > allowing software to make use of them without having to know anything 
> > about the specifics of the Fujitsu hardware. The drivers currently in 
> > the kernel are gradually being ported over to this.
> 
> Sounds great in theory.  Are there any documents around which summarise the
> APCI system and how it fits in with the whole backlight class?  Or is it a
> case of having to deduce all this by going though the source?

I haven't seen any docs on this - I just copied stuff out of the 
existing ones.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
