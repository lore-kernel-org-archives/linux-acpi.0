From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 16043] New: Resume w/USB remote working in
 2.6.33.2, no longer in 2.6.33.10
Date: Sat, 29 May 2010 10:28:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005291024130.30763-100000@netrider.rowland.org>
References: <alpine.DEB.1.10.1005290000510.2288@asgard.binrock.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47480 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754488Ab0E2O25 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 29 May 2010 10:28:57 -0400
In-Reply-To: <alpine.DEB.1.10.1005290000510.2288@asgard.binrock.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Sturdivant <scott@binrock.net>
Cc: USB list <linux-usb@vger.kernel.org>, linux-acpi@vger.kernel.org, stable@kernel.org, bugzilla-daemon@bugzilla.kernel.org

On Sat, 29 May 2010, Scott Sturdivant wrote:

> >>> https://bugzilla.kernel.org/show_bug.cgi?id=16043
> >>>
> >>>            Summary: Resume w/USB remote working in 2.6.33.2, no longer in
> >>>                     2.6.33.10
> 
> First I need to back track and fix an error -- it's version 2.6.33.4 that 
> this no longer works in, not 2.6.33.10 as I had indicated.

I figured as much, since 2.6.33.5 was only released this past week.

> In my case, "USB1" was the partical device that was waking up the system. 
> According to /proc/acpi/wakeup, this is what I see:
> 
>      # grep USB1 /proc/acpi/wakeup
>      USB1      S4     disabled  pci:0000:00:06.0
> 
> Now, I perform the following:
> 
>      # cat /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
>         disabled
>      # echo enabled > /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
>      # cat /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
>         enabled
> 
> Sadly it still will not resume.
> 
> Thanks for the tip, in the meantime I will go back to the 2.6.33-2 kernel 
> and try modifying the /sys.../power/wakeup file in addition to / instead 
> of the /proc/acpi/wakeup file.

There's one more thing to check: The /sys/.../power/wakeup file for 
your USB device.  A recent change caused remote wakeup to be disabled 
by default for USB devices; that could explain the change in behavior.  
You would need to enable it explicitly, just like for the controller.

Alan Stern

