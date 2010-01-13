From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCHv2] [RFC] firewire: Add ohci1394 PCI runtime power management support
Date: Wed, 13 Jan 2010 18:04:22 -0500
Message-ID: <1263423862-8369-1-git-send-email-mjg@redhat.com>
References: <4B4E14D7.5080801@s5r6.in-berlin.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40351 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab0AMXG3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2010 18:06:29 -0500
In-Reply-To: <4B4E14D7.5080801@s5r6.in-berlin.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stefanr@s5r6.in-berlin.de
Cc: linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-acpi@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>

Updated version - I think this addresses most of Stefan's concerns, though
it'd be good to have a sanity check on the core change to make sure I'm doing
the right thing when looking at the selfIDs. I've dropped the mdelays - the
only time I've managed to get the card to take more than a single attempt
to perform the write was when I wasn't performing the posting read. There
may be something up with the locking during runtime resume, though - I've had
a couple of tracebacks which seem to be resolved now, but I confess to not
being entirely clear what was broken or why...

OHCI firewire controllers with 1394a or later phys support the generation
of PMEs from D3hot when a cable is connected or disconnected. This patch
adds support for enabling this functionality, along with hooking it into
the PCI runtime PM framework. The device will be kept awake if a cable
is connected to any of its ports, and put to sleep if no connection is
present.

For sanity purposes, the code ensures that the phy is recent enough to
implement the required functionality. It also ensures that all ports have
the interrupt enabled - a VIA chip I've tested appears to only allow
int_enable to be set on one port at a time, which is inadequate for the
purposes of this code.

