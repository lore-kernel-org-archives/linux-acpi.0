From: Myron Stowe <myron.stowe@redhat.com>
Subject: [PATCH] ACPI: Fix logic for removing mappings in 'acpi_unmap'
Date: Thu, 09 Feb 2012 09:36:41 -0700
Message-ID: <20120209163641.26858.59399.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29729 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978Ab2BIQgs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Feb 2012 11:36:48 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, ying.huang@intel.com, tony.luck@intel.com, bhelgaas@google.com, trenn@suse.de, linux-kernel@vger.kernel.org

From: Myron Stowe <mstowe@redhat.com>

Make sure the removal of mappings uses the same logic that put the
mappings in place.

Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
---

 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 412a1e0..5aef087 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -347,7 +347,7 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
 	unsigned long pfn;
 
 	pfn = pg_off >> PAGE_SHIFT;
-	if (page_is_ram(pfn))
+	if (should_use_kmap(pfn))
 		kunmap(pfn_to_page(pfn));
 	else
 		iounmap(vaddr);

