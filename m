From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 9 Oct 2007 11:29:34 -0300
Message-ID: <20071009142934.GB444@khazad-dum.debian.net>
References: <1191910875.9847.79.camel@queen.suse.de> <20071009075914.GA790@srcf.ucam.org> <1191918351.9847.132.camel@queen.suse.de> <20071009083336.GA1099@srcf.ucam.org> <1191923208.9847.169.camel@queen.suse.de> <20071009100418.GA2472@srcf.ucam.org> <20071009111445.GB24946@khazad-dum.debian.net> <1191936552.9847.257.camel@queen.suse.de> <20071009134711.GA444@khazad-dum.debian.net> <1191939088.9847.274.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45924 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752744AbXJIO3n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Oct 2007 10:29:43 -0400
Content-Disposition: inline
In-Reply-To: <1191939088.9847.274.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 09 Oct 2007, Thomas Renninger wrote:
> On Tue, 2007-10-09 at 10:47 -0300, Henrique de Moraes Holschuh wrote:
> > On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > > No, all the _BCL poking should vanish.
> > 
> > I need to *somehow* find out if the thinkpad supports the video extensions.
> 
> Maybe in scan.c:acpi_video_bus_match() we could add a quirk like:
> 
> if (ThinkPad){
>  if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCM", &h_dummy1)) &&
>  ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCL", &h_dummy2))) &&
>  return 0;
> else
>  return -ENODEV;
> 
> This would make the video module only load on thinkpads if the
> brightness functions are implemented.

The video module handles a lot more than just backlight.  I am not going to
make thinkpad-acpi disable the video module in any way.

Output switching is another area where thinkpad-acpi and video duplicate
functionality, and frankly, I have no idea which ones works, and how well,
and in which thinkpads.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
