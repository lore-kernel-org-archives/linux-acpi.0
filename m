From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Tue, 4 Mar 2003 10:21:28 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1C9@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org] 
> > In theory, ACPI comes through later and changes the irqs < 15 
> > with possible PCI devices by calling io_apic_set_pci_routing.
> >
> > So *in theory* it should work ok. Obviously something is not right.
> 
> How does ACPI, when it comes through later, know which irq's < 15 are
> for PCI devices?

The device's driver calls pci_enable_device, which calls:
pci_enable_device_bars, which calls:
pcibios_enable_device, which calls:
pcibios_enable_irq, which is a function pointer we set to
acpi_pci_irq_enable, which does an eisa_set_level_irq(), thus setting
the interrupt (if less than 16) to level-triggered.

So why isn't it working? Hmm.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
