Return-Path: <SRS0=BwYj=DG=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE33EC4727C
	for <linux-acpi@archiver.kernel.org>; Tue, 29 Sep 2020 13:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7533921531
	for <linux-acpi@archiver.kernel.org>; Tue, 29 Sep 2020 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601385929;
	bh=rT/pIt3f3iDRGK3pCOqPo3GwUoJweoxosgVlS+HbsdQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IVQB0aH+FT6hU0r60c5Mymdq/kBTVvIffUllG8oLwFYd6N1YklVK4PKg4C4G//oJ+
	 SL/M69K9ky705fsIV4VuEN9V0nnwCuJEk7sToivTbgngAm++EfoflA82KrFUuUU8pL
	 wyZZrhkWTB2oV5ax7kRbXFxIB5z0cKwqyzm7un00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgI2NZ3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 29 Sep 2020 09:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgI2NZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 09:25:29 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A77208FE;
        Tue, 29 Sep 2020 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601385927;
        bh=rT/pIt3f3iDRGK3pCOqPo3GwUoJweoxosgVlS+HbsdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pxwTEfKk4ngkGlXBAtRzy0gZE/tOKS7VsDjK0ooRnlOkQFw8SrjClveJvidJ/BbZV
         j2YdGISiTHGjHFT7gfJY0tuzkCWt8/6zrIzNKrpxpk5fyB8vCoFSqr8c3zQLVvSj+f
         wrgvJKJXodlCZdZ6qAOIw8PFuGsGciIJ7QEc039U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, Jonathan.Cameron@huawei.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] arm64: permit ACPI core to map kernel memory used for table overrides
Date:   Tue, 29 Sep 2020 15:25:22 +0200
Message-Id: <20200929132522.18067-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jonathan reports that the strict policy for memory mapped by the
ACPI core breaks the use case of passing ACPI table overrides via
initramfs. This is due to the fact that the memory type used for
loading the initramfs in memory is not recognized as a memory type
that is typically used by firmware to pass firmware tables.

Since the purpose of the strict policy is to ensure that no AML or
other ACPI code can manipulate any memory that is used by the kernel
to keep its internal state or the state of user tasks, we can relax
the permission check, and allow mappings of memory that is reserved
and marked as NOMAP via memblock, and therefore not covered by the
linear mapping to begin with.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Fixes: 1583052d111f ("arm64/acpi: disallow AML memory opregions to access kernel memory")
Fixes: 325f5585ec36 ("arm64/acpi: disallow writeable AML opregion mapping for EFI code regions")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++--
 include/linux/acpi.h     |  2 +-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a85174d05473..cada0b816c8a 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -298,8 +298,21 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 		case EFI_BOOT_SERVICES_DATA:
 		case EFI_CONVENTIONAL_MEMORY:
 		case EFI_PERSISTENT_MEMORY:
-			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
-			return NULL;
+			if (memblock_is_map_memory(phys) ||
+			    !memblock_is_region_memory(phys, size)) {
+				pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
+				return NULL;
+			}
+			/*
+			 * Mapping kernel memory is permitted if the region in
+			 * question is covered by a single memblock with the
+			 * NOMAP attribute set: this enables the use of ACPI
+			 * table overrides passed via initramfs, which are
+			 * reserved in memory using arch_reserve_mem_area()
+			 * below. As this particular use case only requires
+			 * read access, fall through to the R/O mapping case.
+			 */
+			fallthrough;
 
 		case EFI_RUNTIME_SERVICES_CODE:
 			/*
@@ -388,3 +401,8 @@ int apei_claim_sea(struct pt_regs *regs)
 
 	return err;
 }
+
+void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
+{
+	memblock_mark_nomap(addr, size);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1e4cdc6c7ae2..64ae25c59d55 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -958,7 +958,7 @@ void acpi_os_set_prepare_extended_sleep(int (*func)(u8 sleep_state,
 acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 					   u32 val_a, u32 val_b);
 
-#ifdef CONFIG_X86
+#ifndef CONFIG_IA64
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
 static inline void arch_reserve_mem_area(acpi_physical_address addr,
-- 
2.17.1

