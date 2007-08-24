From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 11:55:41 +0800
Message-ID: <1187927741.2691.43.camel@acpi-hp.sh.intel.com>
References: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au>
	 <20070824013220.GA6242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26277 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXHXDzq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 23:55:46 -0400
In-Reply-To: <20070824013220.GA6242@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-acpi@vger.kernel.org

On Fri, 2007-08-24 at 02:32 +0100, Matthew Garrett wrote:
> > +static int acpi_fuj02b1_get_volume_state(void *data)
> 
> This probably wants to be exported as an ALSA mixer rather than a 
> special device in /proc.
> 
> > +static int acpi_fuj02b1_get_brightness_state(void *data)
> 
> And this certainly wants to use the backlight class.
> 
> > +static int acpi_fuj02b1_get_pointer_state(void *data)
> 
> Less sure about this one, but I'm not sure exactly what it's meant to 
> do - control whether the mouse pointer is enabled?
> 
> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->volume_level | (fuj02b1->mute_state * 0x1000000) | 0x10000000);
> 
> ALSA is capable of generating events when the mixer volume changes, so I 
> don't think there's a need to explicitly generate an event here 
> (assuming you move the mixer over to ALSA)
> 
> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->brightness_level | 0x20000000);
> 
> There's some disagreement over how to do this correctly. The currently 
> implemented way is for you to send KEY_BRIGHTNESSUP or 
> KEY_BRIGHTNESSDOWN and then let any userspace application check HAL to 
> determine whether it should do anything (we'd add an entry for Fujitsus 
> to indicate that the keys were merely notifications rather than 
> instructions), but there's also the argument that these keys should only 
> be used if they're acting as instructions to the software.
> 
I have the same question for ACPI video driver.
Take KEY_BRIGHTNESSUP/KEY_BRIGHTNESSDOWN for example, if ACPI video
driver gets such a notification, it will change the brightness level
first and then send an event to user space.
But IMO, what the driver need to do is to provide a user space I/F
first, /sys/class/backlight/acpi_videox/... in this case, and send a
notification when keys are pressed.
Any comments about this?
I'll send a patch to make ACPI video driver do nothing but export the
events to user space in the notify handler if you guys think it's okay.

Thanks,
Rui

> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->pointer_state | 0x30000000);
> 
> What this one should do depends on what the pointer state actually means 
> :)
> 
> The idea here is to present consistent interfaces whenever possible, 
> allowing software to make use of them without having to know anything 
> about the specifics of the Fujitsu hardware. The drivers currently in 
> the kernel are gradually being ported over to this.
> 
