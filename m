From: Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/7] doc/vm: New documentation for memory cache
Date: Wed, 14 Nov 2018 15:49:18 -0700
Message-ID: <20181114224921.12123-6-keith.busch@intel.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114224921.12123-2-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>, Keith Busch <keith.busch@intel.com>
List-Id: linux-acpi@vger.kernel.org

Platforms may provide system memory that contains side caches to help
spped up access. These memory caches are part of a memory node and
the cache attributes are exported by the kernel.

Add new documentation providing a brief overview of system memory side
caches and the kernel provided attributes for application optimization.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 Documentation/vm/numacache.rst | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/vm/numacache.rst

diff --git a/Documentation/vm/numacache.rst b/Documentation/vm/numacache.rst
new file mode 100644
index 000000000000..e79c801b7e3b
--- /dev/null
+++ b/Documentation/vm/numacache.rst
@@ -0,0 +1,76 @@
+.. _numacache:
+
+==========
+NUMA Cache
+==========
+
+System memory may be constructed in a hierarchy of various performing
+characteristics in order to provide large address space of slower
+performing memory cached by a smaller size of higher performing
+memory. The system physical addresses that software is aware of see
+is provided by the last memory level in the hierarchy, while higher
+performing memory transparently provides caching to slower levels.
+
+The term "far memory" is used to denote the last level memory in the
+hierarchy. Each increasing cache level provides higher performing CPU
+access, and the term "near memory" represents the highest level cache
+provided by the system. This number is different than CPU caches where
+the cache level (ex: L1, L2, L3) uses a CPU centric view with each level
+being lower performing and closer to system memory. The memory cache
+level is centric to the last level memory, so the higher numbered cache
+level denotes memory nearer to the CPU, and further from far memory.
+
+The memory side caches are not directly addressable by software. When
+software accesses a system address, the system will return it from the
+near memory cache if it is present. If it is not present, the system
+accesses the next level of memory until there is either a hit in that
+cache level, or it reaches far memory.
+
+In order to maximize the performance out of such a setup, software may
+wish to query the memory cache attributes. If the system provides a way
+to query this information, for example with ACPI HMAT (Heterogeneous
+Memory Attribute Table)[1], the kernel will append these attributes to
+the NUMA node that provides the memory.
+
+When the kernel first registers a memory cache with a node, the kernel
+will create the following directory::
+
+	/sys/devices/system/node/nodeX/cache/
+
+If that directory is not present, then either the memory does not have
+a side cache, or that information is not provided to the kernel.
+
+The attributes for each level of cache is provided under its cache
+level index::
+
+	/sys/devices/system/node/nodeX/cache/indexA/
+	/sys/devices/system/node/nodeX/cache/indexB/
+	/sys/devices/system/node/nodeX/cache/indexC/
+
+Each cache level's directory provides its attributes. For example,
+the following is a single cache level and the attributes available for
+software to query::
+
+	# tree sys/devices/system/node/node0/cache/
+	/sys/devices/system/node/node0/cache/
+	|-- index1
+	|   |-- associativity
+	|   |-- level
+	|   |-- line_size
+	|   |-- size
+	|   `-- write_policy
+
+The cache "associativity" will be 0 if it is a direct-mapped cache, and
+non-zero for any other indexed based, multi-way associativity.
+
+The "level" is the distance from the far memory, and matches the number
+appended to its "index" directory.
+
+The "line_size" is the number of bytes accessed on a cache miss.
+
+The "size" is the number of bytes provided by this cache level.
+
+The "write_policy" will be 0 for write-back, and non-zero for
+write-through caching.
+
+[1] https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
-- 
2.14.4
