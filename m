From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: irq 9: nobody cared
Date: Sat, 14 Jun 2003 19:09:02 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0306141907450.14661-100000@godzilla.se.axis.com>
References: <20030611154626.GB1875@mizu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030611154626.GB1875-+KSLakwpbd8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Mizu <michal-VaXaUECoPuY@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 11 Jun 2003, Mizu wrote:
> What does it mean message: "irq 9: nobody cared" ?

2.5.70 (without any special acpi patches) spammed this on me as well as I 
tested it, and did not work.

Should we just use 2.5.69 + the 2.5.69 acpi patch in the meantime perhaps ?

/BW

> This is my dmesg :
> 
> Jun  7 23:42:19 mizu kernel: Adding 257032k swap on /dev/hda2.
> Priority:-1 extents:1
> Jun  7 23:42:19 mizu kernel: irq 9: nobody cared!
> Jun  7 23:42:19 mizu kernel: Call Trace:
> Jun  7 23:42:19 mizu kernel:  [<c010a7cf>] __report_bad_irq+0x2a/0x8b
> Jun  7 23:42:19 mizu kernel:  [<c010a8b9>] note_interrupt+0x6f/0x9f
> Jun  7 23:42:19 mizu kernel:  [<c010ab44>] do_IRQ+0x126/0x135
> Jun  7 23:42:19 mizu kernel:  [<c0109208>] common_interrupt+0x18/0x20
> Jun  7 23:42:19 mizu kernel:  [<c01f007b>] proc_bus_pci_read+0x1e0/0x1f6
> Jun  7 23:42:19 mizu kernel:  [<c011dddb>] do_softirq+0x3f/0x9a
> Jun  7 23:42:19 mizu kernel:  [<c010ab20>] do_IRQ+0x102/0x135
> Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
> Jun  7 23:42:19 mizu kernel:  [<c0109208>] common_interrupt+0x18/0x20
> Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
> Jun  7 23:42:19 mizu kernel:  [<c0117057>] schedule+0x0/0x39f
> Jun  7 23:42:19 mizu kernel:  [<c0108fe5>] need_resched+0x27/0x32
> Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
> Jun  7 23:42:19 mizu kernel:  [<c0107041>] default_idle+0x23/0x26
> Jun  7 23:42:19 mizu kernel:  [<c01070a2>] cpu_idle+0x2f/0x38
> Jun  7 23:42:19 mizu kernel:  [<c0105000>] _stext+0x0/0x5d
> Jun  7 23:42:19 mizu kernel:  [<c03a2654>] start_kernel+0x146/0x14b
> Jun  7 23:42:19 mizu kernel:  [<c03a23ea>] unknown_bootoption+0x0/0xfd
> Jun  7 23:42:19 mizu kernel:
> Jun  7 23:42:19 mizu kernel: handlers:
> Jun  7 23:42:19 mizu kernel: [<c01f1df3>] (acpi_irq+0x0/0x16)
> Jun  7 23:42:19 mizu kernel: Disabling IRQ #9
> Jun  7 23:42:19 mizu kernel: eth0: Setting 100mbps full-duplex based on
> auto-negotiated partner ability 41e1.
> 
> 
> 
> 



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
