From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ibm-acpi-devel] How to distinguish between general ACPI video
	driver module and brightness/display providing vendor specific ACPI
	modules
Date: Wed, 10 Oct 2007 17:46:32 -0300
Message-ID: <20071010204632.GA509@khazad-dum.debian.net>
References: <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org> <20071009111445.GB24946@khazad-dum.debian.net> <1191936552.9847.257.camel@queen.suse.de> <20071009134711.GA444@khazad-dum.debian.net> <1191939088.9847.274.camel@queen.suse.de> <20071009142934.GB444@khazad-dum.debian.net> <1191963205.3880.58.camel@fanta4.site> <1192016657.9847.319.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35057 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756045AbXJJUql (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 16:46:41 -0400
Content-Disposition: inline
In-Reply-To: <1192016657.9847.319.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wed, 10 Oct 2007, Thomas Renninger wrote:
> IMO this should work. Like that there is no need in Thinkpad to fiddle
> with hardcoded "\\_SB.../_BCL" paths to find out whether brightness is
> supported. Just check for a global variable video_funcs_supported ->
> take hands off display switching and brightness_funcs_supported -> take
> hands off brightness control. This should work out fine for other vendor
> specific drivers also.

Well, provided that these drives do work.  I am not sure they do on older
thinkpads, etc.

> If I read the thinkpad code right, it always relies on that brightness
> level can be read through EC at address 0x31?

No.  It can get it from NVRAM too in the latest code, and it will do the
right thing on the newer Lenovo BIOSes.

> I have a T60 here where this does not work, I can switch (only in
> console) the brightness levels and there is no change in at any ec
> address. So this really must use _BCM,_BCL?

See above.  But you do need a *very* recent thinkpad-acpi.  I.e. what is in
acpi-test, or what is in my development versions.

But it *is* still better to use _BCM, _BCL, _BQC when available.

> 2)
> I also found in my X logs on a T60:
> (WW) NVIDIA(0): Error: Unable to find DOS (Enable/Disable output switching)
> (WW) NVIDIA(0):     file path under /proc/acpi/video. NVIDIA X driver will not
> (WW) NVIDIA(0):     be able to respond to  display change hotkey events.
> Intel graphics drivers and possibly others probably also want to make
> use of this.
> So I think switching to video driver here (thinkpad must not touch this
> then anymore I expect) makes a lot of sense. I wonder how many
> people/tools made use of /proc/acpi/ibm/video?

Probably not many.  I really, really refrain from touching that because it
is a rats nest of trouble.

But it *does* work for some people, so I am not fine with the idea of just
ripping it off, unless we know video does at least as well on those
thinkpads.

> 3)
> I think I found a bug in thinkpad_acpi:
> 	if (!*ibm->acpi->handle)
> 		return 0;
> in setup_acpi_notify(..) probably should be:
> 	if (!ibm->acpi->handle)
> 		return 0;

I will check that.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
