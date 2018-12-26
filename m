From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH] ACPI: Change wrong print type to display the real value for i386-PAE
Date: Wed, 26 Dec 2018 11:34:50 +0800
Message-ID: <20181226033450.5098-1-fanc.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, rafael@kernel.org
List-Id: linux-acpi@vger.kernel.org

There is a wrong display for memory address of NUMA node in i386-PAE.
That may mislead developers.

Here is a debian9-32bit with PAE in QEMU guest whose total memory is
more than 4G:
qemu-system-i386 \
-hda /var/lib/libvirt/images/debian32.qcow2 \
-m 5G \
-enable-kvm \
-smp 10 \
-numa node,mem=512M,nodeid=0,cpus=0 \
-numa node,mem=512M,nodeid=1,cpus=1 \
-numa node,mem=512M,nodeid=2,cpus=2 \
-numa node,mem=512M,nodeid=3,cpus=3 \
-numa node,mem=512M,nodeid=4,cpus=4 \
-numa node,mem=512M,nodeid=5,cpus=5 \
-numa node,mem=512M,nodeid=6,cpus=6 \
-numa node,mem=512M,nodeid=7,cpus=7 \
-numa node,mem=512M,nodeid=8,cpus=8 \
-numa node,mem=512M,nodeid=9,cpus=9 \
-serial stdio

Because of the wrong value type, it prints as below:
[    0.021049] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
[    0.021740] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
[    0.022425] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
[    0.023092] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
[    0.023764] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
[    0.024431] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
[    0.025104] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
[    0.025791] ACPI: SRAT Memory (0x0 length 0x20000000) in proximity domain 6 enabled
[    0.026412] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 7 enabled
[    0.027118] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 8 enabled
[    0.027802] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 9 enabled
The upper half of start address from domain 6 to domain 9 was cut so
that developers get a wrong value.

Fix the value type, it prints as below:
[    0.023698] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
[    0.024325] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
[    0.024981] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
[    0.025659] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
[    0.026317] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
[    0.026980] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
[    0.027635] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
[    0.028311] ACPI: SRAT Memory (0x100000000 length 0x20000000) in proximity domain 6 enabled
[    0.028985] ACPI: SRAT Memory (0x120000000 length 0x20000000) in proximity domain 7 enabled
[    0.029667] ACPI: SRAT Memory (0x140000000 length 0x20000000) in proximity domain 8 enabled
[    0.030334] ACPI: SRAT Memory (0x160000000 length 0x20000000) in proximity domain 9 enabled
The start address from domain 6 to domain 9 is the real value.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 drivers/acpi/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 274699463b4f..7bbbf8256a41 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -146,9 +146,9 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
-			pr_debug("SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
-				 (unsigned long)p->base_address,
-				 (unsigned long)p->length,
+			pr_debug("SRAT Memory (0x%llx length 0x%llx) in proximity domain %d %s%s%s\n",
+				 (unsigned long long)p->base_address,
+				 (unsigned long long)p->length,
 				 p->proximity_domain,
 				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
 				 "enabled" : "disabled",
-- 
2.19.2
