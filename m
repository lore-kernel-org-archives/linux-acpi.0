From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [BISECTED] EEE PC hangs when booting off battery
Date: Mon, 13 Apr 2009 13:15:54 -0600
Message-ID: <200904131315.55519.bjorn.helgaas@hp.com>
References: <49E065CF.6040408@tuffmail.co.uk> <49E1ADAE.2030103@tuffmail.co.uk> <49E1E89D.7040502@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49E1E89D.7040502-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Testers List <kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venkatesh Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sunday 12 April 2009 07:11:57 am Alan Jenkins wrote:
> Alan Jenkins wrote:
> > Tzy-Jye Daniel Lin wrote:
> >> On Sat, Apr 11, 2009 at 5:41 AM, Alan Jenkins
> >> <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org> wrote:
> >>   
> >>> Regression #6 on latest git! (last known good is 2.6.29-rc8)

You mention that this occurs when booting off battery.  So I
assume everything works fine when the EEE is plugged in to the
wall socket?

> >>> Magic SysRQ keys work though.  ...
> > I was able to run SysRq-P, and found the following backtrace -
> >
> > Pid: 0
> > EIP is at acpi_idle_enter_bm+0x1df/0x208 [processor]

Can you figure out where this is in acpi_idle_enter_bm() or
maybe just email me your processor.ko module?

Does it always happen at the same point?

If you blacklist or rename the processor module to prevent it
from loading, does that keep the hang from occurring?

> > cpud_idle_call
> > cpu_idle
> > rest_init
> > start_kernel
> > i386_start_kernel
> 
> 7ec0a7290797f57b780f792d12f4bcc19c83aa4f is first bad commit
> commit 7ec0a7290797f57b780f792d12f4bcc19c83aa4f
> Author: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
> Date:   Mon Mar 30 17:48:24 2009 +0000

Ouch, sorry about that.  Thanks for doing all the bisection work.

>     ACPI: processor: use .notify method instead of installing handler
> directly
> 
>     This patch adds a .notify() method.  The presence of .notify() causes
>     Linux/ACPI to manage event handlers and notify handlers on our behalf,
>     so we don't have to install and remove them ourselves.
> 
>     Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
>     CC: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>     CC: Zhao Yakui <yakui.zhao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>     CC: Venki Pallipadi <venkatesh.pallipadi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>     CC: Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>     Signed-off-by: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> However, reverting this commit from v2.6.30-rc1 doesn't solve the hang.

I don't see the problem in that commit yet, and if there is a problem
with it, I would think that reverting it from 2.6.30-rc1 would solve
it.  But maybe it'd be useful to revert the whole .notify series to
make sure.  From 2.6.30-rc1, you should be able to revert these:

  7ec0a7290797f57b780f792d12f4bcc19c83aa4f processor
  373cfc360ec773be2f7615e59a19f3313255db7c button
  46ec8598fde74ba59703575c22a6fb0b6b151bb6 Linux/ACPI infrastructure

What happens with those commits reverted?

Bjorn
