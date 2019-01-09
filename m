From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv3 08/13] Documentation/ABI: Add node performance attributes
Date: Wed,  9 Jan 2019 10:43:36 -0700
Message-ID: <20190109174341.19818-9-keith.busch@intel.com>
References: <20190109174341.19818-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109174341.19818-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add descriptions for memory class initiator performance access attributes.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index a9c47b4b0eee..74cfc80cabf6 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -114,3 +114,31 @@ Description:
 		The node list of memory targets that this initiator node has
 		class "Y" access. Memory accesses from this node to nodes not
 		in this list may have differet performance.
+
+What:		/sys/devices/system/node/nodeX/classY/read_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's read bandwidth in MB/s available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/read_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's read latency in nanosecondss available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/write_bandwidth
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's write bandwidth in MB/s available to memory
+		initiators in nodes found in this class's initiators_nodelist.
+
+What:		/sys/devices/system/node/nodeX/classY/write_latency
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This node's write latency in nanosecondss available to memory
+		initiators in nodes found in this class's initiators_nodelist.
-- 
2.14.4
