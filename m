From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: PCI IRQ routing table
Date: Thu, 31 Mar 2005 11:08:56 -0700
Message-ID: <1112292536.22598.10.camel@eeyore>
References: <20050331095849.25312.qmail@webmail7.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050331095849.25312.qmail-dvNlIvcwX/N1RbMNNJCVHYkgB36zAFJh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: art stallone <art_stallone-QOiod4cnrWAN+BqQ9rBEUg@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2005-03-31 at 09:58 +0000, art stallone wrote:
> Do ACPI caches PCI IRQ routing table (PIR).
> Is there any ioctl so user space can get that table?

I don't know much about the PIR.  ACPI uses a PCI Routing
Table (_PRT).  ACPI supplies a _PRT for every PCI root bridge.
The ACPI PCI root bridge driver (drivers/acpi/pci_root.c)
parses the _PRT when it claims a new bridge (see the
acpi_pci_root_add() -> acpi_pci_irq_add_prt() path).

There is no convenient user-space mechanism to get the
_PRT.  The _PRT is stored in the DSDT, which you *can*
get, via /proc/acpi/dsdt.  But then you have to disassemble
the DSDT and parse the _PRT yourself.  I.e., you would do
something like "cp /proc/acpi/dsdt dsdt; iasl -d dsdt;
cat dsdt.dsl".

You can get iasl here:
    http://www.intel.com/technology/IAPC/acpi/downloads.htm



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
