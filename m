From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/26] PCI ACPI: Fix comment describing acpi_pci_choose_state
Date: Thu, 21 Feb 2008 04:38:10 -0500
Message-ID: <c6868ea00bdebe5762fa59e54b74b4cd4e3b4e6e.1203586624.git.len.brown@intel.com>
References: <1203586691-1234-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15600 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762473AbYBUJjT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:39:19 -0500
In-Reply-To: <1203586691-1234-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203586624.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

The last line of the comment preceding the definition of
acpi_pci_choose_state() is incorrect.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/pci-acpi.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e569645..e818e52 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -241,8 +241,6 @@ EXPORT_SYMBOL(pci_osc_control_set);
  *	choose from highest power _SxD to lowest power _SxW
  * else // no _PRW at S-state x
  * 	choose highest power _SxD or any lower power
- *
- * currently we simply return _SxD, if present.
  */
 
 static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
-- 
1.5.4

