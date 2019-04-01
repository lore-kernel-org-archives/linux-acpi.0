From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH v2 1/3] ACPI: Support Generic Initiator only domains
Date: Mon, 1 Apr 2019 23:36:01 +0800
Message-ID: <20190401153603.67775-2-Jonathan.Cameron@huawei.com>
References: <20190401153603.67775-1-Jonathan.Cameron@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401153603.67775-1-Jonathan.Cameron@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: keith.busch@intel.com, jglisse@redhat.com, rjw@rjwysocki.net, linuxarm@huawei.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-acpi@vger.kernel.org

Generic Initiators are a new ACPI concept that allows for the
description of proximity domains that contain a device which
performs memory access (such as a network card) but neither
host CPU nor Memory.

This patch has the parsing code and provides the infrastructure
for an architecture to associate these new domains with their
nearest memory processing node.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa.c            | 62 +++++++++++++++++++++++++++++++++-
 drivers/base/node.c            |  3 ++
 include/asm-generic/topology.h |  3 ++
 include/linux/nodemask.h       |  1 +
 include/linux/topology.h       |  7 ++++
 5 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 867f6e3f2b4f..b08ceea5e546 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -184,6 +184,38 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_SRAT_TYPE_GENERIC_AFFINITY:
+	{
+		struct acpi_srat_generic_affinity *p =
+			(struct acpi_srat_generic_affinity *)header;
+		char name[9] = {};
+
+		if (p->device_handle_type == 0) {
+			/*
+			 * For pci devices this may be the only place they
+			 * are assigned a proximity domain
+			 */
+			pr_debug("SRAT Generic Initiator(Seg:%u BDF:%u) in proximity domain %d %s\n",
+				 *(u16 *)(&p->device_handle[0]),
+				 *(u16 *)(&p->device_handle[2]),
+				 p->proximity_domain,
+				 (p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
+				"enabled" : "disabled");
+		} else {
+			/*
+			 * In this case we can rely on the device having a
+			 * proximity domain reference
+			 */
+			memcpy(name, p->device_handle, 8);
+			pr_info("SRAT Generic Initiator(HID=%.8s UID=%.4s) in proximity domain %d %s\n",
+				(char *)(&p->device_handle[0]),
+				(char *)(&p->device_handle[8]),
+				p->proximity_domain,
+				(p->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED) ?
+				"enabled" : "disabled");
+		}
+	}
+	break;
 	default:
 		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
 			header->type);
@@ -392,6 +424,32 @@ acpi_parse_gicc_affinity(struct acpi_subtable_header *header,
 	return 0;
 }
 
+static int __init
+acpi_parse_gi_affinity(struct acpi_subtable_header *header,
+		       const unsigned long end)
+{
+	struct acpi_srat_generic_affinity *gi_affinity;
+	int node;
+
+	gi_affinity = (struct acpi_srat_generic_affinity *)header;
+	if (!gi_affinity)
+		return -EINVAL;
+	acpi_table_print_srat_entry(header);
+
+	if (!(gi_affinity->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
+		return -EINVAL;
+
+	node = acpi_map_pxm_to_node(gi_affinity->proximity_domain);
+	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
+		pr_err("SRAT: Too many proximity domains.\n");
+		return -EINVAL;
+	}
+	node_set(node, numa_nodes_parsed);
+	node_set_state(node, N_GENERIC_INITIATOR);
+
+	return 0;
+}
+
 static int __initdata parsed_numa_memblks;
 
 static int __init
@@ -447,7 +505,7 @@ int __init acpi_numa_init(void)
 
 	/* SRAT: System Resource Affinity Table */
 	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
-		struct acpi_subtable_proc srat_proc[3];
+		struct acpi_subtable_proc srat_proc[4];
 
 		memset(srat_proc, 0, sizeof(srat_proc));
 		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
@@ -456,6 +514,8 @@ int __init acpi_numa_init(void)
 		srat_proc[1].handler = acpi_parse_x2apic_affinity;
 		srat_proc[2].id = ACPI_SRAT_TYPE_GICC_AFFINITY;
 		srat_proc[2].handler = acpi_parse_gicc_affinity;
+		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
+		srat_proc[3].handler = acpi_parse_gi_affinity;
 
 		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
 					sizeof(struct acpi_table_srat),
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 86d6cd92ce3d..f59b9d4ca5d5 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -634,6 +634,8 @@ static struct node_attr node_state_attr[] = {
 #endif
 	[N_MEMORY] = _NODE_ATTR(has_memory, N_MEMORY),
 	[N_CPU] = _NODE_ATTR(has_cpu, N_CPU),
+	[N_GENERIC_INITIATOR] = _NODE_ATTR(has_generic_initiator,
+					   N_GENERIC_INITIATOR),
 };
 
 static struct attribute *node_state_attrs[] = {
@@ -645,6 +647,7 @@ static struct attribute *node_state_attrs[] = {
 #endif
 	&node_state_attr[N_MEMORY].attr.attr,
 	&node_state_attr[N_CPU].attr.attr,
+	&node_state_attr[N_GENERIC_INITIATOR].attr.attr,
 	NULL
 };
 
diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
index 238873739550..54d0b4176a45 100644
--- a/include/asm-generic/topology.h
+++ b/include/asm-generic/topology.h
@@ -71,6 +71,9 @@
 #ifndef set_cpu_numa_mem
 #define set_cpu_numa_mem(cpu, node)
 #endif
+#ifndef set_gi_numa_mem
+#define set_gi_numa_mem(gi, node)
+#endif
 
 #endif	/* !CONFIG_NUMA || !CONFIG_HAVE_MEMORYLESS_NODES */
 
diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 27e7fa36f707..1aebf766fb52 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -399,6 +399,7 @@ enum node_states {
 #endif
 	N_MEMORY,		/* The node has memory(regular, high, movable) */
 	N_CPU,		/* The node has one or more cpus */
+	N_GENERIC_INITIATOR,	/* The node is a GI only node */
 	NR_NODE_STATES
 };
 
diff --git a/include/linux/topology.h b/include/linux/topology.h
index cb0775e1ee4b..9d5f8501efcf 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -125,6 +125,13 @@ static inline void set_numa_mem(int node)
 }
 #endif
 
+#ifndef set_gi_numa_mem
+static inline void set_gi_numa_mem(int gi, int node)
+{
+	_node_numa_mem_[gi] = node;
+}
+#endif
+
 #ifndef node_to_mem_node
 static inline int node_to_mem_node(int node)
 {
-- 
2.18.0
