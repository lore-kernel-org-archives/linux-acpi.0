From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 1/4] ACPI/PPTT: Add function to return ACPI 6.3 Identical tokens
Date: Tue, 26 Mar 2019 17:39:35 -0500
Message-ID: <20190326223938.5365-2-jeremy.linton@arm.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190326223938.5365-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, james.morse@arm.com, lorenzo.pieralisi@arm.com, linuxarm@huawei.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-acpi@vger.kernel.org

ACPI 6.3 adds a flag to indicate that child nodes are all
identical cores. This is useful to authoritatively determine
if a set of (possibly offline) cores are identical or not.

Since the flag doesn't give us a unique id we can generate
one and use it to create bitmaps of sibling nodes, or simply
in a loop to determine if a subset of cores are identical.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
 include/linux/acpi.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 065c4fc245d1..472c95ec816b 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_PHYSICAL_PACKAGE);
 }
+
+/**
+ * find_acpi_cpu_topology_hetero_id() - Determine a unique implementation
+ * @cpu: Kernel logical cpu number
+ *
+ * Determine a unique heterogeneous ID for the given CPU. CPUs with the same
+ * implementation should have matching IDs. Since this is a tree we can only
+ * detect implementations where the heterogeneous flag is the parent to all
+ * matching cores. AKA if a two socket machine has two different core types
+ * in each socket this will end up being represented as four unique core types
+ * rather than two.
+ *
+ * The returned ID can be used to group peers with identical implementation.
+ *
+ * The search terminates when a level is found with the identical implementation
+ * flag set or we reach a root node.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents a group of identical cores
+ * similar to this cpu.
+ */
+int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
+{
+	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
+					  ACPI_PPTT_ACPI_IDENTICAL);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..1444fb042898 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1309,6 +1309,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #ifdef CONFIG_ACPI_PPTT
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
+int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
 #else
 static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
@@ -1319,6 +1320,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
 {
 	return -EINVAL;
 }
+static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
+{
+	return -EINVAL;
+}
 static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 {
 	return -EINVAL;
-- 
2.20.1
