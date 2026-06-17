Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708A3BBFC4;
	Wed, 17 Jun 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682597; cv=none; b=PkHdJGOiiVDBXN33sCu0+ZPGSL1U9GfQiIGmb8qrJtO8K8V2E67nVv5xJyHSrevmuArI0ep+be5GvGXp4b30enRbdRM2K+YhxcfayorIBELOSXuYIzVs+MM4XnAXhLmOI7GanIcC++nLmi2MFbDiDGTLun5m3EUq36jfo7ZeRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682597; c=relaxed/simple;
	bh=bVbFxOhJB8ijHDXX6RTF5B7LeOT1hSzvswbHxF5N5JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/gAz/jPw24i6WJTky466eLZuaG1Lau+7MiVcFXlVPyps/zAzf25oqSof17ypDSFOqqrvwKOHVjNy3uVYm6WEriueWgf1F7vvJN0fKcJRc8h6z0QpuLTki+BHkdt0BWmGCneWOG0/LKh46CzHZdShekTdNjaxJ6jBgEUv7AsPKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxdnhVUTJqzw4VAA--.30347S3;
	Wed, 17 Jun 2026 15:48:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMJVUTJqoAupAA--.58693S2;
	Wed, 17 Jun 2026 15:48:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	bibo.mao@gmail.com
Subject: [PATCH 4/8] ACPI: LoongArch: Add acpi_arch_late_init support
Date: Wed, 17 Jun 2026 15:48:25 +0800
Message-Id: <20260617074829.2396638-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260617074829.2396638-1-maobibo@loongson.cn>
References: <20260617074829.2396638-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHMJVUTJqoAupAA--.58693S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On LoongArch system, IOMMU is PCI device, its device id is based
on BDF information. IOVT table scanning should be called after PCI
device scanning.

Here api acpi_arch_late_init() is added, it is a weak function on
other architectures. On LoongArch it is empty function now, IOVT table
scanning function be will executed in this function later.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/bus.c            | 2 ++
 drivers/acpi/loongarch/init.c | 4 ++++
 include/linux/acpi.h          | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3b7db94b81f7..4a2d2bab05cd 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1556,6 +1556,7 @@ struct kobject *acpi_kobj;
 EXPORT_SYMBOL_GPL(acpi_kobj);
 
 void __weak __init acpi_arch_init(void) { }
+void __weak __init acpi_arch_late_init(void) { }
 
 static int __init acpi_init(void)
 {
@@ -1594,6 +1595,7 @@ static int __init acpi_init(void)
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
+	acpi_arch_late_init();
 	acpi_viot_init();
 	return 0;
 }
diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
index 9233f6c1cb55..1aa9bfa66e51 100644
--- a/drivers/acpi/loongarch/init.c
+++ b/drivers/acpi/loongarch/init.c
@@ -8,3 +8,7 @@ void __init acpi_arch_init(void)
 	if (IS_ENABLED(CONFIG_ACPI_IOVT))
 		acpi_iovt_init();
 }
+
+void __init acpi_arch_late_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 67effb91fa98..24d00d01bf12 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1610,6 +1610,7 @@ static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
 #endif
 
 void acpi_arch_init(void);
+void acpi_arch_late_init(void);
 
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
-- 
2.39.3

