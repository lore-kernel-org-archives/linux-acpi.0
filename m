Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429454147A;
	Tue, 22 Sep 2026 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079506; cv=none; b=fS52KSfkCCZiExZhh2D8IU1ugYjxiBb6quSCvmRkcHqGkRxk2THR8ORg61HUzCI2x1IITvbsKaV84giBPCsjeQN7Iqb4qovxBLd5KrGjaf27Z6IHrHlvfcwaWWE2SobLRJj6huxwbzjDsuasR5mu6vCY2Ebr/WWgNvdJHxUBRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079506; c=relaxed/simple;
	bh=BHw8oYA5cUdxj0Pv1MbAjMukmRTWHNxTlSixQVJdkmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKIuxpH3k8+hQIVPPOqmsfPKOaLqp13qel4TkUideNYvK81ibM+M/9O4+T8bHt5VHlwXvFhTG5+wrlwQOO8wQtNr73MBba0phdzy6yqJLHAkb5acCswSvWRJ4W9d1sNzeCGqcpF2qnYD03+u9MjgxxZTPMoGJz5ffkcnhaVBbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxhvANcrJqSaAOAA--.42670S3;
	Tue, 22 Sep 2026 20:18:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c0LcrJqysAjAA--.44690S3;
	Tue, 22 Sep 2026 20:18:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn
Subject: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags field in the IOVT IOMMU structure
Date: Tue, 22 Sep 2026 20:10:55 +0800
Message-Id: <20260922121058.972734-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260922121058.972734-1-maobibo@loongson.cn>
References: <20260922121058.972734-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c0LcrJqysAjAA--.44690S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

According to the IOVT specification, define macros for each bit of the
Flags field in the IOVT IOMMU structure.

Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 include/acpi/actbl2.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index baef525367b5..76e4a5bc79b4 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
 	u32 device_entry_offset;
 };
 
+/* Masks for Flags field above */
+#define ACPI_IOVT_IOMMU_PCI_DEVICE		(1<<0)
+#define ACPI_IOVT_IOMMU_PXM_VALID		(1<<1)
+#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT	(1<<2)
+#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT		(1<<3)
+#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS		(1<<4)
+
 struct acpi_iovt_device_entry {
 	u8 type;
 	u8 length;
-- 
2.39.3

