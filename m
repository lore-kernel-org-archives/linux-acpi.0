From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: samsung x360, acpi support
Date: Fri, 05 Dec 2008 09:05:57 +0800
Message-ID: <1228439157.7929.28.camel@rzhang-dt>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39736 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396AbYLEBHz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Dec 2008 20:07:55 -0500
In-Reply-To: <200812041915.39971.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-12-05 at 02:15 +0800, Matthias Heinz wrote:
> Hi,
> 
> as you can see from the topic i got a Samsung X360 right here. It works pretty 
> fine, thanks to the fact that its more Intel than Samsung.
> 
> But i got some problems.
> 
> 1) Backlight support: I cant control the brightness of the backlight with a 
> 2.6.28-rc7. It worked under mysterious circumstances with a 2.6.26. 
via the procfs/sysfs backlight I/F?
please attach the result of
"grep . /proc/acpi/video/*/*/*" both in 2.6.26 kernel and 2.6.28-rc7
kernel.

> Mysterious, because i had to use /proc/acpi/video/NVID/LCD/brightness to set 
> it, which obviously belongs to a nvidia driver (but theres nothing from 
> nvidia in there...)
please attach the "lspci -vvx" output.

> I just found out that its possible to disable the backlight, without disabling 
> the display. Doesn't work, too.
> 
> 2) Wifi LED: I dont know if this is a wifi driver issue or has to be 
> controlled by acpi. 
> 
> 3) The keyboard is not sending acpi events for several switches. It sends 
> (unknown) keycodes that have to be interpreted by the OS.
> But there seems to be an option to change between acpi events and key events, 
> because i can control the backlight when grub is running and in the early 
> boot phase of the kernel. I dont know if this should be classified as 
> problem, but because X is catching all key events handling the wlan power 
> function is a problem of the actual user.
is this a regression? i.e. the hotkey events are always sent to the
keyboard, right?
please attach the output of "grep . /sys/firmware/acpi/interrupts/*".

Btw: you'd better file a bug at bugzilla.kernel.org
and attach all the info there.

thanks,
rui

