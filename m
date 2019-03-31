From: Hanna Hawa <hhhawa@amazon.com>
Subject: [PATCH 2/7] irqchip/alpine-msi: Update driver license to use SPDX
Date: Sun, 31 Mar 2019 15:34:10 +0300
Message-ID: <1554035655-11352-3-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tsahee@annapurnalabs.com, antoine.tenart@bootlin.com, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: ronenk@amazon.com, dwmw@amazon.co.uk, vaerov@amazon.com, zeev@amazon.com, alisaidi@amazon.com, talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com, barakw@amazon.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Update driver license to be in-line with Linux conventions.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/irqchip/irq-alpine-msi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index ae2fca7..ec6a606 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Annapurna Labs MSIX support services
  *
  * Copyright (C) 2016, Amazon.com, Inc. or its affiliates. All Rights Reserved.
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.7.4
