From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: build failure after merge of the final tree (linus' tree related)
Date: Sat, 15 Jan 2011 21:01:57 +0100
Message-ID: <201101152101.57533.rjw@sisk.pl>
References: <20110115133412.58b8cd89.sfr@canb.auug.org.au> <201101151419.16758.rjw@sisk.pl> <20110116024434.3a5ccabb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20110116024434.3a5ccabb.sfr@canb.auug.org.au>
Sender: linux-pci-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Ozan Caglayan <ozan@pardus.org.tr>, Linus <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Saturday, January 15, 2011, Stephen Rothwell wrote:
> Hi Raphael,
> 
> On Sat, 15 Jan 2011 14:19:16 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > It looks like the non-CONFIG_ACPI version of acpi_find_root_bridge_handle()
> > is just not necessary any more, because acpi_find_root_bridge_handle() is only
> > used in code that depends on CONFIG_ACPI.
> > 
> > A patch removing it is appended, please test.
> 
> That fixes the compile error for my powerpc allyesconfig build.
> And my x86_64 allmodconfig and i386 defconfig builds still work.

Cool, thanks.

It goes again below, with a changelog.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PCI / ACPI: Fix build of the AER driver for !CONFIG_ACPI

After commit 415e12b (PCI/ACPI: Request _OSC control once for each
root bridge (v3)) include/linux/pci-acpi.h is included by
drivers/pci/pcie/aer/aerdrv.c and if CONFIG_ACPI is unset, the
bogus and unnecessary alternative definition of
acpi_find_root_bridge_handle() causes a build error to occur.

Remove the offending piece of garbage.

Reported-and-tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pci-acpi.h |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-2.6/include/linux/pci-acpi.h
===================================================================
--- linux-2.6.orig/include/linux/pci-acpi.h
+++ linux-2.6/include/linux/pci-acpi.h
@@ -35,9 +35,6 @@ static inline acpi_handle acpi_pci_get_b
 	return acpi_get_pci_rootbridge_handle(pci_domain_nr(pbus),
 					      pbus->number);
 }
-#else
-static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
-{ return NULL; }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
