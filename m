From: yakui.zhao@intel.com
Subject: [PATCH 1/2_v7] ACPI: Export symbol of pnp_bus_type
Date: Wed, 14 Jul 2010 20:54:53 +0800
Message-ID: <1279112094-16749-2-git-send-email-yakui.zhao@intel.com>
References: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51338 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753428Ab0GNM6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 08:58:37 -0400
In-Reply-To: <1279112094-16749-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, minyard@acm.org, bjorn.helgaas@hp.com, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/pnp/driver.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index cd11b11..9aec98a 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -218,6 +218,8 @@ struct bus_type pnp_bus_type = {
 	.dev_attrs = pnp_interface_attrs,
 };
 
+EXPORT_SYMBOL(pnp_bus_type);
+
 int pnp_register_driver(struct pnp_driver *drv)
 {
 	drv->driver.name = drv->name;
-- 
1.5.4.5

