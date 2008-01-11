From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] increase PNP_MAX_PORT to 40 from 24
Date: Fri, 11 Jan 2008 15:11:27 -0500
Message-ID: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:58901 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760397AbYAKUkc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:32 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

a7839e960675b549f06209d18283d5cee2ce9261
(PNP: increase the maximum number of resources)
increased PNP_MAX_PORT to 24 from 8.
It also added a test and a complaint when a
machine exceeded the limit, causing:

pnpacpi: exceeded the max number of IO resources: 24

http://bugzilla.kernel.org/show_bug.cgi?id=9535

We should have been squawking about this all along,
as this is a potentially serious issue.

For now, simply burn some dynamic bytes and
increase the limit by another 16 to 40.
There is no guarantee that this will satisfy
every system on Earth.  It probably will not,
but it should be an improvement.

In the future, PNPACPI should allocate resource
structures as needed, rather than max-sized arrays.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/pnp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index 0a0426c..2a6d62c 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -13,7 +13,7 @@
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 
-#define PNP_MAX_PORT		24
+#define PNP_MAX_PORT		40
 #define PNP_MAX_MEM		12
 #define PNP_MAX_IRQ		2
 #define PNP_MAX_DMA		2
-- 
1.5.4.rc2.84.gf85fd

