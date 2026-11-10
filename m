Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300389;
	b=RTfXZ1JYzeS98YAAee2YkErvx0H0q86f6x4mdK8lBtCIXQOInvQAokjcXpQCSN0kB0zB
	 KkPPmoHcXhbQ0LbL/FZnMO28mlj6sahiipvIOxmSCLJPl9VfTT0F6VxCbLo6gFecJV6XQ
	 LHjUvENUw2SyJ322+TgvHA0EwOMAFz1ev7Xh+D0N/Uu9p0qeDBEsCudeSSUFgvVfaxwqd
	 IFpUi0fMj+8Oe9X4spoO1Pu4w1eq5a7H1pHiVsMDo9Us/swuGiDN6Lh2UW2jLdyn6u9Nc
	 r949ptrEC+Ojx/jCM4tLSGyqMDLEcaLr0giPvF6rkui8x6VuwSvKVaqnoVbd3WnX8Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300389;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=WODBY/C9mNszW/PzbpSN6cT6sbxCA9RxgeIBOD8aysI=;
	b=woiC9HzhmewA/K5OiYyEO7V5aizxShZwJ0dXNdoUFS9bxeZbPo7l6fy3V24LiPM0Lagu
	 7j25ttm1H9gIKgF0cXFh/O1jvQC3KLCdwIi2OdY+VGq7yinEqRKiqMuqo4DRNxnNqLS8J
	 H+9se6H6xlFwJfl0WBZ1S5jy5wUbvEMaylAHOcXfsByEjCqzjGsPhuc+UqhOBpGjeLiUk
	 IFenKG8mLe2NQu2YMbkFnGUuKhUfiruMFxaaOudHOBDQBepD2RQK4/RntFmgJ1cZP2kcm
	 GIxVQH4byGvpNpD4gWKC4yI9Le7Jx/o9YsiyI6/a63g0m7cZP6wNK01e2VkuqWfj/oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3A606A338;
	Tue, 10 Nov 2026 08:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E3A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxztLi2fJqeB8eAA--.20864S3;
	Tue, 10 Nov 2026 16:46:26 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxe87e2fJqWXMzAA--.22061S4;
	Tue, 10 Nov 2026 16:46:25 +0800 (CST)
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
Subject: [PATCH 2/2] ACPI: LoongArch: Add checksum support with IOVT table
Date: Tue, 10 Nov 2026 16:46:13 +0800
Message-Id: <20261110084613.2746641-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261110084613.2746641-1-maobibo@loongson.cn>
References: <20261110084613.2746641-1-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxe87e2fJqWXMzAA--.22061S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Checksum information is put in acpi_table_header, here add
checksum support with IOVT table.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 6c5bcb4df7d8..c9830ba46729 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -20,6 +20,7 @@ struct iovt_fwnode {
 
 static LIST_HEAD(iovt_fwnode_list);
 static DEFINE_SPINLOCK(iovt_fwnode_lock);
+static bool checksum_valid;
 
 #ifdef CONFIG_PCI
 static void __init iovt_enable_acs(struct acpi_iovt_iommu *iommu)
@@ -168,6 +169,17 @@ static void __init iovt_init_devices(struct acpi_table_header *header)
 	}
 }
 
+/* Come from acpi_ut_checksum */
+static unsigned char acpi_iovt_checksum(unsigned char *buffer, unsigned int len)
+{
+	unsigned char sum = 0, *end = buffer + len;
+
+	while (buffer < end)
+		sum += *buffer++;
+
+	return sum;
+}
+
 void __init acpi_iovt_init(void)
 {
 	int i;
@@ -184,6 +196,13 @@ void __init acpi_iovt_init(void)
 		return;
 	}
 
+	if (acpi_iovt_checksum((unsigned char *)hdr, hdr->length)) {
+		pr_err("IOVT invalid checksum\n");
+		acpi_put_table(hdr);
+		return;
+	}
+
+	checksum_valid = true;
 	iovt = (struct acpi_table_iovt *)hdr;
 	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
 	for (i = 0; i < iovt->iommu_count; i++) {
@@ -199,6 +218,9 @@ void __init acpi_iovt_late_init(void)
 	acpi_status status;
 	struct acpi_table_header *hdr;
 
+	if (!checksum_valid)
+		return;
+
 	status = acpi_get_table(ACPI_SIG_IOVT, 0, &hdr);
 	if (ACPI_FAILURE(status)) {
 		if (status != AE_NOT_FOUND)
-- 
2.39.3

