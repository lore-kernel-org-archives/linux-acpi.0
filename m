From: Len Brown <lenb@kernel.org>
Subject: [PATCH 8/8] ACPI: video: prevent NULL deref in acpi_get_pci_dev()
Date: Fri, 26 Jun 2009 00:20:20 -0400
Message-ID: <c2304baa8b293121e198a625e25902d439109a30.1245989983.git.len.brown@intel.com>
References: <1245990020-20455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:38147 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbZFZEVK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Jun 2009 00:21:10 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KLT00LBXW2D99B3@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 25 Jun 2009 23:20:43 -0500 (CDT)
In-reply-to: <1245990020-20455-1-git-send-email-lenb@kernel.org>
In-reply-to: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
References: <6af05c22969dce2776375953131b56e9f4282848.1245989983.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Troy Moure <twmoure@szypr.net>, Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Troy Moure <twmoure@szypr.net>

ref: http://thread.gmane.org/gmane.linux.kernel/857228/focus=857468

When the ACPI video driver initializes, it does a namespace walk
looking for for supported devices. When we find an appropriate
handle, we walk up the ACPI tree looking for a PCI root bus, and
then walk back down the PCI bus, assuming that every device
inbetween is a P2P bridge.

This assumption is not correct, and is reported broken on at
least:

	Dell Latitude E6400
	ThinkPad X61
	Dell XPS M1330

Add a NULL deref check to prevent boot panics.

Reported-by: Alessandro Suardi <alessandro.suardi@gmail.com>
Signed-off-by: Troy Moure <twmoure@szypr.net>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/pci_root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 8a5bf3b..55b5b90 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -395,7 +395,7 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle handle)
 		fn  = adr & 0xffff;
 
 		pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
-		if (hnd == handle)
+		if (!pdev || hnd == handle)
 			break;
 
 		pbus = pdev->subordinate;
-- 
1.6.0.6

