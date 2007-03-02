From: "Takayoshi Kochi" <takayoshi.kochi@gmail.com>
Subject: [PATCH] supporting MMCONFIG over 4GB on x86_64
Date: Fri, 2 Mar 2007 20:07:58 +0900
Message-ID: <43c301fe0703020307g37f7df7dxd8f94adaac3acaf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:13019 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331AbXCBLH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Mar 2007 06:07:59 -0500
Received: by wx-out-0506.google.com with SMTP id h31so727912wxd
        for <linux-acpi@vger.kernel.org>; Fri, 02 Mar 2007 03:07:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

Currently MMCONFIG is ignored if it is located over 4G, but I see no reason
to reject it on x86_64 platform.

This patch is against 2.6.21-rc2 and was tested on
such a machine (MMCONFIG is located at 0xfe10000000)
without any problem.

Any comments?

-- 
Takayoshi Kochi

Signed-off-by: Takayoshi Kochi <takayoshi.kochi@gmail.com>
---
 boot.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.20/arch/i386/kernel/acpi/boot.c.orig	2007-03-02
14:34:02.000000000 +0900
+++ linux-2.6.20/arch/i386/kernel/acpi/boot.c	2007-03-02
19:38:10.000000000 +0900
@@ -198,6 +198,7 @@ int __init acpi_parse_mcfg(struct acpi_t

 	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
 	for (i = 0; i < pci_mmcfg_config_num; ++i) {
+#ifndef CONFIG_X86_64
 		if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
 			printk(KERN_ERR PREFIX
 			       "MMCONFIG not in low 4GB of memory\n");
@@ -205,6 +206,7 @@ int __init acpi_parse_mcfg(struct acpi_t
 			pci_mmcfg_config_num = 0;
 			return -ENODEV;
 		}
+#endif
 	}

 	return 0;
