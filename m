From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFT v2 02/24] genirq: Introduce helper functions to support stacked
 irq_chip
Date: Fri, 26 Sep 2014 22:02:03 +0800
Message-ID: <1411740145-30626-3-git-send-email-jiang.liu@linux.intel.com>
References: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411740145-30626-1-git-send-email-jiang.liu@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Grant Likely <grant.likely@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Tony Luck <tony.luck@intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <jiang.liu@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Now we already support hierarchy irq_datas, so introduce several helpers
to support stacked irq_chips.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 include/linux/irq.h |    5 +++++
 kernel/irq/chip.c   |   17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b1aa23eea711..07abf5a1cd8e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -435,6 +435,11 @@ extern void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_bad_irq(unsigned int irq, struct irq_desc *desc);
 extern void handle_nested_irq(unsigned int irq);
 
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+extern void irq_chip_ack_parent(struct irq_data *data);
+extern int irq_chip_retrigger_hierarchy(struct irq_data *data);
+#endif
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   irqreturn_t action_ret);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 46bd5e2190c3..58ed9eda091e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -821,3 +821,20 @@ void irq_cpu_offline(void)
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 	}
 }
+
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+void irq_chip_ack_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	data->chip->irq_ack(data);
+}
+
+int irq_chip_retrigger_hierarchy(struct irq_data *data)
+{
+	for (data = data->parent_data; data; data = data->parent_data)
+		if (data->chip && data->chip->irq_retrigger)
+			return data->chip->irq_retrigger(data);
+
+	return -ENOSYS;
+}
+#endif
-- 
1.7.10.4
