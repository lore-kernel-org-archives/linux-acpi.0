From: Len Brown <lenb@kernel.org>
Subject: Re: PATCH: /proc/acpi/alarm: handle day-of-month wraparound on readback
Date: Mon, 01 Dec 2008 13:18:50 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812011311490.3197@localhost.localdomain>
References: <200806222042.13929.david-b@pacbell.net> <4934176F.6080900@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:64740 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbYLASSy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 13:18:54 -0500
In-reply-to: <4934176F.6080900@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Alessandro Zummo <a.zummo@towertech.it>, David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>, rtc-linux@googlegroups.com, linux-acpi@vger.kernel.org



On Mon, 1 Dec 2008, Mark Lord wrote:

> Fix month wrap issue with readback from /proc/acpi/alarm
> This bug has been around *forever*.
> 
> $ echo '2008-12-01 10:36:20' > /proc/acpi/alarm
> $ cat /proc/acpi/alarm
> 2008-11-01 10:36:20
> 
> Note how the readback above shows the month incorrectly.
> But with this patch applied, it shows the correct month (12).
> 
> Patch applies/works on kernels 2.6.25.* through 2.6.27.*,
> and probably on earlier kernels as well.

We've had some BCD_TO_BIN() changes here in 2.6.28 already,
does 2.6.28-rc still have this bug?

I'd check myself, but I don't have a /proc/acpi/alarm due to this:

#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE) || 
!defined(CONFIG_X86)
/* use /sys/class/rtc/rtcX/wakealarm instead; it's not ACPI-specific */
#else
#define HAVE_ACPI_LEGACY_ALARM
#endif


thanks,
-Len

