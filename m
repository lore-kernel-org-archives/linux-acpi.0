From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 11:21:38 +0930 (CST)
Message-ID: <200708240151.l7O1pcCP026098@turbo.physics.adelaide.edu.au>
References: <20070824013220.GA6242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:55840 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756181AbXHXBvo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 21:51:44 -0400
In-Reply-To: <20070824013220.GA6242@srcf.ucam.org> from "Matthew Garrett" at Aug 24, 2007 02:32:21 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

Thanks for the feedback.

> > +static int acpi_fuj02b1_get_volume_state(void *data)
> 
> This probably wants to be exported as an ALSA mixer rather than a 
> special device in /proc.

Or dropped altogether.  As I mentioned, this patch is simply something I
picked up off the net.  The only really important component I need from it
is the brightness control which will allow resume from suspend-to-ram to
turn the backlight back on.  I personally don't see much point in the volume
control because the sound chipset (at least on my laptop) already works fine
through ALSA.  Unless this is a totally separate volume control.

> > +static int acpi_fuj02b1_get_brightness_state(void *data)
> 
> And this certainly wants to use the backlight class.

Sounds fine to me - I'm all for standardisation.  Do you have any pointers
as to how I might get started on doing this?  A "typical" driver I could
look at perhaps?

> > +static int acpi_fuj02b1_get_pointer_state(void *data)
> 
> Less sure about this one, but I'm not sure exactly what it's meant to 
> do - control whether the mouse pointer is enabled?

As far as I can tell yes - it controls the (hardware) mouse pointer.  Again,
I'm happy to loose this one since I can see very little (if any) practical
use for it.

> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->volume_level | (fuj02b1->mute_state * 0x1000000) | 0x10000000);
> 
> ALSA is capable of generating events when the mixer volume changes, so I 
> don't think there's a need to explicitly generate an event here 
> (assuming you move the mixer over to ALSA)

As I mentioned, I'd be happy to drop the mixer thing (at least for now)
unless I can find any evidence that it's even remotely useful.

> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->brightness_level | 0x20000000);
> 
> There's some disagreement over how to do this correctly. The currently 
> implemented way is for you to send KEY_BRIGHTNESSUP or 
> KEY_BRIGHTNESSDOWN and then let any userspace application check HAL to 
> determine whether it should do anything (we'd add an entry for Fujitsus 
> to indicate that the keys were merely notifications rather than 
> instructions), but there's also the argument that these keys should only 
> be used if they're acting as instructions to the software.

In the first instance I suspect there's probably no need to notify userspace
of when these keys are pressed.  The keys themselves already affect the
screen brightness via the hardware so there seems little point on
complicating things by passing them onto userspace.

> The idea here is to present consistent interfaces whenever possible, 
> allowing software to make use of them without having to know anything 
> about the specifics of the Fujitsu hardware. The drivers currently in 
> the kernel are gradually being ported over to this.

Sounds great in theory.  Are there any documents around which summarise the
APCI system and how it fits in with the whole backlight class?  Or is it a
case of having to deduce all this by going though the source?

Regards
  jonathan
