From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 08/16] irqdomain: Add a fwnode_handle allocator
Date: Tue,  6 Oct 2015 18:36:21 +0100
Message-ID: <1444152989-31726-9-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Jake Oshins <jakeo@microsoft.com>, Graeme Gregory <graeme@xora.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

In order to be able to reference an irqdomain from ACPI, we need
to be able to create an identifier, which is usually a struct
device_node.

This device node does't really fit the ACPI infrastructure, so
we cunningly allocate a new structure containing a fwnode_handle,
and return that.

This structure doesn't really point to a device (interrupt
controllers are not "real" devices in Linux), but as we cannot
really deny that they exist, we create them with a new fwnode_type
(FWNODE_IRQCHIP).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/fwnode.h    |  1 +
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 0408545..37ec668 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -17,6 +17,7 @@ enum fwnode_type {
 	FWNODE_OF,
 	FWNODE_ACPI,
 	FWNODE_PDATA,
+	FWNODE_IRQCHIP,
 };
 
 struct fwnode_handle {
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 995d4c5..949caa7 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -188,6 +188,8 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 }
 
 #ifdef CONFIG_IRQ_DOMAIN
+struct fwnode_handle *irq_domain_alloc_fwnode(void *data);
+void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index ea62f67..6fbecae 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -27,6 +27,57 @@ static int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
 
+struct irqchip_fwid {
+	struct fwnode_handle fwnode;
+	char *name;
+	void *data;
+};
+
+/**
+ * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
+ *                           identifying an irq domain
+ * @data: optional user-provided data
+ *
+ * Allocate a struct device_node, and return a poiner to the embedded
+ * fwnode_handle (or NULL on failure).
+ */
+struct fwnode_handle *irq_domain_alloc_fwnode(void *data)
+{
+	struct irqchip_fwid *fwid;
+	char *name;
+
+	fwid = kzalloc(sizeof(*fwid), GFP_KERNEL);
+	name = kasprintf(GFP_KERNEL, "irqchip@%p", data);
+
+	if (!fwid || !name) {
+		kfree(fwid);
+		kfree(name);
+		return NULL;
+	}
+
+	fwid->name = name;
+	fwid->data = data;
+	fwid->fwnode.type = FWNODE_IRQCHIP;
+	return &fwid->fwnode;
+}
+
+/**
+ * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
+ *
+ * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
+ */
+void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
+{
+	struct irqchip_fwid *fwid;
+
+	if (WARN_ON(fwnode->type != FWNODE_IRQCHIP))
+		return;
+
+	fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+	kfree(fwid->name);
+	kfree(fwid);
+}
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @of_node: optional device-tree node of the interrupt controller
-- 
2.1.4