This depends on the PCI runtime PM code, which is not yet upstream. I'm
sending this out now for sanity checking.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/firewire/core-topology.c |   20 ++-
 drivers/firewire/core.h          |    4 +-
 drivers/firewire/ohci.c          |  326 ++++++++++++++++++++++++++++++++------
 3 files changed, 298 insertions(+), 52 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 93ec64c..95e8f36 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -187,7 +187,8 @@ static inline struct fw_node *fw_node(struct list_head *l)
  * fw_node corresponding to the local card otherwise NULL.
  */
 static struct fw_node *build_tree(struct fw_card *card,
-				  u32 *sid, int self_id_count)
+				  u32 *sid, int self_id_count,
+				  int *local_self_id_count)
 {
 	struct fw_node *node, *child, *local_node, *irm_node;
 	struct list_head stack, *h;
@@ -244,8 +245,10 @@ static struct fw_node *build_tree(struct fw_card *card,
 			return NULL;
 		}
 
-		if (phy_id == (card->node_id & 0x3f))
+		if (phy_id == (card->node_id & 0x3f)) {
+			local_self_id_count++;
 			local_node = node;
+		}
 
 		if (SELF_ID_CONTENDER(q))
 			irm_node = node;
@@ -523,10 +526,11 @@ static void update_topology_map(struct fw_card *card,
 	fw_compute_block_crc(card->topology_map);
 }
 
-void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
-			      int self_id_count, u32 *self_ids)
+int fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
+			     int self_id_count, u32 *self_ids)
 {
 	struct fw_node *local_node;
+	int local_self_id_count = 0;
 	unsigned long flags;
 
 	/*
@@ -554,7 +558,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	card->reset_jiffies = jiffies;
 	fw_schedule_bm_work(card, 0);
 
-	local_node = build_tree(card, self_ids, self_id_count);
+	local_node = build_tree(card, self_ids, self_id_count,
+				&local_self_id_count);
 
 	update_topology_map(card, self_ids, self_id_count);
 
@@ -571,5 +576,10 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 	}
 
 	spin_unlock_irqrestore(&card->lock, flags);
+
+	if (self_id_count > local_self_id_count)
+		return 1;
+
+	return 0;
 }
 EXPORT_SYMBOL(fw_core_handle_bus_reset);
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index ed3b1a7..76a8107 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -186,8 +186,8 @@ static inline void fw_node_put(struct fw_node *node)
 		kfree(node);
 }
 
-void fw_core_handle_bus_reset(struct fw_card *card, int node_id,
-			      int generation, int self_id_count, u32 *self_ids);
+int fw_core_handle_bus_reset(struct fw_card *card, int node_id,
+			     int generation, int self_id_count, u32 *self_ids);
 void fw_destroy_nodes(struct fw_card *card);
 
 /*
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index a61571c..8ab8319 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -35,6 +35,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
@@ -184,6 +185,7 @@ struct fw_ohci {
 	dma_addr_t self_id_bus;
 	__le32 *self_id_cpu;
 	struct tasklet_struct bus_reset_tasklet;
+	struct tasklet_struct phy_tasklet;
 	int node_id;
 	int generation;
 	int request_generation;	/* for timestamping incoming requests */
@@ -198,6 +200,9 @@ struct fw_ohci {
 	 * this driver with this lock held.
 	 */
 	spinlock_t lock;
+	spinlock_t phy_lock;
+	spinlock_t port_lock;
+
 	u32 self_id_buffer[512];
 
 	/* Config rom buffers */
@@ -217,6 +222,8 @@ struct fw_ohci {
 	u64 ir_context_channels;
 	u32 ir_context_mask;
 	struct iso_context *ir_context_list;
+
+	bool runtime_pm;
 };
 
 static inline struct fw_ohci *fw_ohci(struct fw_card *card)
@@ -275,7 +282,7 @@ static void log_irqs(u32 evt)
 	    !(evt & OHCI1394_busReset))
 		return;
 
-	fw_notify("IRQ %08x%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n", evt,
+	fw_notify("IRQ %08x%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n", evt,
 	    evt & OHCI1394_selfIDComplete	? " selfID"		: "",
 	    evt & OHCI1394_RQPkt		? " AR_req"		: "",
 	    evt & OHCI1394_RSPkt		? " AR_resp"		: "",
@@ -289,12 +296,13 @@ static void log_irqs(u32 evt)
 	    evt & OHCI1394_cycleInconsistent	? " cycleInconsistent"	: "",
 	    evt & OHCI1394_regAccessFail	? " regAccessFail"	: "",
 	    evt & OHCI1394_busReset		? " busReset"		: "",
+	    evt & OHCI1394_phy			? " phy"		: "",
 	    evt & ~(OHCI1394_selfIDComplete | OHCI1394_RQPkt |
 		    OHCI1394_RSPkt | OHCI1394_reqTxComplete |
 		    OHCI1394_respTxComplete | OHCI1394_isochRx |
 		    OHCI1394_isochTx | OHCI1394_postedWriteErr |
 		    OHCI1394_cycleTooLong | OHCI1394_cycle64Seconds |
-		    OHCI1394_cycleInconsistent |
+		    OHCI1394_cycleInconsistent | OHCI1394_phy |
 		    OHCI1394_regAccessFail | OHCI1394_busReset)
 						? " ?"			: "");
 }
@@ -452,29 +460,125 @@ static inline void flush_writes(const struct fw_ohci *ohci)
 	reg_read(ohci, OHCI1394_Version);
 }
 
