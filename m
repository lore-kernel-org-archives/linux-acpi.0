From: Len Brown <len.brown@intel.com>
Subject: [PATCH 21/28] ACPI: update comments in motherboard.c
Date: Sat, 14 Oct 2006 04:06:02 -0400
Message-ID: <11608131973927-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15632 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752136AbWJNIDP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:15 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <f4d2e2d87eac0338884b2c26f6bafed115dbac5e.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Thu, 14 Sep 2006 17:16:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/motherboard.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/motherboard.c b/drivers/acpi/motherboard.c
index ec6b7f9..2e17ec7 100644
--- a/drivers/acpi/motherboard.c
+++ b/drivers/acpi/motherboard.c
@@ -48,6 +48,12 @@ #define IS_RESERVED_ADDR(base, len) \
  * the io ports if they really know they can use it, while
  * still preventing hotplug PCI devices from using it.
  */
+
+/*
+ * When CONFIG_PNP is enabled, pnp/system.c binds to PNP0C01
+ * and PNP0C02, redundant with acpi_reserve_io_ranges().
+ * But acpi_reserve_io_ranges() is necessary for !CONFIG_PNP.
+ */
 static acpi_status acpi_reserve_io_ranges(struct acpi_resource *res, void *data)
 {
 	struct resource *requested_res = NULL;
-- 
1.4.3.rc2.g23bed-dirty
