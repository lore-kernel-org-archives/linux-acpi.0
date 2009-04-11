From: Alexey Starikovskiy <aystarik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Regression: 20 ACPI interrupts per second on EEEPC 4G
Date: Sat, 11 Apr 2009 04:24:37 +0400
Message-ID: <49DFE345.3010109@gmail.com>
References: <49DF6835.9040501@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49DF6835.9040501-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

This patch looks to be a suspect: 34ff4dbccccce54c83b1234d39b7ad9e548a75dd,
Please check if reversing it helps

Regards,
Alex.

Alan Jenkins wrote:
> On latest git, powertop shows 20 ACPI interrupts per second.  
> Previously, this was closer to 1 per second.  See attached output (a 
> vs b, "a" is from 2.6.29-rc8).
>
> This is from a pretty sparse KDE desktop.  Normally I run 
> gnome-power-manager, but I killed it to make sure that wasn't causing 
> any problems.
>
> alan@alan-eeepc:/sys/firmware/acpi/interrupts$ grep -v "invalid" *
> error:       0
> ff_gbl_lock:       0    enabled
> ff_pwr_btn:       0     enabled
> ff_rt_clk:       0      disabled
> gpe03:       0  disabled
> gpe04:       0  disabled
> gpe05:       0  disabled
> gpe09:       0  disabled
> gpe0B:       0  disabled
> gpe0C:       0  disabled
> gpe0D:       0  disabled
> gpe0E:       0  disabled
> gpe18:   60975  enabled
> gpe_all:   60975
> sci:   60975
>
> which I presume means lots of EC interrupts.
>
> [    0.134068] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66, data 
> = 0x62
>
> Any ideas?
>
> Thanks
> Alan
