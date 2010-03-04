From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 4/4] ipmi: Update driver to use 'dev_printk()' and its
	constructs
Date: Wed, 03 Mar 2010 20:44:25 -0700
Message-ID: <20100304034425.30205.7738.stgit@bob.kio>
References: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:40887 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0CDDo0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 22:44:26 -0500
In-Reply-To: <20100304033146.30205.68689.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

Update core IPMI driver printk()'s with dev_printk(), and its constructs,
to provide additional device topology information.


An example of the additional device topology for a PNP device -
  ipmi_si 00:02: probing via ACPI
  ipmi_si 00:02: [io  0x0ca2-0x0ca3] regsize 1 spacing 1 irq 0
  ipmi_si 00:02: Found new BMC (man_id: 0x00000b, prod_id: 0x0000, ...
  ipmi_si 00:02: IPMI kcs interface initialized

and for a PCI device -
  ipmi_si 0000:01:04.6: probing via PCI
  ipmi_si 0000:01:04.6: PCI INT A -> GSI 21 (level, low) -> IRQ 21
  ipmi_si 0000:01:04.6: [mem 0xf1ef0000-0xf1ef00ff] regsize 1 spaci...
  ipmi_si 0000:01:04.6: IPMI kcs interface initialized


Signed-off-by: Myron Stowe <myron.stowe@hp.com>
---

 drivers/char/ipmi/ipmi_msghandler.c |   11 ++--
 drivers/char/ipmi/ipmi_si_intf.c    |  103 ++++++++++++++++-------------------
 2 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index ec5e3f8..0e30114 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -2495,12 +2495,11 @@ static int ipmi_bmc_register(ipmi_smi_t intf, int ifnum,
 			return rv;
 		}
 
-		printk(KERN_INFO
-		       "ipmi: Found new BMC (man_id: 0x%6.6x, "
-		       " prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
-		       bmc->id.manufacturer_id,
-		       bmc->id.product_id,
-		       bmc->id.device_id);
+		dev_info(intf->si_dev, "Found new BMC (man_id: 0x%6.6x, "
+			 "prod_id: 0x%4.4x, dev_id: 0x%2.2x)\n",
+			 bmc->id.manufacturer_id,
+			 bmc->id.product_id,
+			 bmc->id.device_id);
 	}
 
 	/*
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 37c6912..e0966d2 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -573,9 +573,8 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 3);
 		if (msg[2] != 0) {
 			/* Error clearing flags */
-			printk(KERN_WARNING
-			       "ipmi_si: Error clearing flags: %2.2x\n",
-			       msg[2]);
+			dev_warn(smi_info->dev,
+				 "Error clearing flags: %2.2x\n", msg[2]);
 		}
 		if (smi_info->si_state == SI_CLEARING_FLAGS_THEN_SET_IRQ)
 			start_enable_irq(smi_info);
@@ -667,9 +666,8 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		/* We got the flags from the SMI, now handle them. */
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0) {
-			printk(KERN_WARNING
-			       "ipmi_si: Could not enable interrupts"
-			       ", failed get, using polled mode.\n");
+			dev_warn(smi_info->dev, "Could not enable interrupts"
+				 ", failed get, using polled mode.\n");
 			smi_info->si_state = SI_NORMAL;
 		} else {
 			msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -691,9 +689,8 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		/* We got the flags from the SMI, now handle them. */
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0) {
-			printk(KERN_WARNING
-			       "ipmi_si: Could not enable interrupts"
-			       ", failed set, using polled mode.\n");
+			dev_warn(smi_info->dev, "Could not enable interrupts"
+				 ", failed set, using polled mode.\n");
 		}
 		smi_info->si_state = SI_NORMAL;
 		break;
