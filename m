From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/26] kernel-doc: fix pci-acpi warning
Date: Thu, 21 Feb 2008 04:25:14 -0500
Message-ID: <5958f1a4da39581074bab50cabd0a582e651b90f.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36615 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754596AbYBUJ3B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:01 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix PCI kernel-doc warning:
Warning(linux-2.6.24-git12//drivers/pci/pci-acpi.c:166): No description found for parameter 'hid'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e569645..2f2d308 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -158,6 +158,7 @@ run_osc_out:
 /**
  * __pci_osc_support_set - register OS support to Firmware
  * @flags: OS support bits
+ * @hid: hardware ID
  *
  * Update OS support fields and doing a _OSC Query to obtain an update
  * from Firmware on supported control bits.
-- 
1.5.4.2

