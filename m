From: "Carlo E. Prelz" <fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org>
Subject: Acpi slows down my new Asus portable quite a lot
Date: Tue, 15 Jul 2003 16:29:15 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030715142915.GB4920@casa.fluido.as>
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

Dear readers, 

I up to now managed to not need to tackle ACPI world. But I have
recently purchased a fresh new Asus portable.

It is a Centrino-based N3700N. Using a kernel with only APM, the audio
chipset would not be recognized (was assigned IRQ 0 - suggestions to
solve this problem by disabling the 'PnP OS' bios option were useless,
since the bios of this machine lacks this (and many other) options). 

Having read that ACPI can manage IRQ's, I compiled it, and lo! audio
chip detected and working! But the machine slows down quite a
lot. This happens both on 2.4.22-pre5 and on 2.6.0-test1, this last
one also with the small ACPI patch applied. A typical top output looks
as follows:

    3 root      15 -10     0    0    0 R 99.9  0.0  59:11.49 events/0
  644 root      15   0  1696  932 1576 R  0.3  0.2   0:00.01 top
    1 root      15   0  1212  468 1180 S  0.0  0.1   0:01.27 init
    2 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 kblockd/0
    5 root      16   0     0    0    0 S  0.0  0.0   0:00.05 khubd
    6 root      25   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    7 root      15   0     0    0    0 S  0.0  0.0   0:00.00 pdflush
    8 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kswapd0
    9 root      10 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
   10 root      22   0     0    0    0 S  0.0  0.0   0:00.00 pccardd
   11 root      17   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
   12 root      15   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
   70 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kjournald
  111 root      15   0  2052  824 1936 S  0.0  0.2   0:00.00 dhclient
...
...
...

As you can see, 99.9 of the cpu time is sucked by events/0. In 2.4
kernels, the fat process is called keventd, but the result is the
same.

I have compiled ACPI first without support for any sub-module, and
then with fan and asus-specific support. No change happens. What I
noticed is that, soon after boot, the PC's fan starts blowing, and
never stops while the machine is on. This does not happen without
ACPI. 

I decided to write after finding a bug registration on your site ([Bug
843] New: Getting very high CPU load on Laptop with ACPI). The
portable of the submitter of the bug is a Fujitsu-Siemens C6155, but
his situation is otherwise quite similar to mine. I found no reference
of this on the acpi-devel list, so I thought I'd drop a line.

Here is an extract of the boot messages:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--
...
...
...
ACPI: Subsystem revision 20030714
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bri
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 11 12, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs *4 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs *5 6)
ACPI: PCI Interrupt Link [LNKE] (IRQs 6 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 7, disabled)
ACPI: PCI Interrupt Link [LNKG] (IRQs 4 7, disabled)
ACPI: PCI Interrupt Link [LNKH] (IRQs *4 6 12)
ACPI: Power Resource [GFAN] (off)
...
...
...
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 3
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 7
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
...
...
...
ACPI: Fan [FN00] (off)
Asus Laptop ACPI Extras version 0.24a
  M3N model detected, unsupported, trying default values, contact the
developers
  Notify Handler installed successfully
  Error changing brightness
  Error changing brightness
...
...
...
--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

I am available if more info are needed, or if you need me to test any
patch. Thanks in advance!

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido-1XNsQiTun9D1P9xLtpHBDw@public.gmane.org             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