@@ -706,9 +703,8 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		/* We got the flags from the SMI, now handle them. */
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0) {
-			printk(KERN_WARNING
-			       "ipmi_si: Could not disable interrupts"
-			       ", failed get.\n");
+			dev_warn(smi_info->dev, "Could not disable interrupts"
+				 ", failed get.\n");
 			smi_info->si_state = SI_NORMAL;
 		} else {
 			msg[0] = (IPMI_NETFN_APP_REQUEST << 2);
@@ -730,9 +726,8 @@ static void handle_transaction_done(struct smi_info *smi_info)
 		/* We got the flags from the SMI, now handle them. */
 		smi_info->handlers->get_result(smi_info->si_sm, msg, 4);
 		if (msg[2] != 0) {
-			printk(KERN_WARNING
-			       "ipmi_si: Could not disable interrupts"
-			       ", failed set.\n");
+			dev_warn(smi_info->dev, "Could not disable interrupts"
+				 ", failed set.\n");
 		}
 		smi_info->si_state = SI_NORMAL;
 		break;
@@ -1087,9 +1082,9 @@ static int smi_start_processing(void       *send_info,
 		new_smi->thread = kthread_run(ipmi_thread, new_smi,
 					      "kipmi%d", new_smi->intf_num);
 		if (IS_ERR(new_smi->thread)) {
-			printk(KERN_NOTICE "ipmi_si_intf: Could not start"
-			       " kernel thread due to error %ld, only using"
-			       " timers to drive the interface\n",
+			dev_notice(new_smi->dev, "Could not start"
+				   " kernel thread due to error %ld, only using"
+				   " timers to drive the interface\n",
 			       PTR_ERR(new_smi->thread));
 			new_smi->thread = NULL;
 		}
@@ -1752,6 +1747,8 @@ static __devinit void hardcode_find_bmc(void)
 			return;
 
 		info->addr_source = "hardcoded";
+		printk(KERN_INFO "ipmi_si: probing via %s\n",
+		       info->addr_source);
 
 		if (!si_type[i] || strcmp(si_type[i], "kcs") == 0) {
 			info->si_type = SI_KCS;
@@ -1871,6 +1868,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 {
 	struct acpi_device *acpi_dev;
 	struct smi_info *info;
+	struct resource *res;
 	acpi_handle handle;
 	acpi_status status;
 	unsigned long long tmp;
@@ -1884,6 +1882,7 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		return -ENOMEM;
 
 	info->addr_source = "ACPI";
+	dev_info(&dev->dev, "probing via %s\n", info->addr_source);
 
 	handle = acpi_dev->handle;
 
@@ -1903,22 +1902,26 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 		info->si_type = SI_BT;
 		break;
 	default:
-		dev_info(&dev->dev, "unknown interface type %lld\n", tmp);
+		dev_info(&dev->dev, "unknown IPMI type %lld\n", tmp);
 		goto err_free;
 	}
 
-	if (pnp_port_valid(dev, 0)) {
+	res = pnp_get_resource(dev, IORESOURCE_IO, 0);
+	if (res) {
 		info->io_setup = port_setup;
 		info->io.addr_type = IPMI_IO_ADDR_SPACE;
-		info->io.addr_data = pnp_port_start(dev, 0);
-	} else if (pnp_mem_valid(dev, 0)) {
-		info->io_setup = mem_setup;
-		info->io.addr_type = IPMI_MEM_ADDR_SPACE;
-		info->io.addr_data = pnp_mem_start(dev, 0);
 	} else {
+		res = pnp_get_resource(dev, IORESOURCE_MEM, 0);
+		if (res) {
+			info->io_setup = mem_setup;
+			info->io.addr_type = IPMI_MEM_ADDR_SPACE;
+		}
+	}
+	if (!res) {
 		dev_err(&dev->dev, "no I/O or memory address\n");
 		goto err_free;
 	}
+	info->io.addr_data = res->start;
 
 	info->io.regspacing = DEFAULT_REGSPACING;
 	info->io.regsize = DEFAULT_REGSPACING;
@@ -1937,6 +1940,10 @@ static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
 	info->dev = &dev->dev;
 	pnp_set_drvdata(dev, info);
 
+	dev_info(info->dev, "%pR regsize %d spacing %d irq %d\n",
+		res, info->io.regsize, info->io.regspacing,
+		info->irq);
+
 	return try_smi_init(info);
 
 err_free:
@@ -2048,6 +2055,7 @@ static __devinit void try_init_dmi(struct dmi_ipmi_data *ipmi_data)
 	}
 
 	info->addr_source = "SMBIOS";
+	printk(KERN_INFO "ipmi_si: probing via %s\n", info->addr_source);
 
 	switch (ipmi_data->type) {
 	case 0x01: /* KCS */
@@ -2147,6 +2155,7 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	info->addr_source = "PCI";
+	dev_info(&pdev->dev, "probing via %s\n", info->addr_source);
 
 	switch (class_type) {
 	case PCI_ERMC_CLASSCODE_TYPE_SMIC:
@@ -2163,15 +2172,13 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 
 	default:
 		kfree(info);
-		printk(KERN_INFO "ipmi_si: %s: Unknown IPMI type: %d\n",
-		       pci_name(pdev), class_type);
+		dev_info(&pdev->dev, "Unknown IPMI type: %d\n", class_type);
 		return -ENOMEM;
 	}
 
 	rv = pci_enable_device(pdev);
 	if (rv) {
-		printk(KERN_ERR "ipmi_si: %s: couldn't enable PCI device\n",
-		       pci_name(pdev));
+		dev_err(&pdev->dev, "couldn't enable PCI device\n");
 		kfree(info);
 		return rv;
 	}
@@ -2199,6 +2206,10 @@ static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
 	info->dev = &pdev->dev;
 	pci_set_drvdata(pdev, info);
 
+	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
+		&pdev->resource[0], info->io.regsize, info->io.regspacing,
+		info->irq);
+
 	return try_smi_init(info);
 }
 
@@ -2306,7 +2317,7 @@ static int __devinit ipmi_of_probe(struct of_device *dev,
 	info->irq		= irq_of_parse_and_map(dev->node, 0);
 	info->dev		= &dev->dev;
 
-	dev_dbg(&dev->dev, "addr 0x%lx regsize %d spacing %d irq %x\n",
+	dev_dbg(&dev->dev, "addr 0x%lx regsize %d spacing %d irq %d\n",
 		info->io.addr_data, info->io.regsize, info->io.regspacing,
 		info->irq);
 
@@ -2769,17 +2780,6 @@ static int try_smi_init(struct smi_info *new_smi)
 	int rv;
 	int i;
 
-	if (new_smi->addr_source) {
-		printk(KERN_INFO "ipmi_si: Trying %s-specified %s state"
-		       " machine at %s address 0x%lx, slave address 0x%x,"
-		       " irq %d\n",
-		       new_smi->addr_source,
-		       si_to_str[new_smi->si_type],
-		       addr_space_to_str[new_smi->io.addr_type],
-		       new_smi->io.addr_data,
-		       new_smi->slave_addr, new_smi->irq);
-	}
-
 	mutex_lock(&smi_infos_lock);
 	if (!is_new_interface(new_smi)) {
 		printk(KERN_WARNING "ipmi_si: duplicate interface\n");
@@ -2916,9 +2916,8 @@ static int try_smi_init(struct smi_info *new_smi)
 			       "bmc",
 			       new_smi->slave_addr);
 	if (rv) {
-		printk(KERN_ERR
-		       "ipmi_si: Unable to register device: error %d\n",
-		       rv);
+		dev_err(new_smi->dev, "Unable to register device: error %d\n",
+			rv);
 		goto out_err_stop_timer;
 	}
 
@@ -2926,9 +2925,7 @@ static int try_smi_init(struct smi_info *new_smi)
 				     type_file_read_proc,
 				     new_smi);
 	if (rv) {
-		printk(KERN_ERR
-		       "ipmi_si: Unable to create proc entry: %d\n",
-		       rv);
+		dev_err(new_smi->dev, "Unable to create proc entry: %d\n", rv);
 		goto out_err_stop_timer;
 	}
 
@@ -2936,9 +2933,7 @@ static int try_smi_init(struct smi_info *new_smi)
 				     stat_file_read_proc,
 				     new_smi);
 	if (rv) {
-		printk(KERN_ERR
-		       "ipmi_si: Unable to create proc entry: %d\n",
-		       rv);
+		dev_err(new_smi->dev, "Unable to create proc entry: %d\n", rv);
 		goto out_err_stop_timer;
 	}
 
@@ -2946,9 +2941,7 @@ static int try_smi_init(struct smi_info *new_smi)
 				     param_read_proc,
 				     new_smi);
 	if (rv) {
-		printk(KERN_ERR
-		       "ipmi_si: Unable to create proc entry: %d\n",
-		       rv);
+		dev_err(new_smi->dev, "Unable to create proc entry: %d\n", rv);
 		goto out_err_stop_timer;
 	}
 
@@ -2956,8 +2949,8 @@ static int try_smi_init(struct smi_info *new_smi)
 
 	mutex_unlock(&smi_infos_lock);
 
-	printk(KERN_INFO "IPMI %s interface initialized\n",
-	       si_to_str[new_smi->si_type]);
+	dev_info(new_smi->dev, "IPMI %s interface initialized\n",
+		 si_to_str[new_smi->si_type]);
 
 	return 0;
 

