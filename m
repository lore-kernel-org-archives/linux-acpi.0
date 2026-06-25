Received: from va-2-18.ptr.blmpb.com (va-2-18.ptr.blmpb.com [209.127.231.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BAF39B955
	for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2026 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380841; cv=none; b=mwlF0y2zeiqBczgizup5HlymeR2AR3Ydb6fbZMK6r2vHycxCX7dmPaeLvtQOKQxDCORq6jK7DaHTLz3VtY4uo7ZxtRsweLjHF2kYUFhZl7Me+pFyGkDiU+0Vs/VAnrrbej6EidEBkzQUlrQjAfMHKWFw7WgGWuwSecBaOwyJzCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380841; c=relaxed/simple;
	bh=V+NNFTvdjSE782bh+GE6YrmR8t6bUHzukiewGvYp+Dg=;
	h=To:Mime-Version:Subject:Date:Message-Id:Cc:From:Content-Type; b=o1fxeBnnn9LilUhgJ4qhxXNkZv+CEL/a5moQtnCO/HsarRvSep+sQapbBLTst3bJsuxKV8AChD+2SmwTsCjKOgDA1pyxMbAsG1CDRH/EtlmG1Va4VQ9bI/W5orInXlD5CjON/1MjZeyFEvKWcOCAVB6C4dyxd6AIBxDRJZB3BEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=xUxiG5aD; arc=none smtp.client-ip=209.127.231.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="xUxiG5aD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782380828; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=u9Vr69DUWtU2GtQSnZ4vT3lQafTb6BSSmbeeV1i8VZw=;
 b=xUxiG5aDDwYXzKivlqpuTDaL0kxec5F9rmNI5p664NrEvEyZTqoEO4op5U/GMWLbm5QZ8w
 29Nkazb4pkiuEg2hXifN7X/2kib98la15RGdsbt0tDm1/M20gAkTuUnPyRC1KAWji+Qg9d
 2imf3iZ7zqt3BOIODppoDMw041fjAhwDxcmVpEAEW6oTejaJS8hKdMSR4rTKjB/jg/xtio
 J49Duxgxl8h3gW0FSvyjnr6Za/5SSEvOrK6wbPSwHSfonrinC+0iZTRYSL6cTZta6Ch9zc
 OFF71Zw/y0ygDFf6+sN8mkdXi8wpYUkPQtZiMsKXq7DOC5uYlQSe0TU0cD4isw==
To: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+26a3cf91a+142777+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Subject: [PATCH] ACPI: RIMT: Only defer the IOMMU configuration in init stage
Date: Thu, 25 Jun 2026 17:47:02 +0800
Message-Id: <20260625094702.11558-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([58.250.106.117]) by smtp.feishu.cn with ESMTPS; Thu, 25 Jun 2026 17:47:05 +0800
Cc: <lenb@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <geshijian@picoheart.com>, 
	<jialilv@picoheart.com>, <yang.yicong@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8

The IOMMU configuration will be deferred if the IOMMU driver
isn't probed by the time. Make this deferral only in the
initialization stage with driver_deferred_probe_check_state().
Otherwise the devices depends on IOMMU will be deferred forever
in case the IOMMU device probe failed or it doesn't appear in
the ACPI namespace.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 drivers/acpi/riscv/rimt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 906282b0e63c..e4538fa6c2c8 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/device/driver.h>
 #include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/pci.h>
@@ -257,11 +258,11 @@ static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32
 	rimt_fwnode = rimt_get_fwnode(node);
 
 	/*
-	 * The IOMMU drivers may not be probed yet.
-	 * Defer the IOMMU configuration
+	 * The IOMMU drivers may not be probed yet. Defer the IOMMU
+	 * configuration if it's still in initialization stage.
 	 */
 	if (!rimt_fwnode)
-		return -EPROBE_DEFER;
+		return driver_deferred_probe_check_state(dev);
 
 	/*
 	 * EPROBE_DEFER ensures IOMMU is probed before the devices that
-- 
2.50.1 (Apple Git-155)
