From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFCv2 1/4] ACPI: NUMA: export pxm_to_node
Date: Wed, 23 May 2018 20:24:01 +0200
Message-ID: <20180523182404.11433-2-david@redhat.com>
References: <20180523182404.11433-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523182404.11433-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Will be needed by paravirtualized memory devices.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/acpi/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 85167603b9c9..7ffee2959350 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -50,6 +50,7 @@ int pxm_to_node(int pxm)
 		return NUMA_NO_NODE;
 	return pxm_to_node_map[pxm];
 }
+EXPORT_SYMBOL(pxm_to_node);
 
 int node_to_pxm(int node)
 {
-- 
2.17.0
