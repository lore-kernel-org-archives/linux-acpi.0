From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 18:58:15 +0200
Message-ID: <200807081858.16321.rjw@sisk.pl>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com> <200807081712.23937.rjw@sisk.pl> <a4423d670807080929t3254393jc501e703d6ffb26e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40752 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939AbYGHQ43 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 12:56:29 -0400
In-Reply-To: <a4423d670807080929t3254393jc501e703d6ffb26e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>, jbarnes@virtuousgeek.org
Cc: ak@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> 2008/7/8 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> >> Hi Rafael
> >>
> >> drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
> >> drivers/pci/pci-acpi.c:311: error: implicit declaration of function
> >> 'acpi_pm_device_sleep_wake'
> >
> > I guess this is a compilation with CONFIG_ACPI=y and CONFIG_PM_SLEEP unset.
> Indeed.
> >
> > In that case the appended patch should help.  Please test and report back (I
> > can't test linux-next compilation at the moment).
> 
> Compilation test passed and the kernel can boot.

Thanks!

Jesse, could you please apply the patch below to the linux-next branch, on top
of the PCI wake-up patchset?

Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

PCI ACPI: Fix compilation of pci-acpi.c

Fix compilation of pci-acpi.c with CONFIG_ACPI set and
CONFIG_PM_SLEEP unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Tested-by: Alexander Beregalov <a.beregalov@gmail.com>
---
 include/acpi/acpi_bus.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-next/include/acpi/acpi_bus.h
===================================================================
--- linux-next.orig/include/acpi/acpi_bus.h
+++ linux-next/include/acpi/acpi_bus.h
@@ -388,6 +388,10 @@ static inline int acpi_pm_device_sleep_s
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
+static inline int acpi_pm_device_sleep_wake(struct device *d, bool b)
+{
+	return -ENOSYS;
+}
 #endif /* !CONFIG_PM_SLEEP */
 
 #endif				/* CONFIG_ACPI */
