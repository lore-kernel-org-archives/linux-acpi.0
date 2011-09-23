From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] x86/PCI: fix boot-time memory leak
Date: Fri, 23 Sep 2011 10:59:46 -0600
Message-ID: <20110923165946.27079.95660.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:1826 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687Ab1IWRAB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Sep 2011 13:00:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Simon Kirby <sim@hostway.ca>, Catalin Marinas <catalin.marinas@arm.com>

If we're not using _CRS, the host bridge's bus name and resource structures
were allocated but never freed.  This patch fixes that.

Patch by Catalin Marinas <catalin.marinas@arm.com>

Reported-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
Reported-by: Simon Kirby <sim@hostway.ca>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/x86/pci/acpi.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index c953302..6fdc90f 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -228,9 +228,6 @@ static void add_resources(struct pci_root_info *info)
 	int i;
 	struct resource *res, *root, *conflict;
 
-	if (!pci_use_crs)
-		return;
-
 	coalesce_windows(info, IORESOURCE_MEM);
 	coalesce_windows(info, IORESOURCE_IO);
 
@@ -285,8 +282,11 @@ get_current_resources(struct acpi_device *device, int busnum,
 	acpi_walk_resources(device->handle, METHOD_NAME__CRS, setup_resource,
 				&info);
 
-	add_resources(&info);
-	return;
+	if (pci_use_crs) {
+		add_resources(&info);
+		return;
+	}
+	kfree(info.name);
 
 name_alloc_fail:
 	kfree(info.res);

