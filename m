From: Thomas Renninger <trenn@suse.de>
Subject: How to distinguish between general ACPI video driver module and
	brightness/display providing vendor specific ACPI modules
Date: Tue, 09 Oct 2007 22:53:25 +0200
Message-ID: <1191963205.3880.58.camel@fanta4.site>
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
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53670 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbXJIUxG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 16:53:06 -0400
In-Reply-To: <20071009142934.GB444@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 11:29 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > On Tue, 2007-10-09 at 10:47 -0300, Henrique de Moraes Holschuh wrote:
> > > On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > > > No, all the _BCL poking should vanish.
> > > 
> > > I need to *somehow* find out if the thinkpad supports the video extensions.
> > 
> > Maybe in scan.c:acpi_video_bus_match() we could add a quirk like:
> > 
> > if (ThinkPad){
> >  if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCM", &h_dummy1)) &&
> >  ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCL", &h_dummy2))) &&
> >  return 0;
> > else
> >  return -ENODEV;
> > 
> > This would make the video module only load on thinkpads if the
> > brightness functions are implemented.
> 
> The video module handles a lot more than just backlight.  I am not going to
> make thinkpad-acpi disable the video module in any way.
> 
> Output switching is another area where thinkpad-acpi and video duplicate
> functionality, and frankly, I have no idea which ones works, and how well,
> and in which thinkpads.
Me too...
So we have the thinkpad_acpi and other vendor specific drivers and the
general video module, for the latter we want to go for (but was/is
rather untested compared to the others).

What about:
We could compile in a global bit field that gets filled in
video_bus_match in scan.c whether all required brightness functions are
available and another bit reserved for whether all needed video/display
functions are available. This can be done at early ACPI parse time
before any module got loaded.
ThinkPad and other vendor specific modules could then not touch video or
brightness by checking this global bit field.
Video serves brightness and/or display switching if required functions
are available by default the others take their hands off then.

Have I overseen something? Does this make sense?

And now the problem:
Vendor specific drivers might better know whether a machine should get
blacklisted and still should be served by the vendor specific module,
again I'd split up brightness and display/video switching functionality.
Blacklisting might be done by module param to find out machines not
working with the general video module without hurting anyone and for
easy testing and more important, automatically via dmi/DSDT or whatever
blacklisting info. *But* the general video driver will just start
working on these functions if loaded first.
I have no nice idea how to solve that.
The only thing that comes to my mind is to enforce somehow that vendor
specific modules are loaded first and then set something like
disable_video_brightness/disable_video_display global ACPI variables
which the general video driver evaluates when it's loaded afterwards and
in turn doesn't touch these functions even if available.
Not sure whether it can be enforced via udev (in kernel by sending the
uevent for LNXVIDEO as the last one, or by even more ugly userspace
rules...).

Maybe the suggestions after "And now the problem" are a bit overdosed
and the part "What about" is enough and we drive well with such an
approach? -> Just let video serve it's functions which it is designed
for and add fixes/workarounds there if they pop up, no need for vendor
specific workarounds, unfortunately also not possible, at least they
must be located in the video driver itself then.

    Thomas

