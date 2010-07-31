From: Julia Lawall <julia@diku.dk>
Subject: [PATCH] drivers/acpi: call rcu_read_unlock in default case
Date: Sat, 31 Jul 2010 22:35:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1007312234590.12199@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:42323 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391Ab0GaUfa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Jul 2010 16:35:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Adjust the default case so that it benefits from the call to rcu_read_unlock.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@rcu@
position p1;
@@

rcu_read_lock@p1();
...
rcu_read_unlock();

@@
position rcu.p1;
@@

*rcu_read_lock@p1();
... when != rcu_read_unlock();
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/acpi/atomicio.c             |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
index 8f8bd73..f426010 100644
--- a/drivers/acpi/atomicio.c
+++ b/drivers/acpi/atomicio.c
@@ -267,6 +267,7 @@ EXPORT_SYMBOL_GPL(acpi_post_unmap_gar);
 static int acpi_atomic_read_mem(u64 paddr, u64 *val, u32 width)
 {
 	void __iomem *addr;
+	int res = 0;
 
 	rcu_read_lock();
 	addr = __acpi_ioremap_fast(paddr, width);
@@ -284,16 +285,17 @@ static int acpi_atomic_read_mem(u64 paddr, u64 *val, u32 width)
 		*val = readq(addr);
 		break;
 	default:
-		return -EINVAL;
+		res = -EINVAL;
 	}
 	rcu_read_unlock();
 
-	return 0;
+	return res;
 }
 
 static int acpi_atomic_write_mem(u64 paddr, u64 val, u32 width)
 {
 	void __iomem *addr;
+	int res = 0;
 
 	rcu_read_lock();
 	addr = __acpi_ioremap_fast(paddr, width);
@@ -311,11 +313,11 @@ static int acpi_atomic_write_mem(u64 paddr, u64 val, u32 width)
 		writeq(val, addr);
 		break;
 	default:
-		return -EINVAL;
+		res = -EINVAL;
 	}
 	rcu_read_unlock();
 
-	return 0;
+	return res;
 }
 
 /* GAR accessing in atomic (including NMI) or process context */
