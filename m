From: "DPR" <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Tue, 4 Mar 2003 19:54:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000001c2e27f$74ae2910$0200a8c0@brutzler>
References: <F760B14C9561B941B89469F59BA3A84725A1C9@orsmsx401.jf.intel.com>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A1C9-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Grover, Andrew'" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> The device's driver calls pci_enable_device, which calls:
> pci_enable_device_bars, which calls:
> pcibios_enable_device, which calls:
> pcibios_enable_irq, which is a function pointer we set to
> acpi_pci_irq_enable, which does an eisa_set_level_irq(), thus setting
> the interrupt (if less than 16) to level-triggered.
> 
> So why isn't it working? Hmm.

Perhaps these messages from "pcibios_enable_irq" will help you finding the error ...

<4>PCI: No IRQ known for interrupt pin A of device 00:10.0
<4>PCI: No IRQ known for interrupt pin B of device 00:10.1
<4>PCI: No IRQ known for interrupt pin C of device 00:10.2
<4>PCI: No IRQ known for interrupt pin D of device 00:10.3
<4>PCI: No IRQ known for interrupt pin A of device 00:11.1 - using IRQ 255
<4>PCI: No IRQ known for interrupt pin A of device 00:12.0

The devices 00:10.0 up to 00:10.3 are my USB 1.1/2.0 controllers, device 00:11.1 is my EIDE
controller and device 00:12.0 is my ethernet adapter.

Regards,

HOLGER



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
