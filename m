From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: "irq 11: nobody cared" after S3
Date: Mon, 2 Aug 2004 14:47:43 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B44D37711ED29844BEA67908EAF36F0376876A@pdsmsx401.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I guess the bug is: ACPI sets LNKE's IRQ from 10 to 11 in boot time.
LNKE's register is at LPC bridge offset 0x68, but current PCI config
space save/restore code only handles first 0x40 bytes. After resume,
LNKE's register doesn't recover. So LNKE will actually route to 10, but
ACPI still thinks it routes to 11. Then you will get such error. I guess
such error is unavoidable unless LPC bridge driver exists (it can
save/restore all affected config space instead of first 0x40 bytes).=20

Thanks,
Shaohua

>-----Original Message-----
>From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
>admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of stefandoesinger-RbZlAiThDcE@public.gmane.org
>Sent: Monday, August 02, 2004 12:50 AM
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: [ACPI] "irq 11: nobody cared" after S3
>
>Hello,
>I have a really odd problem with acpi interrupts and ipw2100.
>
>I use 2.6.8-rc2 + acpi-20040715 and the system works fine after S3 as
long
>no
>driver uses IRQ11. But if I have ipw2100 loaded before I suspend or
load it
>afterwards, irq11 and irq10 are disabled.
>
>The odd thing is that it worked for 2 days with the (hopefully) same
>configuration. Then I tried to make a clear patch which calls
>acpi_leave_sleep_state before resuming the devices which is needed on
my
>notebook(see pci device resume too early?). I recombiled the kernel and
my
>nice setup stopped working. Returning to the original code didn't help.
>
>The problem occurs when ipw2100(or ndiswrapper) is loaded before I
>suspend(see
>dmesg.loadbefore) or if I load it after resume(see dmesg.loadlater. In
both
>cases IRQ11 and IRQ10 are disabled. IRQ10 works nicely as long IRQ11 is
not
>used. The IRQ crash occues eighter when PIT is resumed or when ipw2100
>registers the irq line.
>
>This is my /proc/interrupts with a normally booted system(no S3):
>           CPU0
>  0:    1508252          XT-PIC  timer
>  1:       2953          XT-PIC  i8042
>  2:          0          XT-PIC  cascade
>  5:      19552          XT-PIC  uhci_hcd, eth0
>  8:          2          XT-PIC  rtc
>  9:        168          XT-PIC  acpi
> 10:      94435          XT-PIC  ehci_hcd, uhci_hcd, uhci_hcd,
>radeon@PCI:1:0:0, Intel ICH4
> 11:       1166          XT-PIC  wlan0
> 12:       5382          XT-PIC  i8042
> 14:      14433          XT-PIC  ide0
>NMI:          0
>LOC:    1508373
>ERR:          0
>MIS:          0
>
>After this crash, 11 hase a count of exactly 100000.
>I tried with  and without APIC, IOAPIC, hpet, power management timer.
>If I reverse the patch from =
http://bugme.osdl.org/show_bug.cgi?id=3D2643,
the
>messages disappear, but the interrupts still do not work.
>
>Any ideas?
>Best regards,
>Stefan


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
