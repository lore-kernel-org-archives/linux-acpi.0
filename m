From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PATCH] acpi-20030916-2.6.0-pre5.diff
Date: Thu, 18 Sep 2003 15:54:21 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030918155421.35548055.akpm@osdl.org>
References: <20030823150219.21c951aa.akpm@osdl.org>
	<1063926206.2680.200.camel@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1063926206.2680.200.camel-Tk/TtsB/rErDOqzlkpFKJg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andi Kleen <ak-h9bWGtP8wOw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> This patch updates 2.6.0-test5 to the current ACPI in 2.4.22-pre5
> If nothing explodes, I'll be releasing it to Linus shortly via BK.

And it doesn't include this fix


From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>

Try this (untested) patch

(2.6 version untested, I tested a similar patch on the 2.4 backport of
ACPI):



 25-akpm/arch/i386/pci/acpi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/pci/acpi.c~acpi_off-fix arch/i386/pci/acpi.c
--- 25/arch/i386/pci/acpi.c~acpi_off-fix	Tue Sep  9 12:12:00 2003
+++ 25-akpm/arch/i386/pci/acpi.c	Tue Sep  9 12:12:00 2003
@@ -15,10 +15,11 @@ struct pci_bus * __devinit pci_acpi_scan
 
 static int __init pci_acpi_init(void)
 {
+	extern int acpi_disabled;
 	if (pcibios_scanned)
 		return 0;
 
-	if (!(pci_probe & PCI_NO_ACPI_ROUTING)) {
+	if (!(pci_probe & PCI_NO_ACPI_ROUTING) && !acpi_disabled) {
 		if (!acpi_pci_irq_init()) {
 			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
 			printk(KERN_INFO "PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'\n");

_



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
