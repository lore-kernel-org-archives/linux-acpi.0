Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771FE3BF68D;
	Wed, 17 Jun 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682596; cv=none; b=uIgzfTyWqBOyJ3+zn1HuGUyclIj8TLVmL3IHfQj4ULAp73K1A+YV9YG7LCQloE9I5/ZoDzrf2XhHh52F2frG6m5ruLDk4FN3AGbJmebPXk7DTrvDwGFF1JY1GhaglEWwn5w8yuOkXQT4swQgczHeUFsjap3dxavb2yu7SGrx6Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682596; c=relaxed/simple;
	bh=tiZa2f0O9gkf23RagFzxk/N9FHciktidglVXbFMAjTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OW4heA/v6HZWtfoUbsvP0gb4IcPcjkopj0XCrv1Bi6BYGSILBfDaFMsvWaQikKHPzgIlSsN9Ez/ATtYUPjJYRhpdpppScWDMMe3xXGzTefk1ub8A5l+oCl4gJ4t0v8Mjd1xGM0d03Wy6ElOlF26U6NOXUUsQzDNOgfrZ1RYsQ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxVXhZUTJq5A4VAA--.30317S3;
	Wed, 17 Jun 2026 15:48:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHMJYUTJqpgupAA--.58694S2;
	Wed, 17 Jun 2026 15:48:41 +0800 (CST)
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
Subject: [PATCH 8/8] MAINTAINERS: Add entry for drivers/acpi/loongarch
Date: Wed, 17 Jun 2026 15:48:29 +0800
Message-Id: <20260617074829.2396638-9-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxHMJYUTJqpgupAA--.58694S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

ACPI defines few LoongArch specific tables which need parsing code
added in drivers/acpi/loongarch. Add maintainer entries for this newly
created folder.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d6db8cb608f..49a20feca9fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -348,6 +348,15 @@ S:	Maintained
 F:	drivers/acpi/riscv/
 F:	include/linux/acpi_rimt.h
 
+ACPI FOR LoongArch (ACPI/LoongArch)
+M:	Bibo Mao <maobibo@loongson.cn>
+R:	Huacai Chen <chenhuacai@kernel.org>
+L:	linux-acpi@vger.kernel.org
+L:	loongarch@lists.linux.dev
+S:	Maintained
+F:	drivers/acpi/loongarch/
+F:	include/linux/acpi_iovt.h
+
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@kernel.org>
 L:	linux-acpi@vger.kernel.org
-- 
2.39.3

