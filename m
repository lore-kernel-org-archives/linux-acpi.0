From: "Adrian Yee" <brewt-linux-acpi@brewt.org>
Subject: Re: [PATCH] ACPI: add "Fujitsu laptop extras" module
Date: Fri, 24 Aug 2007 00:24:11 -0700
Message-ID: <GMail.1187940251.19909429.55227696746@brewt.org>
References: <200708240042.l7O0gtEe022838@turbo.physics.adelaide.edu.au>
 <20070824013220.GA6242@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mini.brewt.org ([208.70.245.212]:42558 "HELO mini.brewt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756722AbXHXHax convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Aug 2007 03:30:53 -0400
In-Reply-To: <20070824013220.GA6242@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-acpi@vger.kernel.org

Hi,

I was the person who cleaned up the code a couple years back.  I don't own a
Fujitsu notebook anymore, but here's some information from what I remember.

Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > +static int acpi_fuj02b1_get_volume_state(void *data)
> 
> This probably wants to be exported as an ALSA mixer rather than a 
> special device in /proc.

My S6010 had hardware volume control (it was separate from what was ALSA
controlled).  I'm not sure if this is still the case with the Fujitsu's S and
P-series notebooks.
 
> > +static int acpi_fuj02b1_get_pointer_state(void *data)
> 
> Less sure about this one, but I'm not sure exactly what it's meant to 
> do - control whether the mouse pointer is enabled?

I never used this, but I think it gives the user the ability to disable the
built-in touchpad.  Probably driver dependent.

> > +				acpi_bus_generate_event(device, event, (u32) fuj02b1->volume_level |
> (fuj02b1->mute_state * 0x1000000) | 0x10000000);
> 
> ALSA is capable of generating events when the mixer volume changes, so I 
> don't think there's a need to explicitly generate an event here 
> (assuming you move the mixer over to ALSA)

Since the buttons control the hardware volume control, I believe the events were
more for displaying OSD volume status.

Adrian
