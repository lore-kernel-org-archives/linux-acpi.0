From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: Re: Possible quick fix for ACPI routing problem on Nforce2
Date: Mon, 14 Jul 2003 00:51:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307140051.29231.adq_dvb@lidskialf.net>
References: <200307122352.45704.adq_dvb@lidskialf.net> <200307130218.44398.adq_dvb@lidskialf.net> <20030713053913.GB1284@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030713053913.GB1284-4cpIIuwL6H0O5nXqB3HebLNAH6kLmebB@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: thunder7-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> No joy on VIA KT400 chipset (bugzilla #678): ide0 get's IRQ 17, during
> boot multiple oopses occur, starting with 'IRQ 17: nobody cared' right
> after probing hda. Eventually it crashes hard, after probing hde.

Looking at your dmesg dump from 2.5.75, another problem is here, where it 
tries to route lots of your PCI IRQs to IRQ 0. It seems to be failing to 
program the IRQs. No idea why yet. 

BTW: is there a way to get more detailed debug output on ACPI? There are loads 
more debugging print statements in the code than are appearing in your dmesg 
(or in mine as well) even with ACPI Debug statements turned on.

pci_link-0256 [21] acpi_pci_link_get_curr: No IRQ resource found 
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0
pci_link-0256 [22] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 0
pci_link-0256 [23] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 0
pci_link-0256 [24] acpi_pci_link_get_curr: No IRQ resource found
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 0



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
