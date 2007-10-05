From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: _DOS in video.c
Date: Fri, 05 Oct 2007 22:50:06 +0100
Message-ID: <1191621006.23575.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:41127 "EHLO
	ppsw-4.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbXJEWS0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Oct 2007 18:18:26 -0400
Received: from pcjc2a.trin.cam.ac.uk ([131.111.212.44]:44057)
	by ppsw-4.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.154]:465)
	with esmtpsa (LOGIN:pcjc2) (SSLv3:DHE-RSA-AES256-SHA:256)
	id 1Idv3e-0003zF-Dn (Exim 4.63) for linux-acpi@vger.kernel.org
	(return-path <pcjc2@cam.ac.uk>); Fri, 05 Oct 2007 22:50:06 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I've been investigating some backlight vs. lidswitch problems with my HP
Compaq nc6432 laptop, and have been digging in video.c

At start of the video driver, the _DOS method is executed, and similarly
when the driver is unloaded.
(From the Ubuntu Gutsy kernel.. hopefully this isn't disto-patched)

1706 static int acpi_video_bus_start_devices(struct acpi_video_bus
*video)
1707 {
1708 return acpi_video_bus_DOS(video, 1, 0);
1709 }
1710 
1711 static int acpi_video_bus_stop_devices(struct acpi_video_bus
*video)
1712 {
1713 return acpi_video_bus_DOS(video, 0, 1);
1714 }


It seems to me - as I understand the driver, is that we want to tell the
BIOS specifically NOT to process AC brightness changes, or display
switches (which on my laptop appears to effect LID switch backlight
blanking too).

It seems that the video.c driver has this reversed, and actually lets
the BIOS keep doing these things after video.ko is loaded. Similarly,
when unloading video.ko, my laptop stops switching the backlight on/off
for lid events.

I've reversed the sense of the acpi_video_bus_DOS() calls for my own
testing, and it seems to be ok. There is unfortunately DSDT brokenness
which means it still doesn't work satisfactorily, but I'm debugging that
with a DSDT override now. I get lid notifications, but there is a delay
before /proc/acpi/button/lid/*/state "catches up" - which breaks
userspace that checks this state when it sees an event.

It very much looks like this delay is due to various sleep statements in
the DSDT when not internally handling the backlight etc.. There are also
a lot of OS specific paths in the DSDT for this code, making things even
more fun to trace.

Kind Regards,

-- 
Peter Clifton

Electrical Engineering Division,
Engineering Department,
University of Cambridge,
9, JJ Thomson Avenue,
Cambridge
CB3 0FA

Tel: +44 (0)7729 980173 - (No signal in the lab!)

