From: Per Svennerbrandt <per.svennerbrandt-IcHNGFlcIT4@public.gmane.org>
Subject: Re: ACPI kernel panic at boot on 2.6.0-test5-mm1
Date: Wed, 10 Sep 2003 02:42:03 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030910024203.1a8dbb37.per.svennerbrandt@lbi.se>
References: <Pine.LNX.4.44.0309091420000.1412-100000@sol.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0309091420000.1412-100000-LUS5bfvkRbdGBRGhe+f61g@public.gmane.org>
To: David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 9 Sep 2003 14:34:22 -0400 (EDT)
David Mansfield <lkml-cnRKH8LNr2xl57MIdRCFDg@public.gmane.org> wrote:

> 
> Hello Andrew, all,
> 
> I get the following 100% reproducible (copied by hand) kernel oops and
> panic at boot when ACPI is enabled.  I'm not sure if other versions have
> this problem as the config options seem to have changed recently.
> 
> Kernel was patched with the #ifdef DEBUG patch to mm/slab.c required for
> compilation.  System is UP Athlon 1.3ghz, 512mb ram, Redhat 9, gcc version
> 3.2.2 20030222 (Red Hat Linux 3.2.2-5).
> 
> oops/panic:
> 
> at acpi_pci_link_calc_penalties
> 
> stack trace:
>    acpi_acpi_irq_init+0x8/0x41
>    pci_acpi_init+0x22/0x60
>    do_initcalls+0x2b/0xa0
>    init_workqueues+0xf/0x40
>    init+0x2e/0x190
>    init+0x0/0x190
>    kernel_thread_helper+0x5/0xc
> Kernel panic: attempted to kill init.
> 
> Also, the acpi=off is broken, and doesn't stop the ACPI code from oopsing.  
> Instead I had to use pci=noacpi for it to boot.  This is a documentation 
> bug.  acpi=off is supposed to disable the acpi code.
>

I'm seeing something simular on both test4-mm6 and test5 (havn't tried test5-mm1 since I asume it has the same problem), plain test4 works though.
For me however, specifying pci=noacpi does *not* solve the problem, although acpi=off does.

System info availible upon request.

Per
