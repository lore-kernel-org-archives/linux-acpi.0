From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 3/4] ACPI: thinkpad-acpi: disable backlight handler if
	ACPI generic could do it
Date: Tue, 09 Oct 2007 16:11:27 +0200
Message-ID: <1191939088.9847.274.camel@queen.suse.de>
References: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
	 <1191849179-24087-4-git-send-email-hmh@hmh.eng.br>
	 <1191910875.9847.79.camel@queen.suse.de>
	 <20071009075914.GA790@srcf.ucam.org>
	 <1191918351.9847.132.camel@queen.suse.de>
	 <20071009083336.GA1099@srcf.ucam.org>
	 <1191923208.9847.169.camel@queen.suse.de>
	 <20071009100418.GA2472@srcf.ucam.org>
	 <20071009111445.GB24946@khazad-dum.debian.net>
	 <1191936552.9847.257.camel@queen.suse.de>
	 <20071009134711.GA444@khazad-dum.debian.net>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:38996 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbXJIOLg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 10:11:36 -0400
In-Reply-To: <20071009134711.GA444@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, 2007-10-09 at 10:47 -0300, Henrique de Moraes Holschuh wrote:
> On Tue, 09 Oct 2007, Thomas Renninger wrote:
> > > Error prone how?  Please expand, because right now I am not inclined to
> > > remove that variable.  It is optional, and disabled by default.  Distros are
> > > not going to enable it unless they have a damn good reason to, and it is not
> > > even something that one can enable at runtime.
> > > 
> > > Should I make the help text stronger against enabling the option? Is it not
> > > clear enough?
> >
> > No, all the _BCL poking should vanish.
> 
> I need to *somehow* find out if the thinkpad supports the video extensions.

Maybe in scan.c:acpi_video_bus_match() we could add a quirk like:

if (ThinkPad){
 if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCM", &h_dummy1)) &&
 ACPI_SUCCESS(acpi_get_handle(device->handle, "_BCL", &h_dummy2))) &&
 return 0;
else
 return -ENODEV;

This would make the video module only load on thinkpads if the
brightness functions are implemented.
Then the double register could work with this one check, or you are
right, it needs to be checked again in the thinkpad module explicitly.

   Thomas

