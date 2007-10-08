From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: _DOS in video.c
Date: Mon, 08 Oct 2007 16:43:49 +0800
Message-ID: <1191833029.17844.21.camel@acpi-hp.sh.intel.com>
References: <1191621006.23575.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18072 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbXJHIhP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Oct 2007 04:37:15 -0400
In-Reply-To: <1191621006.23575.9.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Clifton <pcjc2@cam.ac.uk>
Cc: linux-acpi@vger.kernel.org

On Fri, 2007-10-05 at 22:50 +0100, Peter Clifton wrote:
> Hi,
> 
> I've been investigating some backlight vs. lidswitch problems with my HP
> Compaq nc6432 laptop, and have been digging in video.c
> 
> At start of the video driver, the _DOS method is executed, and similarly
> when the driver is unloaded.
> (From the Ubuntu Gutsy kernel.. hopefully this isn't disto-patched)
> 
> 1706 static int acpi_video_bus_start_devices(struct acpi_video_bus
> *video)
> 1707 {
> 1708 return acpi_video_bus_DOS(video, 1, 0);
> 1709 }
> 1710 
> 1711 static int acpi_video_bus_stop_devices(struct acpi_video_bus
> *video)
> 1712 {
> 1713 return acpi_video_bus_DOS(video, 0, 1);
> 1714 }
> 
> 
> It seems to me - as I understand the driver, is that we want to tell the
> BIOS specifically NOT to process AC brightness changes, or display
> switches (which on my laptop appears to effect LID switch backlight
> blanking too).
> 
acpi_video_bus_DOS(video, 1, 0) means the ACPI video driver want BIOS
to switch the display/brightness level automatically.

> It seems that the video.c driver has this reversed, and actually lets
> the BIOS keep doing these things after video.ko is loaded. 
Yes, that's what the ACPI video driver used to do.
But this piece of code has been changed recently.
We set _DOS to 0 in video driver by default, which means we prevent the
BIOS from handling these events, but send a notification to user space
instead.

> Similarly,
> when unloading video.ko, my laptop stops switching the backlight on/off
> for lid events.
> 
Yes, that's a problem. But I think users always need to load ACPI video
driver for the backlight/display switching.

> I've reversed the sense of the acpi_video_bus_DOS() calls for my own
> testing, and it seems to be ok. 
Do you mean call acpi_video_bus_DOS(video, 0, 1) when the device is
started and call acpi_video_bus_DOS(video, 1, 0) when the device is
removed?

> There is unfortunately DSDT brokenness
> which means it still doesn't work satisfactorily, but I'm debugging that
> with a DSDT override now. I get lid notifications, but there is a delay
> before /proc/acpi/button/lid/*/state "catches up" - which breaks
> userspace that checks this state when it sees an event.
> 
So /proc/acpi/button/lid/*/state is still "closed"/"opened" after the
lid is opened/closed, thus the userspace get the wrong lid state and can
not turn on/off the backlight properly, right?

> It very much looks like this delay is due to various sleep statements in
> the DSDT when not internally handling the backlight etc.. There are also
> a lot of OS specific paths in the DSDT for this code, making things even
> more fun to trace.
> 
Can you send the acpidump please?

thanks,
Rui