-static int ohci_update_phy_reg(struct fw_card *card, int addr,
-			       int clear_bits, int set_bits)
+static int _ohci_read_phy_reg(struct fw_ohci *ohci, int addr, u32 *val)
 {
-	struct fw_ohci *ohci = fw_ohci(card);
-	u32 val, old;
+	int i;
 
 	reg_write(ohci, OHCI1394_PhyControl, OHCI1394_PhyControl_Read(addr));
 	flush_writes(ohci);
-	msleep(2);
-	val = reg_read(ohci, OHCI1394_PhyControl);
-	if ((val & OHCI1394_PhyControl_ReadDone) == 0) {
-		fw_error("failed to set phy reg bits.\n");
+
+	for (i = 0; i < 100; i++) {
+		*val = reg_read(ohci, OHCI1394_PhyControl);
+		if (*val & OHCI1394_PhyControl_ReadDone)
+			break;
+	}
+
+	if (i == 100) {
+		fw_error("Get PHY Reg timeout [0x%08x/0x%08x/%d]",
+			 *val, *val & OHCI1394_PhyControl_ReadDone, i);
 		return -EBUSY;
 	}
 
-	old = OHCI1394_PhyControl_ReadData(val);
-	old = (old & ~clear_bits) | set_bits;
-	reg_write(ohci, OHCI1394_PhyControl,
-		  OHCI1394_PhyControl_Write(addr, old));
+	*val = OHCI1394_PhyControl_ReadData(*val);
 
 	return 0;
 }
 
+static int ohci_read_phy_reg(struct fw_card *card, int addr, u32 *val)
+{
+	struct fw_ohci *ohci = fw_ohci(card);
+	int ret;
+	unsigned long flags;
+
+	spin_lock_bh(&ohci->phy_lock);
+	ret = _ohci_read_phy_reg(ohci, addr, val);
+	spin_unlock_bh(&ohci->phy_lock);
+	return ret;
+}
+
+static int ohci_update_phy_reg(struct fw_card *card, int addr,
+			       int clear_bits, int set_bits)
+{
+	struct fw_ohci *ohci = fw_ohci(card);
+	u32 r;
+	int i, ret = 0;
+	unsigned long flags;
+
+	spin_lock_bh(&ohci->phy_lock);
+
+	if (_ohci_read_phy_reg(ohci, addr, &r)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	r = (r & ~clear_bits) | set_bits;
+	reg_write(ohci, OHCI1394_PhyControl,
+		  OHCI1394_PhyControl_Write(addr, r));
+	flush_writes(ohci);
+
+	for (i = 0; i < 100; i++) {
+		r = reg_read(ohci, OHCI1394_PhyControl);
+		if (!(r & OHCI1394_PhyControl_WriteDone))
+			break;
+	}
+
+	if (i == 100) {
+		fw_error("Set PHY Reg timeout [0x%08x/0x%08x/%d]",
+			 r, r & OHCI1394_PhyControl_WriteDone, i);
+		ret = -EBUSY;
+		goto out;
+	}
+
+out:
+	spin_unlock_bh(&ohci->phy_lock);
+	return ret;
+}
+
+static int ohci_read_port_reg(struct fw_card *card, int port,
+			      int addr, u32 *val)
+{
+	struct fw_ohci *ohci = fw_ohci(card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_bh(&ohci->port_lock);
+	if (ohci_update_phy_reg(card, 7, 0xff, port)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (ohci_read_phy_reg(card, 8+addr, val)) {
+		ret = -EBUSY;
+		goto out;
+	}
+out:
+	spin_unlock_bh(&ohci->port_lock);
+	return ret;
+}
+
+static int ohci_write_port_reg(struct fw_card *card, int port,
+			       int addr, int clear_bits, int set_bits)
+{
+	struct fw_ohci *ohci = fw_ohci(card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_bh(&ohci->port_lock);
+
+	if (ohci_update_phy_reg(card, 7, 0xff, port)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (ohci_update_phy_reg(card, 8+addr, clear_bits, set_bits)) {
+		ret = -EBUSY;
+		goto out;
+	}
+out:
+	spin_unlock_bh(&ohci->port_lock);
+	return ret;
+}
+
 static int ar_context_add_page(struct ar_context *ctx)
 {
 	struct device *dev = ctx->ohci->card.device;
@@ -1250,6 +1354,45 @@ static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 
 }
 
+static int ohci_port_is_connected(struct fw_card *card)
+{
+	int i, total_ports;
+	u32 val;
+
+	if (ohci_read_phy_reg(card, 2, &val))
+		return -EBUSY;
+
+	total_ports = val & 0x1f;
+
+	for (i = 0; i < total_ports; i++) {
+		ohci_read_port_reg(card, i, 0, &val);
+		if (val & 0x04)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int ohci_clear_port_event(struct fw_card *card)
+{
+
+	return ohci_update_phy_reg(card, 5, 0, 0x04);
+}
+
+static void phy_tasklet(unsigned long data)
+{
+	struct fw_ohci *ohci = (struct fw_ohci *)data;
+	u32 val;
+
+	ohci_read_phy_reg(&ohci->card, 5, &val);
+
+	if (val & 0x04)
+		ohci_clear_port_event(&ohci->card);
+
+	if (!ohci_port_is_connected(&ohci->card))
+		pm_schedule_suspend(ohci->card.device, 1000);
+}
+
 static void bus_reset_tasklet(unsigned long data)
 {
 	struct fw_ohci *ohci = (struct fw_ohci *)data;
@@ -1259,6 +1402,9 @@ static void bus_reset_tasklet(unsigned long data)
 	void *free_rom = NULL;
 	dma_addr_t free_rom_bus = 0;
 
+	/* Cancel any pending suspend requests */
+	pm_runtime_resume(ohci->card.device);
+
 	reg = reg_read(ohci, OHCI1394_NodeID);
 	if (!(reg & OHCI1394_NodeID_idValid)) {
 		fw_notify("node ID not valid, new bus reset in progress\n");
@@ -1377,8 +1523,11 @@ static void bus_reset_tasklet(unsigned long data)
 	log_selfids(ohci->node_id, generation,
 		    self_id_count, ohci->self_id_buffer);
 
-	fw_core_handle_bus_reset(&ohci->card, ohci->node_id, generation,
-				 self_id_count, ohci->self_id_buffer);
+	if (!fw_core_handle_bus_reset(&ohci->card, ohci->node_id, generation,
+				      self_id_count, ohci->self_id_buffer))
+		pm_schedule_suspend(ohci->card.device, 1000);
+
+	return;
 }
 
 static irqreturn_t irq_handler(int irq, void *data)
@@ -1396,6 +1545,9 @@ static irqreturn_t irq_handler(int irq, void *data)
 	reg_write(ohci, OHCI1394_IntEventClear, event & ~OHCI1394_busReset);
 	log_irqs(event);
 
+	if (event & OHCI1394_phy)
+		tasklet_schedule(&ohci->phy_tasklet);
+
 	if (event & OHCI1394_selfIDComplete)
 		tasklet_schedule(&ohci->bus_reset_tasklet);
 
@@ -1488,6 +1640,58 @@ static void copy_config_rom(__be32 *dest, const __be32 *src, size_t length)
 		memset(&dest[length], 0, CONFIG_ROM_SIZE - size);
 }
 
+static int is_extended_phy(struct fw_card *card)
+{
+	u32 val;
+
+	if (ohci_read_phy_reg(card, 2, &val))
+		return -EBUSY;
+
+	if ((val & 0xE0) == 0xE0)
+		return 1;
+
+	return 0;
+}
+
+static int ohci_configure_wakeup(struct fw_card *card)
+{
+	struct fw_ohci *ohci = fw_ohci(card);
+	int i, total_ports;
+	u32 val;
+
+	if (ohci_read_phy_reg(card, 2, &val))
+		return -EBUSY;
+
+	total_ports = val & 0x1f;
+
+	/* Attempt to enable port interrupts */
+	for (i = 0; i < total_ports; i++) {
+		ohci_write_port_reg(card, i, 1, 0, 0x10);
+		ohci_read_port_reg(card, i, 1, &val);
+		if (!(val & 0x10)) {
+			fw_error("Failed to enable interrupts on port %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	/*
+	 * Some cards appear to only support int_enable on a single port.
+	 * Check that it's still set on everything
+	 */
+
+	for (i = 0; i < total_ports; i++) {
+		ohci_read_port_reg(card, i, 1, &val);
+		if (!(val & 0x10)) {
+			fw_error("int_enable on port %d didn't stick\n", i);
+			return -ENODEV;
+		}
+	}
+
+	ohci->runtime_pm = 1;
+
+	return 0;
+}
+
 static int ohci_enable(struct fw_card *card,
 		       const __be32 *config_rom, size_t length)
 {
@@ -1555,7 +1759,7 @@ static int ohci_enable(struct fw_card *card,
 		  OHCI1394_postedWriteErr | OHCI1394_cycleTooLong |
 		  OHCI1394_cycleInconsistent |
 		  OHCI1394_cycle64Seconds | OHCI1394_regAccessFail |
-		  OHCI1394_masterIntEnable);
+		  OHCI1394_masterIntEnable | OHCI1394_phy);
 	if (param_debug & OHCI_PARAM_DEBUG_BUSRESETS)
 		reg_write(ohci, OHCI1394_IntMaskSet, OHCI1394_busReset);
 
@@ -1624,6 +1828,11 @@ static int ohci_enable(struct fw_card *card,
 		  OHCI1394_HCControl_BIBimageValid);
 	flush_writes(ohci);
 
+	if (is_extended_phy(card)) {
+		if (ohci_configure_wakeup(card) == 0)
+			ohci_clear_port_event(card);
+	}
+
 	/*
 	 * We are ready to go, initiate bus reset to finish the
 	 * initialization.
@@ -2451,10 +2660,15 @@ static int __devinit pci_probe(struct pci_dev *dev,
 	pci_set_drvdata(dev, ohci);
 
 	spin_lock_init(&ohci->lock);
+	spin_lock_init(&ohci->phy_lock);
+	spin_lock_init(&ohci->port_lock);
 
 	tasklet_init(&ohci->bus_reset_tasklet,
 		     bus_reset_tasklet, (unsigned long)ohci);
 
+	tasklet_init(&ohci->phy_tasklet,
+		     phy_tasklet, (unsigned long)ohci);
+
 	err = pci_request_region(dev, 0, ohci_driver_name);
 	if (err) {
 		fw_error("MMIO resource unavailable\n");
@@ -2548,6 +2762,11 @@ static int __devinit pci_probe(struct pci_dev *dev,
 	if (err)
 		goto fail_self_id;
 
+	if (pci_dev_run_wake(dev) && ohci->runtime_pm) {
+		pm_runtime_set_active(&dev->dev);
+		pm_runtime_enable(&dev->dev);
+	}
+
 	fw_notify("Added fw-ohci device %s, OHCI version %x.%x\n",
 		  dev_name(&dev->dev), version >> 16, version & 0xff);
 
@@ -2580,9 +2799,17 @@ static int __devinit pci_probe(struct pci_dev *dev,
 
 static void pci_remove(struct pci_dev *dev)
 {
-	struct fw_ohci *ohci;
+	struct fw_ohci *ohci = pci_get_drvdata(dev);
+
+	pm_runtime_get_sync(&dev->dev);
+
+	if (pci_dev_run_wake(dev) && ohci->runtime_pm) {
+		pm_runtime_disable(&dev->dev);
+		pm_runtime_set_suspended(&dev->dev);
+	}
+
+	pm_runtime_put_noidle(&dev->dev);
 
-	ohci = pci_get_drvdata(dev);
 	reg_write(ohci, OHCI1394_IntMaskClear, ~0);
 	flush_writes(ohci);
 	fw_core_remove_card(&ohci->card);
@@ -2619,42 +2846,41 @@ static void pci_remove(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int ohci_pci_suspend(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
-	int err;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 
 	software_reset(ohci);
-	free_irq(dev->irq, ohci);
-	err = pci_save_state(dev);
-	if (err) {
-		fw_error("pci_save_state failed\n");
-		return err;
-	}
-	err = pci_set_power_state(dev, pci_choose_state(dev, state));
-	if (err)
-		fw_error("pci_set_power_state failed with %d\n", err);
-	ohci_pmac_off(dev);
+
+	ohci_pmac_off(pdev);
 
 	return 0;
 }
 
-static int pci_resume(struct pci_dev *dev)
+static int ohci_pci_runtime_suspend(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
-	int err;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 
-	ohci_pmac_on(dev);
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	err = pci_enable_device(dev);
-	if (err) {
-		fw_error("pci_enable_device failed\n");
-		return err;
-	}
+	ohci_clear_port_event(&ohci->card);
+	return ohci_pci_suspend(dev);
+}
+
+static int ohci_pci_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
+
+	ohci_pmac_on(pdev);
 
 	return ohci_enable(&ohci->card, NULL, 0);
 }
+
+static int ohci_pci_runtime_idle(struct device *dev)
+{
+	return -EBUSY;
+}
 #endif
 
 static struct pci_device_id pci_table[] = {
@@ -2664,14 +2890,24 @@ static struct pci_device_id pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, pci_table);
 
+static struct dev_pm_ops ohci_pci_pm_ops = {
+	.suspend	= ohci_pci_suspend,
+	.resume		= ohci_pci_resume,
+	.freeze		= ohci_pci_suspend,
+	.thaw		= ohci_pci_resume,
+	.poweroff	= ohci_pci_suspend,
+	.runtime_suspend = ohci_pci_runtime_suspend,
+	.runtime_resume	= ohci_pci_resume,
+	.runtime_idle	= ohci_pci_runtime_idle,
+};
+
 static struct pci_driver fw_ohci_pci_driver = {
 	.name		= ohci_driver_name,
 	.id_table	= pci_table,
 	.probe		= pci_probe,
 	.remove		= pci_remove,
 #ifdef CONFIG_PM
-	.resume		= pci_resume,
-	.suspend	= pci_suspend,
+	.driver.pm	= &ohci_pci_pm_ops,
 #endif
 };
 
-- 
1.6.5.2

