From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v3 8/9] pci, acpi, mcfg: Share ACPI PCI config space accessors.
Date: Tue, 10 Mar 2015 12:35:19 +0100
Message-ID: <1425987320-15020-9-git-send-email-tomasz.nowicki@linaro.org>
References: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33701 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbbCJLfA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 07:35:00 -0400
Received: by lbdu14 with SMTP id u14so1038324lbd.0
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2015 04:34:59 -0700 (PDT)
In-Reply-To: <1425987320-15020-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bhelgaas@google.com, wangyijing@huawei.com, arnd@arndb.de, hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, al.stone@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

MCFG can be used perfectly for all architectures which support ACPI.
ACPI mandates MCFG to describe PCI config space ranges which means
we should use MMCONFIG accessors by default.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/mcfg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/mcfg.c b/drivers/acpi/mcfg.c
index 1e646fc..e285f62 100644
--- a/drivers/acpi/mcfg.c
+++ b/drivers/acpi/mcfg.c
@@ -13,6 +13,26 @@
 
 #define	PREFIX	"MCFG: "
 
+/*
+ * raw_pci_read/write - ACPI PCI config space accessors.
+ *
+ * ACPI spec defines MCFG table as the way we can describe access to PCI config
+ * space, so let MCFG be default (__weak).
+ *
+ * If platform needs more fancy stuff, should provides its own implementation.
+ */
+int __weak raw_pci_read(unsigned int domain, unsigned int bus,
+			unsigned int devfn, int reg, int len, u32 *val)
+{
+	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
+}
+
+int __weak raw_pci_write(unsigned int domain, unsigned int bus,
+			 unsigned int devfn, int reg, int len, u32 val)
+{
+	return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
+}
+
 static int __init acpi_mcfg_check_entry(struct acpi_table_mcfg *mcfg,
 					struct acpi_mcfg_allocation *cfg)
 {
-- 
1.9.1

