From: Len Brown <len.brown@intel.com>
Subject: [PATCH 20/28] ACPI: acpi_pci_link_set() can allocate with either GFP_ATOMIC or GFP_KERNEL
Date: Sat, 14 Oct 2006 04:06:01 -0400
Message-ID: <1160813196962-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15632 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752140AbWJNIDO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:14 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <168a328f30e9d1a8bc6ff55c0501e0bdc08bee60.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Thu, 24 Aug 2006 00:36:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Len Brown <len.brown@intel.com>

From: Jiri Kosina <jikos@jikos.cz>

acpi_pci_link_set() allocates both with interrupts on
and with interrupts off (resume-time), so check interrupts
and decide on GFP_ATOMIC or GFP_KERNEL at run-time.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_link.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 7f3e7e7..d53bd98 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -307,7 +307,7 @@ static int acpi_pci_link_set(struct acpi
 	if (!link || !irq)
 		return -EINVAL;
 
-	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
+	resource = kmalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
 	if (!resource)
 		return -ENOMEM;
 
-- 
1.4.3.rc2.g23bed-dirty
