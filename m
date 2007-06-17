From: Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH v2] ACPI video: poke display on lid open
Date: Sun, 17 Jun 2007 01:18:53 -0400
Message-ID: <4674C43D.8090104@gentoo.org>
References: <20070617000321.37F407B409F@zog.reactivated.net> <200706170008.34157.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp165.iad.emailsrvr.com ([207.97.245.165]:54590 "EHLO
	smtp165.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbXFQFTw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Jun 2007 01:19:52 -0400
In-Reply-To: <200706170008.34157.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org

Dmitry Torokhov wrote:
> If we do not support multiple LIDs -EBUSY would be a better error code.

OK.

> Need to setup handler->name, otherwise "cat /proc/bus/input/devices" looks
> "interesting".

OK.

> Safe from what? I don't see anything altering list state in the body
> of this loop. Where's list locking?

The current driver has no list locking. I iterate over the list in the 
way that the rest of the code does.

 > Also, once input core locking is
> in place handler_>event will be called under a spinlock with interrupts
> off. Can acpi_video_device_set_state be used in this case? 

I'm not sure, hopefully someone with more ACPI knowledge can pipe up here...

> Below is a small cleanup patch you may want to fold into yours.

Thanks, makes sense.

> But I guess more important question if this is a good solution overall.
> My box already generates video bus events when I close and open the lid
> so maybe video.c should just call acpi_video__device_set_state() from
> acpi_video_bus_notify()?

I think trying to handle this from video bus events would be nastier 
than the input event monitoring approach, because the events are neither 
meaningful or consistent.

The events that are generated (and the devices they are raised on) vary 
between Dell laptops. Also, the events you see are generated both on lid 
open and lid close, with no differences.

Yes, it's a really stupid DSDT in this respect. The code logic is 
approximately as follows: (and bear in mind that this executes on BOTH 
open and close)

	power down display
	send notification asking O/S to reinitialize PCI bus
	send notification asking O/S to reinitialize video bus
	sent notification of video status change
	sent notification of video status change (again)

Yes, Dell BIOSes power down the display when you close the lid, and then 
*again* when you open it. Yes, Dell BIOSes ask the O/S to reinitialize 
the whole PCI bus when you close/open your lid (fortunately Linux does 
not respond to this particular notification at the moment).

Daniel
