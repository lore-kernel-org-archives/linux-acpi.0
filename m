From: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 10/12] Documentation/ABI: Add node cache attributes
Date: Mon, 10 Dec 2018 18:03:08 -0700
Message-ID: <20181211010310.8551-11-keith.busch@intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211010310.8551-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Add the attributes for the system memory side caches.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 6cdb0643f9fd..63a757b8a29e 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -151,3 +151,37 @@ Contact:	Keith Busch <keith.busch@intel.com>
 Description:
 		Write latency in nanosecondss available to memory initiators
 		found in primary_cpu_nodemask.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/associativity
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The caches associativity: 0 for direct mapped, non-zero if
+		indexed.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/level
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		This cache's level in the memory hierarchy. Matches 'Y' in the
+		directory name.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/line_size
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The number of bytes accessed from the next cache level on a
+		cache miss.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/size
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The size of this memory side cache in bytes.
+
+What:		/sys/devices/system/node/nodeX/side_cache/indexY/write_policy
+Date:		December 2018
+Contact:	Keith Busch <keith.busch@intel.com>
+Description:
+		The cache write policy: 0 for write-back, 1 for write-through,
+		2 for other or unknown.
-- 
2.14.4
