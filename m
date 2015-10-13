From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 03/17] irqdomain: Allow irq domain lookup by fwnode
Date: Tue, 13 Oct 2015 12:51:31 +0100
Message-ID: <1444737105-31573-4-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
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

So far, our irq domains are still looked up by device node.
Let's change this and allow a domain to be looked up using
a fwnode_handle pointer.

The existing interfaces are preserved with a couple of helpers.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 11 +++++++++--
 kernel/irq/irqdomain.c    | 16 +++++++---------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2f508f4..607c185 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -183,10 +183,17 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
-extern struct irq_domain *irq_find_matching_host(struct device_node *node,
-						 enum irq_domain_bus_token bus_token);
+extern struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
+						   enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
 
+static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
+							enum irq_domain_bus_token bus_token)
+{
+	return irq_find_matching_fwnode(node ? &node->fwnode : NULL,
+					bus_token);
+}
+
 static inline struct irq_domain *irq_find_host(struct device_node *node)
 {
 	return irq_find_matching_host(node, DOMAIN_BUS_ANY);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1aee5c1..023ab6d 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -191,12 +191,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
 
 /**
- * irq_find_matching_host() - Locates a domain for a given device node
- * @node: device-tree node of the interrupt controller
+ * irq_find_matching_fwnode() - Locates a domain for a given fwnode
+ * @fwnode: FW descriptor of the interrupt controller
  * @bus_token: domain-specific data
  */
-struct irq_domain *irq_find_matching_host(struct device_node *node,
-					  enum irq_domain_bus_token bus_token)
+struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
+					    enum irq_domain_bus_token bus_token)
 {
 	struct irq_domain *h, *found = NULL;
 	int rc;
@@ -212,12 +212,10 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
 	 */
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
-		struct device_node *of_node;
-		of_node = irq_domain_get_of_node(h);
 		if (h->ops->match)
-			rc = h->ops->match(h, node, bus_token);
+			rc = h->ops->match(h, to_of_node(fwnode), bus_token);
 		else
-			rc = ((of_node != NULL) && (of_node == node) &&
+			rc = ((fwnode != NULL) && (h->fwnode == fwnode) &&
 			      ((bus_token == DOMAIN_BUS_ANY) ||
 			       (h->bus_token == bus_token)));
 
@@ -229,7 +227,7 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
 	mutex_unlock(&irq_domain_mutex);
 	return found;
 }
-EXPORT_SYMBOL_GPL(irq_find_matching_host);
+EXPORT_SYMBOL_GPL(irq_find_matching_fwnode);
 
 /**
  * irq_set_default_host() - Set a "default" irq domain
-- 
2.1.4
