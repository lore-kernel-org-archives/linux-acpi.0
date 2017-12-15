From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] MAINTAINERS: Include more PCI files
Date: Fri, 15 Dec 2017 16:53:07 -0600
Message-ID: <20171215225307.175987.4972.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755795AbdLOWxK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Dec 2017 17:53:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add more PCI files to the PCI subsystem.

I expect Rafael to continue merging things in drivers/acpi/pci*, but it's
nice to have linux-pci included on patches.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 MAINTAINERS |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa71ab52fd76..6fcc9b8bab52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10551,8 +10551,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/
 F:	Documentation/PCI/
+F:	drivers/acpi/pci*
 F:	drivers/pci/
+F:	include/asm-generic/pci*
 F:	include/linux/pci*
+F:	include/uapi/linux/pci*
+F:	lib/pci*
 F:	arch/x86/pci/
 F:	arch/x86/kernel/quirks.c
 

