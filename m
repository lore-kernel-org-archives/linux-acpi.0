From: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: IBM T41 + ACPI + APIC
Date: Thu, 12 Aug 2004 15:02:19 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.08.12.12.02.19.385237@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have an IBM T41 with FC2.
I compiled a 2.6.8-rc3 kernel with ACPI and LAPIC support.
In dmesg I find:

......
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
......
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11)
......

Is something wrong with my local APIC ? 
Why ACPI is still using PIC instead of LAPIC ?
No sign of LAPIC in /proc/interupts :

cat /proc/interrupts 
           CPU0       
  0:   13340193          XT-PIC  timer
  1:      12558          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  Intel 82801DB-ICH4
  4:          0          XT-PIC  uhci_hcd
  5:        246          XT-PIC  uhci_hcd
  8:          1          XT-PIC  rtc
  9:      13952          XT-PIC  acpi
 10:      74704          XT-PIC  uhci_hcd, eth0
 12:     225583          XT-PIC  i8042
 14:     102543          XT-PIC  ide0
 15:       7076          XT-PIC  ide1
NMI:          0 
ERR:          0

Thanks,
Paul




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
