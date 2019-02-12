From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/3] arm64: Support Generic Initiator only domains
Date: Tue, 12 Feb 2019 16:49:25 +0000
Message-ID: <20190212164926.202-3-Jonathan.Cameron@huawei.com>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jonathan.cameron@huawei.com, linux-mm@kvack.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Keith Busch <keith.busch@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Michal Hocko <mhocko@kernel.org>, jcm@redhat.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
List-Id: linux-acpi@vger.kernel.org

The one thing that currently needs doing from an architecture
point of view is associating the GI domain with its nearest
memory domain.  This allows all the standard NUMA aware code
to get a 'reasonable' answer.

A clever driver might elect to do load balancing etc
if there are multiple host / memory domains nearby, but
that's a decision for the driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f7200a..871d2d21afb3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -698,6 +698,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int err;
 	unsigned int cpu;
+	unsigned int node;
 	unsigned int this_cpu;
 
 	init_cpu_topology();
@@ -736,6 +737,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(cpu, true);
 		numa_store_cpu_info(cpu);
 	}
+
+	/*
+	 * Walk the numa domains and set the node to numa memory reference
+	 * for any that are Generic Initiator Only.
+	 */
+	for_each_node_state(node, N_GENERIC_INITIATOR)
+		set_gi_numa_mem(node, local_memory_node(node));
 }
 
 void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-- 
2.18.0
