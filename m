From: Mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: irq 9: nobody cared
Date: Wed, 11 Jun 2003 17:46:26 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030611154626.GB1875@mizu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hello

What does it mean message: "irq 9: nobody cared" ?

Where can I find a problem ? 

  Thx

  			mizu

This is my dmesg :

Jun  7 23:42:19 mizu kernel: Adding 257032k swap on /dev/hda2.
Priority:-1 extents:1
Jun  7 23:42:19 mizu kernel: irq 9: nobody cared!
Jun  7 23:42:19 mizu kernel: Call Trace:
Jun  7 23:42:19 mizu kernel:  [<c010a7cf>] __report_bad_irq+0x2a/0x8b
Jun  7 23:42:19 mizu kernel:  [<c010a8b9>] note_interrupt+0x6f/0x9f
Jun  7 23:42:19 mizu kernel:  [<c010ab44>] do_IRQ+0x126/0x135
Jun  7 23:42:19 mizu kernel:  [<c0109208>] common_interrupt+0x18/0x20
Jun  7 23:42:19 mizu kernel:  [<c01f007b>] proc_bus_pci_read+0x1e0/0x1f6
Jun  7 23:42:19 mizu kernel:  [<c011dddb>] do_softirq+0x3f/0x9a
Jun  7 23:42:19 mizu kernel:  [<c010ab20>] do_IRQ+0x102/0x135
Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
Jun  7 23:42:19 mizu kernel:  [<c0109208>] common_interrupt+0x18/0x20
Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
Jun  7 23:42:19 mizu kernel:  [<c0117057>] schedule+0x0/0x39f
Jun  7 23:42:19 mizu kernel:  [<c0108fe5>] need_resched+0x27/0x32
Jun  7 23:42:19 mizu kernel:  [<c010701e>] default_idle+0x0/0x26
Jun  7 23:42:19 mizu kernel:  [<c0107041>] default_idle+0x23/0x26
Jun  7 23:42:19 mizu kernel:  [<c01070a2>] cpu_idle+0x2f/0x38
Jun  7 23:42:19 mizu kernel:  [<c0105000>] _stext+0x0/0x5d
Jun  7 23:42:19 mizu kernel:  [<c03a2654>] start_kernel+0x146/0x14b
Jun  7 23:42:19 mizu kernel:  [<c03a23ea>] unknown_bootoption+0x0/0xfd
Jun  7 23:42:19 mizu kernel:
Jun  7 23:42:19 mizu kernel: handlers:
Jun  7 23:42:19 mizu kernel: [<c01f1df3>] (acpi_irq+0x0/0x16)
Jun  7 23:42:19 mizu kernel: Disabling IRQ #9
Jun  7 23:42:19 mizu kernel: eth0: Setting 100mbps full-duplex based on
auto-negotiated partner ability 41e1.



-- 
        -[ Mizu ]-
#-------------------------#
[-> E-mail:michal-VaXaUECoPuY@public.gmane.org    
[-> ICQ:97165392
[-> WWW: http://www.mizu.sk



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
