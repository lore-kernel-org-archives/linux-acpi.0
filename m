From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [Bugme-new] [Bug 16043] New: Resume w/USB remote working in
 2.6.33.2, no longer in 2.6.33.10
Date: Thu, 27 May 2010 13:01:17 -0700
Message-ID: <20100527130117.ca479487.akpm@linux-foundation.org>
References: <bug-16043-10286@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bug-16043-10286-3bo0kxnWaOQUvHkbgXJLS5sdmw4N0Rt+2LY78lusg7I@public.gmane.org/>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, bugme-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org, scott-ILTxhEaIe5LR7s880joybQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Tue, 25 May 2010 03:51:20 GMT
bugzilla-daemon-590EEB7GvNiWaY/ihj7yzEB+6BGkLq7r@public.gmane.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=16043
> 
>            Summary: Resume w/USB remote working in 2.6.33.2, no longer in
>                     2.6.33.10

This is a regression within -stable, presumably also in 2.6.34.

>            Product: ACPI
>            Version: 2.5
>     Kernel Version: 2.6.33.10
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Power-Sleep-Wake
>         AssignedTo: acpi_power-sleep-wake-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
>         ReportedBy: scott-ILTxhEaIe5LR7s880joybQ@public.gmane.org
>         Regression: Yes
> 
> 
> Using the latest Arch Linux kernel (2.6.33.10-1), the contents of
> /proc/acpi/wakeup are:
> 
> [scott@blargh-htpc ~]$ cat /proc/acpi/wakeup
> Device  S-state   Status   Sysfs node
> HUB0      S5     disabled  pci:0000:00:09.0
> XVR0      S5     disabled
> XVR1      S5     disabled
> XVR2      S5     disabled
> XVR3      S5     disabled
> XVR4      S5     disabled  pci:0000:00:16.0
> XVR5      S5     disabled
> XVR6      S5     disabled
> UAR1      S5     disabled  pnp:00:08
> USB0      S4     enabled   pci:0000:00:04.0
> USB1      S4     disabled  pci:0000:00:06.0
> USBB      S3     disabled  pci:0000:00:06.1
> USB2      S3     disabled  pci:0000:00:04.1
> AZAD      S5     disabled  pci:0000:00:08.0
> MMAC      S5     disabled  pci:0000:00:0a.0
> 
> [scott@blargh-htpc pkg]$ uname -a
> Linux blargh-htpc 2.6.33-ARCH #1 SMP PREEMPT Thu May 13 11:32:37 CEST 2010
> x86_64 Intel(R) Core(TM)2 Duo CPU E8400 @ 3.00GHz GenuineIntel GNU/Linu
> x
> 
> The machine will suspend to RAM correctly, but will no longer be resumed by a
> USB remote power-on event.  Instead, the power button on the machine must be
> pressed.  It then resumes correctly.
> 
> This behavior was not present in the previous kernel I was running: 2.6.33.2-1.
>  In that case, the machine powered back on correctly when the USB remote's
> power button was pressed.  There was an intermediate kernel release
> (2.6.33.4-1) that I have not tried, but certainly can do so if that might help
> determine where the regression was introduced.
> 
> Additionally if there's more information I can provide about the system and my
> setup, please let me know what is required.
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
