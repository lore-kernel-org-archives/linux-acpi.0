From: "DPR" <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Wed, 5 Mar 2003 22:51:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000501c2e361$5f21d1e0$0200a8c0@brutzler>
References: <000001c2e27f$74ae2910$0200a8c0@brutzler>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000001c2e27f$74ae2910$0200a8c0-IGm5bqYn3xw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'Grover, Andrew'" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "'Cagle, John (ISS-Houston)'" <john.cagle-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Perhaps these messages from "pcibios_enable_irq" will help 
> you finding the error ...

Sorry, the messages don't come from "pcibios_enable_irq" but from "acpi_pci_irq_init".
So this seems to be my problem because the following code snippet in "acpi_pci_irq_enable" will
never be executed (at least in my case)

	dev->irq = irq;

	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device %s using IRQ %d\n", dev->slot_name, dev->irq));

	/* 
	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
	 */
#ifdef CONFIG_X86
	if ((dev->irq < 16) &&  !((1 << dev->irq) & irq_mask)) {
		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Setting IRQ %d as level-triggered\n",
dev->irq));
		irq_mask |= (1 << dev->irq);
		eisa_set_level_irq(dev->irq);
	}
#endif

	return_VALUE(dev->irq);


Regards,

HOLGER



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
