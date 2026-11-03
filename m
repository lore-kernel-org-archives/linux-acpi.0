Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721465;
	b=K25jHwdYO3PZnvGa6EnGN4CMu/hQdLk8dtbtD0UElX6TkxsJYFkAvDO31+SXhjlzAgNy
	 mZ8Qv2M5Vbtz/TBmOtmwBiYpGvcAUWDwbFGhQXkSbwrvDGsm71aXZBTll6ZL11JWXCyOd
	 bVR0lLMwE2ixNW0AKM4DY7vg/71BRtmENln+t0yWvwV2/a8naQvmwqgDFBr/AXQYFonpc
	 voUHOS73ua0JhndvvDY7bb894wtkwadlXh61yDCNpqDLCUCvTBgk8GPYD/uUUoyQuvy9L
	 TkRrYub+4l9OHMbksYVE5foRUwAOXm9GqlFmSjE/0GD75TDlZpqpf2Z8P0Q2TFGq1Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721465;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=9vOjCX6A8KlOv8+60INNSNfdhFOQHUnmR2fmD9y/9R4=;
	b=5tvYt6Jg8T49fF3a6NDga1MYA6D1e+nzGSKCGP2P/ekqwodTkmV5LZ+Ji1KvMkqQq9FF
	 w4Z7GN/UZzJ11M5nQR/vcB7nGvk0B7WNqKG7WOxho6qYQsAYzBumCX+pIuEORcWblUkz2
	 ZzxsBqo/75Z6meoJ4G1Net6ENUkxGZnhJNIv49Trsxr91em7epjS/TPdECkn40nzNmEBj
	 a7YT5GdKcoomp2o1/23TG23DZRnBleVff1MnBRiqzqpHfR+jlt9JoSuXVxujpVWFFM0fH
	 tMemwZIaftPEM7bDh2O8HLGZ9NkLa177qbkI1qC6Jlt/wxPgJK2IGGTomR0AOyiLUew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=24twimcI;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A160A3832;
	Tue,  3 Nov 2026 15:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E59A160A3832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=24twimcI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B94614E413DC;
	Tue,  3 Nov 2026 15:57:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 894EC6046C;
	Tue,  3 Nov 2026 15:57:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8A3C103291E1;
	Tue,  3 Nov 2026 16:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793721456; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9vOjCX6A8KlOv8+60INNSNfdhFOQHUnmR2fmD9y/9R4=;
	b=24twimcIPGZqM2pDpl4WGCAj5H02h6XyDzLRE5lxqRtTJzdHSLWeRPlDwW2df1NeSOn7Kc
	OzJ4rMNJ3qIW7BosJwv1T7yCbYVlAMlIu+QriJVVzbSVygTcyr+dGofWtZ1126V/XdHJK+
	UYx4D8RWNFMbf1mi+SvMFrTpadcWawk9ce/ipNTo3txLZhvxi4rYL9CaZZVO4VV7pqo+6F
	lsX/Hh1JgarJcdnFfk772lY6FxDDk9a3SD8ftA213NzznymnQg+8lAptMyPZ91FBs0ZYNs
	GXs0b/2ksTHs1Um2lhpzE4SqkokInstPGRmHbUyJv1HSB5WA5CBc+wshcYewZg==
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable+noautosel@kernel.org
Subject: [PATCH v14 10/10] PCI: of: Avoid np->data usage for the node changeset
Date: Tue,  3 Nov 2026 16:55:16 +0100
Message-ID: <20261103155540.365294-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155540.365294-1-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

of_pci_remove_node() and of_pci_remove_host_bridge_node() check
whether the node is dynamic but not whether it has valid private data.

During the node creation, an OF changeset is used and this changeset is
stored in np->data to be available for removal functions.

If, for instance, a PCI host bridge is created using a device-tree
overlay, the related node will have the dynamic flag set but np->data
will be NULL. This leads to NULL pointer dereferences.

Checking for a non-NULL np->data pointer to determine if the node has
been created by the PCI node creation process is not enough. Indeed,
on some platforms like PowerPC, the OF_RECONFIG_ATTACH_NODE notifier
(e.g., in the pci_dn_reconfig_notifier() function) intercepts node
additions and populates np->data with its own structure, such as a
struct pci_dn. In that case, np->data is not NULL but it is not related
to our changeset stored during the PCI node process creation.

Avoid the usage of np->data to store the changeset used during the PCI
node creation. Store our changeset in a more relevant structure: either
struct pci_dev when the node is created for a PCI device or struct
pci_host_bridge when the node is created for the PCI host bridge.

With that done, no ambiguity remains on removal. Indeed, this changeset,
if non-NULL, is the one used during PCI node creation. Check and use
this changeset on the removal process.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: <stable+noautosel@kernel.org> # Issue not triggered but could be a problem
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c    | 32 ++++++++++++++++++++------------
 include/linux/pci.h | 11 +++++++++++
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0a5797652e18..fbed24a244d0 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -732,15 +732,20 @@ void of_pci_remove_node(struct pci_dev *pdev)
 {
 	struct device_node *np;
 
+	if (!pdev->cset)
+		return;
+
 	np = pci_device_to_OF_node(pdev);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(pdev->cset);
+	of_changeset_destroy(pdev->cset);
 	of_node_put(np);
+	kfree(pdev->cset);
+	pdev->cset = NULL;
 }
 
 void of_pci_make_dev_node(struct pci_dev *pdev)
@@ -800,18 +805,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	ret = device_add_of_node(&pdev->dev, np);
 	if (ret)
 		goto out_revert_cset;
 
+	pdev->cset = cset;
+
 	kfree(name);
 
 	return;
 
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
@@ -828,16 +832,21 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 {
 	struct device_node *np;
 
+	if (!bridge->cset)
+		return;
+
 	np = pci_bus_to_OF_node(bridge->bus);
-	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
+	if (!np)
 		return;
 
 	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&bridge->bus->dev);
 	device_remove_of_node(&bridge->dev);
-	of_changeset_revert(np->data);
-	of_changeset_destroy(np->data);
+	of_changeset_revert(bridge->cset);
+	of_changeset_destroy(bridge->cset);
 	of_node_put(np);
+	kfree(bridge->cset);
+	bridge->cset = NULL;
 }
 
 void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
@@ -899,8 +908,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_clear_devlink_dev;
 
-	np->data = cset;
-
 	/* Add the of_node to host bridge and the root bus */
 	ret = device_add_of_node(&bridge->dev, np);
 	if (ret)
@@ -910,6 +917,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	if (ret)
 		goto out_remove_bridge_dev_of_node;
 
+	bridge->cset = cset;
+
 	kfree(name);
 
 	return;
@@ -917,7 +926,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 out_remove_bridge_dev_of_node:
 	device_remove_of_node(&bridge->dev);
 out_revert_cset:
-	np->data = NULL;
 	of_changeset_revert(cset);
 out_clear_devlink_dev:
 	fw_devlink_set_device(&np->fwnode, NULL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..05cf42278650 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -339,6 +339,9 @@ struct pcie_link_state;
 struct pci_sriov;
 struct pci_p2pdma;
 struct rcec_ea;
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+struct of_changeset;
+#endif
 
 /* struct pci_dev - describes a PCI device
  *
@@ -599,6 +602,10 @@ struct pci_dev {
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
+
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -674,6 +681,10 @@ struct pci_host_bridge {
 	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1SS during
 						   system suspend is broken */
 
+#ifdef CONFIG_PCI_DYNAMIC_OF_NODES
+	struct of_changeset *cset; /* Changeset used for OF node creation */
+#endif
+
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
2.56.0

