From: Thomas Renninger <trenn@suse.de>
Subject: Re: [ibm-acpi-devel] How to distinguish between general ACPI video
	driver module and	brightness/display providing vendor specific ACPI modules
Date: Wed, 10 Oct 2007 13:44:17 +0200
Message-ID: <1192016657.9847.319.camel@queen.suse.de>
References: <1191910875.9847.79.camel@queen.suse.de>
	 <20071009075914.GA790@srcf.ucam.org>
	 <1191918351.9847.132.camel@queen.suse.de>
	 <20071009083336.GA1099@srcf.ucam.org>
	 <1191923208.9847.169.camel@queen.suse.de>
	 <20071009100418.GA2472@srcf.ucam.org>
	 <20071009111445.GB24946@khazad-dum.debian.net>
	 <1191936552.9847.257.camel@queen.suse.de>
	 <20071009134711.GA444@khazad-dum.debian.net>
	 <1191939088.9847.274.camel@queen.suse.de>
	 <20071009142934.GB444@khazad-dum.debian.net>
	 <1191963205.3880.58.camel@fanta4.site>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50533 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbXJJLo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 07:44:26 -0400
In-Reply-To: <1191963205.3880.58.camel@fanta4.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, 2007-10-09 at 22:53 +0200, Thomas Renninger wrote:
> On Tue, 2007-10-09 at 11:29 -0300, Henrique de Moraes Holschuh wrote:
> > On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > > On Tue, 2007-10-09 at 10:47 -0300, Henrique de Moraes Holschuh wrote:
> > > > On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > > > > No, all the _BCL poking should vanish.
> > > > 
> > > > I need to *somehow* find out if the thinkpad supports the video extensions.
> > > 
> > > Maybe in scan.c:acpi_video_bus_match() we could add a quirk like:
> > > 
> > > if (ThinkPad){
> > >  if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCM", &h_dummy1)) &&
> > >  ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCL", &h_dummy2))) &&
> > >  return 0;
> > > else
> > >  return -ENODEV;
> > > 
> > > This would make the video module only load on thinkpads if the
> > > brightness functions are implemented.
> > 
> > The video module handles a lot more than just backlight.  I am not going to
> > make thinkpad-acpi disable the video module in any way.
> > 
> > Output switching is another area where thinkpad-acpi and video duplicate
> > functionality, and frankly, I have no idea which ones works, and how well,
> > and in which thinkpads.
> Me too...
> So we have the thinkpad_acpi and other vendor specific drivers and the
> general video module, for the latter we want to go for (but was/is
> rather untested compared to the others).
> 
> What about:
> We could compile in a global bit field that gets filled in
> video_bus_match in scan.c whether all required brightness functions are
> available and another bit reserved for whether all needed video/display
> functions are available. This can be done at early ACPI parse time
> before any module got loaded.
> ThinkPad and other vendor specific modules could then not touch video or
> brightness by checking this global bit field.
> Video serves brightness and/or display switching if required functions
> are available by default the others take their hands off then.

Unfortunately, I don't have much time (at least the next days) to help
here much.

IMO this should work. Like that there is no need in Thinkpad to fiddle
with hardcoded "\\_SB.../_BCL" paths to find out whether brightness is
supported. Just check for a global variable video_funcs_supported ->
take hands off display switching and brightness_funcs_supported -> take
hands off brightness control. This should work out fine for other vendor
specific drivers also.

FYI:
1)
If I read the thinkpad code right, it always relies on that brightness
level can be read through EC at address 0x31?
I have a T60 here where this does not work, I can switch (only in
console) the brightness levels and there is no change in at any ec
address. So this really must use _BCM,_BCL?

2)
I also found in my X logs on a T60:
(WW) NVIDIA(0): Error: Unable to find DOS (Enable/Disable output switching)
(WW) NVIDIA(0):     file path under /proc/acpi/video. NVIDIA X driver will not
(WW) NVIDIA(0):     be able to respond to  display change hotkey events.
Intel graphics drivers and possibly others probably also want to make
use of this.
So I think switching to video driver here (thinkpad must not touch this
then anymore I expect) makes a lot of sense. I wonder how many
people/tools made use of /proc/acpi/ibm/video?

3)
I think I found a bug in thinkpad_acpi:
	if (!*ibm->acpi->handle)
		return 0;
in setup_acpi_notify(..) probably should be:
	if (!ibm->acpi->handle)
		return 0;

   Thomas

