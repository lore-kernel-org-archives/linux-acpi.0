From: yakui_zhao <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BISECTED] 20 ACPI interrupts per second on EEEPC 4G
Date: Mon, 13 Apr 2009 10:04:08 +0800
Message-ID: <1239588248.5564.19.camel@localhost.localdomain>
References: <49DF6835.9040501@tuffmail.co.uk> <49DFE345.3010109@gmail.com>
	 <49E05F83.2090500@tuffmail.co.uk>  <49E20EBA.2090708@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E20EBA.2090708-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Alexey Starikovskiy <aystarik-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, 2009-04-12 at 23:54 +0800, Alan Jenkins wrote:
> Alan Jenkins wrote:
> > Alexey Starikovskiy wrote:
> >> Alan Jenkins wrote:
> >>> On latest git, powertop shows 20 ACPI interrupts per second. 
> >>> Previously, this was closer to 1 per second.  See attached output (a
> >>> vs b, "a" is from 2.6.29-rc8).
> >>>
> >>> This is from a pretty sparse KDE desktop.  Normally I run
> >>> gnome-power-manager, but I killed it to make sure that wasn't
> >>> causing any problems.
> >>>
> >
> >>> gpe18:   60975  enabled
> >>> gpe_all:   60975
> >>> sci:   60975
> >>>
> >>> which I presume means lots of EC interrupts.
> >>>
> >>> [    0.134068] ACPI: EC: GPE = 0x18, I/O: command/status = 0x66,
> >>> data = 0x62
> >>>
> >
> >> This patch looks to be a suspect:
> >> 34ff4dbccccce54c83b1234d39b7ad9e548a75dd,
> >> Please check if reversing it helps
> >
> > No, I still get 20 ACPI interrupts per second.
> >
> > I tried without powertop, just in case that was provoking it, but it
> > still happens:
> >
> > alan@alan-eeepc:/sys/firmware/acpi/interrupts$ cat sci; sleep 5; cat sci
> >    2583
> >    2680
> 
> I did wonder whether this was due to thermal polling.  So look what I
> found with bisection :-).
Does the issue still exist if the following commit is reverted?
Thanks.
> 
> 
> b1569e99c795bf83b4ddf41c4f1c42761ab7f75e is first bad commit
> commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e
> Author: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
> Date:   Wed Dec 3 17:55:32 2008 +0000
> 
>     ACPI: move thermal trip handling to generic thermal layer
> 
>     The ACPI code currently carries its own thermal trip handling,
> meaning that
>     any other thermal implementation will need to reimplement it. Move
> the code
>     to the generic thermal layer.
> 
> 
> Regards
> Alan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
