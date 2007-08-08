From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH] report acpi video hot key event through input
	device
Date: Wed, 08 Aug 2007 14:32:09 +0800
Message-ID: <1186554729.19883.14.camel@rzhang-asus.sh.intel.com>
References: <3877989d0707290940k3afa94d5x863599ac7c64662b@mail.gmail.com>
	 <20070730005050.GB27398@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62794 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756883AbXHHGbV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Aug 2007 02:31:21 -0400
In-Reply-To: <20070730005050.GB27398@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Luming Yu <luming.yu@gmail.com>, linux-acpi@vger.kernel.org

On Mon, 2007-07-30 at 01:50 +0100, Matthew Garrett wrote:
> On Sun, Jul 29, 2007 at 12:40:16PM -0400, Luming Yu wrote:
> >  	switch (event) {
> >  	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
> >  					 * most likely via hotkey. */
> >  		acpi_bus_generate_event(device, event, 0);
> > +		keycode = KEY_UNKNOWN;
> 
> KEY_SWITCHVIDEOMODE ?
> 
> > 
> >  	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
> > @@ -1734,21 +1741,37 @@ static void acpi_video_bus_notify(acpi_h
> >  		acpi_video_device_rebind(video);
> >  		acpi_video_switch_output(video, event);
> >  		acpi_bus_generate_event(device, event, 0);
> > +		keycode = KEY_UNKNOWN;
> >  		break;
> 
> Here too.
> 
> >  	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
> >  	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
> >  		acpi_bus_generate_event(device, event, 0);
> > +		keycode = KEY_UNKNOWN;
> >  		break;
> 
> And these? I'm not sure in this case, though.

ACPI_VIDEO_NOTIFY_SWITCH and ACPI_VIDEO_NOTIFY_PROBE
are only valid for Display devices.
Should output devices handle this kind of events?
IMO, we should remove this piece of code.

Thanks,
Rui
