From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 04/12] Documentation/ABI: Add new node sysfs attributes
Date: Mon, 10 Dec 2018 18:03:02 -0700
Message-ID: <20181211010310.8551-5-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add the entries for primary cpu and memory node attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 3e90e1f3bf0a..8430d5b261f6 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -90,4 +90,36 @@ Date:		December 2009
 Contact:	Lee Schermerhorn <lee.schermerhorn@hp.com>
 Description:
 		The node's huge page size control/query attributes.
-		See Documentation/admin-guide/mm/hugetlbpage.rst
\ No newline at end of file
+		See Documentation/admin-guide/mm/hugetlbpage.rst
+
+What:		/sys/devices/system/node/nodeX/primary_cpu_nodelist
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The node list of CPUs that have primary access to this node's
+		memory. CPUs not in the list accessing this node's memory may
+		encounter a performance penalty.
+
+What:		/sys/devices/system/node/nodeX/primary_cpu_nodemask
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The node map for CPUs that have primary access to this node's
+		memory. CPUs not in the list accessing this node's memory may
+		encounter a performance penalty.
+
+What:		/sys/devices/system/node/nodeX/primary_mem_nodelist
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The list of memory nodes that this node has primary access.
+		Memory accesses from this node to nodes not in this list may
+		encounter a performance penalty.
+
+What:		/sys/devices/system/node/nodeX/primary_mem_nodemask
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The map of memory nodes that this node has primary access.
+		Memory accesses from this node to nodes not in this map may
+		encounter a performance penalty.
-- 
2.14.4
