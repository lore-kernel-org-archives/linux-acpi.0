From: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Subject: Re: ACPI problems on Athlon MP system
Date: Tue, 14 Jan 2003 19:36:43 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030115033643.GA29848@stikine.ucs.sfu.ca>
References: <20030110030741.GA2580@stikine.ucs.sfu.ca> <20030110103707.GA12313@digda.intern.quelltext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030110103707.GA12313-XEk0yrNnxERrk9EDFsdIuomMxnTEL9wi0E9HWUfgJXw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi again,

I patched/compiled linux-2.4.21-pre2 with the acpi-20021212-2.4.20
patch. Now the machine does not even boot anymore. Here is the last
part of the boot messages


AMD7411: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings:hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hda: IRQ probe failed (0xffffcf8)
hdb: IRQ probe failed (0xffffcf8)
hdb: IRQ probe failed (0xffffcf8)
blk: queue c02fb5c0, I/O limit 4095Mb (mask 0xffffffff)
hdc: IRQ probe failed (0xffffcf8)
hdc: IRQ probe failed (0xffffcf8)
hdc: CDU5211, ATAPI CD/DVD-ROM drive
hdc: IRQ probe failed (0xffffcf8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: host protected area >= 1
hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
Partition check:
 hda:<3>hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x24


and at this point the machine hangs forever. I then rebooted the machine
with the "noapic" kernel flag and this time it boots but I get a lot of
"APIC error on CPU1: 40(40)" messages. A recent snapshot from syslog is:

Jan 14 19:22:40 test2 kernel: APIC error on CPU1: 40(40)
Jan 14 19:23:11 test2 last message repeated 3912 times
Jan 14 19:24:12 test2 last message repeated 6393 times
Jan 14 19:25:13 test2 last message repeated 6106 times
Jan 14 19:26:14 test2 last message repeated 6116 times
Jan 14 19:26:57 test2 last message repeated 6243 times

However, the "poweroff" command now works!

Is there a conflict between ACPI and APIC or is there a way of getting
the best of both worlds? I.e., can I use the acpi-20021212-2.4.20
without having to set the "noapic" flag? (it is entirely possible
that I misconfigured the kernel in some way)

Cheers,
Martin

On Fri, Jan 10, 2003 at 11:37:07AM +0100, Arndt Schoenewald wrote:
> Hi Martin,
> 
> the ACPI support in the 2.4 kernel series is very old (from autumn
> 2001 if I remember correctly), so you should use the ACPI patch from
> http://sourceforge.net/projects/acpi; in your case
> 
>     http://prdownloads.sf.net/acpi/acpi-20021212-2.4.20.diff.gz
> 
> (This patch applies cleanly against linux-2.4.21-pre2 from kernel.org
> even though it was done for 2.4.20.)
> 
> The Intel people are trying to get an updated ACPI version into 2.4,
> but I guess this will not happen before 2.4.22. The 2.5 kernel series
> does already include a current ACPI version.
> 
> Good luck,
> Arndt
> 
> 
> On Thu, Jan 09, 2003 at 07:07:41PM -0800, Martin Siegert wrote:
> > Hi,
> > 
> > I am not sure whether this is the correct place to ask this question,
> > but hopefully you can point me in the right direction.
> > 
> > Here is the problem:
> > I am trying to get the "poweroff" command working on an Athlon MP
> > (Tyan S2462) system (linux-2.4.21-pre2; otherwise RedHat 7.3).
> > 
> > The machine has ACPI enabled in the bios. When I compile the kernel
> > with ACPI disabled, the poweroff command shuts down the system, but
> > does not shut off the power (it acts exactly like the halt command).
> > In order to shutoff the machine I must press the power switch.
> > 
> > When I compile the kernel with ACPI enabled the situation is worse:
> > the halt and poweroff commands still work in exactly the same way
> > (shutdown the system), but now I cannot switch off the machine
> > anymore: pressing the power switch has absolutely no effect
> > (regardless of how long I hold the switch). The only way to
> > switch off the machine is to either pull the power cord or to
> > press the reset button on then the power switch (which will then
> > switch off the machine when it reboots).
> > 
> > What am I doing wrong? Am I missing some kernel switches, options?
> > Do I need additional software?
> > 
> > Any help or suggestions, hints are appreciated!
> > 
> > Thanks in advance,
> > 
> > Martin
> 
> -- 
> Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
> Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
