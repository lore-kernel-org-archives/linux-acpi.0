From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 07/12] Documentation/ABI: Add node performance attributes
Date: Mon, 10 Dec 2018 18:03:05 -0700
Message-ID: <20181211010310.8551-8-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add descriptions for primary memory initiator performance access
attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 8430d5b261f6..6cdb0643f9fd 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -123,3 +123,31 @@ Description:
 		The map of memory nodes that this node has primary access.
 		Memory accesses from this node to nodes not in this map may
 		encounter a performance penalty.
+
+What:		/sys/devices/system/node/nodeX/primary_initiator_access/read_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		Read bandwidth in MB/s available to memory initiators found in
+		primary_cpu_nodemask.
+
+What:		/sys/devices/system/node/nodeX/primary_initiator_access/read_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		Read latency in nanosecondss available to memory initiators
+		found in primary_cpu_nodemask.
+
+What:		/sys/devices/system/node/nodeX/primary_initiator_access/write_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		Write bandwidth in MB/s available to memory initiators found in
+		primary_cpu_nodemask.
+
+What:		/sys/devices/system/node/nodeX/primary_initiator_access/write_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		Write latency in nanosecondss available to memory initiators
+		found in primary_cpu_nodemask.
-- 
2.14.4
