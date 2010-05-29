From: Scott Sturdivant <scott-ILTxhEaIe5LR7s880joybQ@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 16043] New: Resume w/USB remote working in
 2.6.33.2, no longer in 2.6.33.10
Date: Sat, 29 May 2010 00:12:23 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.1005290000510.2288@asgard.binrock.net>
References: <Pine.LNX.4.44L0.1005271755500.1595-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1005271755500.1595-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



On Thu, 27 May 2010, Alan Stern wrote:

> On Thu, 27 May 2010, Andrew Morton wrote:
>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=16043
>>>
>>>            Summary: Resume w/USB remote working in 2.6.33.2, no longer in
>>>                     2.6.33.10

First I need to back track and fix an error -- it's version 2.6.33.4 that 
this no longer works in, not 2.6.33.10 as I had indicated.

> /proc/acpi/wakeup doesn't matter.  What matters are the power/wakeup
> files under /sys.

Ok, all manipulation of /proc/acpi/wakeup is no off, so all devices read 
as "disabled".

> If you want to enable wakeup, you have to do it manually or from a
> boot-time script like /etc/rc.d/rc.local.  For example, you might need
> to do:
>
> 	echo enabled >/sys/bus/pci/devices/0000:00:04.0/power/wakeup
>
> The system has been this way a long time, but up until just now it
> didn't work correctly.

In my case, "USB1" was the partical device that was waking up the system. 
According to /proc/acpi/wakeup, this is what I see:

     # grep USB1 /proc/acpi/wakeup
     USB1      S4     disabled  pci:0000:00:06.0

Now, I perform the following:

     # cat /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
        disabled
     # echo enabled > /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
     # cat /sys/bus/pci/devices/0000\:00\:06.0/power/wakeup
        enabled

Sadly it still will not resume.

Thanks for the tip, in the meantime I will go back to the 2.6.33-2 kernel 
and try modifying the /sys.../power/wakeup file in addition to / instead 
of the /proc/acpi/wakeup file.

Scott
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
