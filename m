From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH] ACPI/NUMA: Do not map pxm to node when NUMA is turned off
Date: Mon, 12 Dec 2016 14:29:53 -0500
Message-ID: <1481570993-13941-2-git-send-email-boris.ostrovsky@oracle.com>
References: <1481570993-13941-1-git-send-email-boris.ostrovsky@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481570993-13941-1-git-send-email-boris.ostrovsky@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-acpi@vger.kernel.org

Otherwise we may unexpectedly reference a non-zero node via, for example,
acpi_get_node() while other parts of the kernel assume that only node 0
(which is what NUMA_NO_NODE is supposed to be converted to) is
available.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/acpi/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index ce3a7a1..edb0c79 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -70,7 +70,7 @@ int acpi_map_pxm_to_node(int pxm)
 {
 	int node;
 
-	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS)
+	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
 		return NUMA_NO_NODE;
 
 	node = pxm_to_node_map[pxm];
-- 
1.8.3.1
