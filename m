From: Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>
Subject: Re: ACPI problems on Athlon MP system
Date: Wed, 15 Jan 2003 10:45:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030115094506.GA10071@schiggy.intern.quelltext.com>
References: <20030110030741.GA2580@stikine.ucs.sfu.ca> <20030110103707.GA12313@digda.intern.quelltext.com> <20030115033643.GA29848@stikine.ucs.sfu.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030115033643.GA29848-0ze2hujOWYhqr3d4nwidZ7Dks+cytr/Z@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Martin Siegert <siegert-z1KUqvL5UUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Martin,

it seems that the ACPI support for APICs and/or IO-APICs is currently
not fully functional (at least in 2.4; don't know about 2.5). Many
people on this list, including me, need to disable APIC support in the
kernel or in the BIOS, if the BIOS setup has such an option, to get
their systems to boot.

And then, the IDE subsystem of 2.4.21 has changed a lot from 2.4.20,
and it could well be the case that 2.4.21-pre2 has still bugs that
raise their head on your system.

(On my MS-6533EG P4 SiS650 mainboard, the 2.4.21-pre2 IDE works much
better than the 2.4.18-2.4.20 kernels -- now I can finally burn DVDs
on my Pioneer DVR-105 with DMA enabled --  but your mileage may vary.
After all, 2.4.21-pre2 is still, well, "pre".)

Good luck,
Arndt


On Tue, Jan 14, 2003 at 07:36:43PM -0800, Martin Siegert wrote:
> Hi again,
> 
> I patched/compiled linux-2.4.21-pre2 with the acpi-20021212-2.4.20
> patch. Now the machine does not even boot anymore. Here is the last
> part of the boot messages
> 
> 
> AMD7411: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings:hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:hdc:DMA, hdd:pio
> hda: IC35L040AVER07-0, ATA DISK drive
> hda: IRQ probe failed (0xffffcf8)
> hdb: IRQ probe failed (0xffffcf8)
> hdb: IRQ probe failed (0xffffcf8)
> blk: queue c02fb5c0, I/O limit 4095Mb (mask 0xffffffff)
> hdc: IRQ probe failed (0xffffcf8)
> hdc: IRQ probe failed (0xffffcf8)
> hdc: CDU5211, ATAPI CD/DVD-ROM drive
> hdc: IRQ probe failed (0xffffcf8)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: lost interrupt
> hda: lost interrupt
> hda: lost interrupt
> hda: host protected area >= 1
> hda: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63, UDMA(100)
> Partition check:
>  hda:<3>hda: lost interrupt
> hda: dma_timer_expiry: dma status == 0x24
> 
> 
> and at this point the machine hangs forever. I then rebooted the machine
> with the "noapic" kernel flag and this time it boots but I get a lot of
> "APIC error on CPU1: 40(40)" messages. A recent snapshot from syslog is:
> 
> Jan 14 19:22:40 test2 kernel: APIC error on CPU1: 40(40)
> Jan 14 19:23:11 test2 last message repeated 3912 times
> Jan 14 19:24:12 test2 last message repeated 6393 times
> Jan 14 19:25:13 test2 last message repeated 6106 times
> Jan 14 19:26:14 test2 last message repeated 6116 times
> Jan 14 19:26:57 test2 last message repeated 6243 times
> 
> However, the "poweroff" command now works!
> 
> Is there a conflict between ACPI and APIC or is there a way of getting
> the best of both worlds? I.e., can I use the acpi-20021212-2.4.20
> without having to set the "noapic" flag? (it is entirely possible
> that I misconfigured the kernel in some way)
> 
> Cheers,
> Martin

-- 
Arndt Schoenewald <abs-SA7OhAOe25xnNxvc45mVi0K323yFvGpRdefyYXQ/eNw@public.gmane.org>, Software Developer
Quelltext AG (http://www.quelltext-ag.de), Dortmund, Germany


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
