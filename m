Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B268954147A;
	Tue, 22 Sep 2026 12:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079511; cv=none; b=Mso+aIgg7Datj3Ag9ZlO/DUHjV3ootnXXkCyos6yCnpOXjocso5VLy4XSB7N0rTllJHXz4uEIr1RhXqZDDAoK3ig3WRRJEpb6xIZ9iiqqbMWRdvv3l5Yb4aYFxj5Gi/2gsf4aN/UMGN8oXhh2W4bqdroQO5LbO6ryBnnK261WKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079511; c=relaxed/simple;
	bh=XnTjQ59ZCsiFN7d715NkJvR8ea2j8/XgdgbYql7zwSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dmod3UqnQApsPdfxvc6/hnQBLuk71loUQZ0nueOh6swNc1Kf6rv9bULO01i1SYoGHhXVyL1f1VE8T3rG4PwFWejurdJZnrBc9q00ucIwUA1QDB6BHHXFwAUkQrejUf7iD0HWlkwXqf2GIBw6GoVlMaKghXFEf47y+UWtZGbsya4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxHNITcrJqVqAOAA--.42720S3;
	Tue, 22 Sep 2026 20:18:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHs8ScrJqzMAjAA--.45156S2;
	Tue, 22 Sep 2026 20:18:26 +0800 (CST)
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
Subject: [PATCH v4 4/4] MAINTAINERS: Add entry for drivers/acpi/loongarch
Date: Tue, 22 Sep 2026 20:10:58 +0800
Message-Id: <20260922121058.972734-5-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxHs8ScrJqzMAjAA--.45156S2
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
index cc3cae2e378b..f9ae86a42dec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -347,6 +347,15 @@ S:	Maintained
 F:	drivers/acpi/riscv/
 F:	include/linux/acpi_rimt.h
 
+ACPI FOR LOONGARCH (ACPI/LoongArch)
+M:	Bibo Mao <maobibo@loongson.cn>
+M:	Huacai Chen <chenhuacai@kernel.org>
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

