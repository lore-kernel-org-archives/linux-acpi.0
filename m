Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C031340401;
	Tue, 16 Jun 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617909; cv=none; b=mwZ23BRZ8n68WqYuc3Xd+F0PcH0tn4r0rGE48xwjwWOKTkwzHqoRgTC88RFTCStq2Sid1ajCZBbiAD6T/fQraG/5XnrOv5bJ4biyOH5THPFCLLwdTDem/mm7iBlR3ivOjAgGfR8bSt1xd9U/TYrmtKWE8wG0g87CDyRhrnsjwfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617909; c=relaxed/simple;
	bh=NXfjp3cWkRoAObJMa2EMTcl3f113Bb0wPQfQUwt1xBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fi5MGsIqI2fwuMow8KKZXFwnnURGiItPwtdHYs2JPsMfpjvHObtUxVomx6uAPdy5W9J97r7EfhRnMJbbFKX+BLTw5PCUG5RV9Zo+kARt3CuXTcmyQx6536x93tgr4Eds2tcdxw6C4lZOsykfLNzNVRBpzAzBGSZHFx6lCMnw3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3VdzjVDFqj0rvFA--.12812S3;
	Tue, 16 Jun 2026 21:51:31 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Date: Tue, 16 Jun 2026 21:51:31 +0800
Subject: [PATCH 1/2] ACPI: tables: Add missing #include <asm/fixmap.h>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-riscv-acpi-table-upgrade-v1-1-45902d2dedf9@iscas.ac.cn>
References: <20260616-riscv-acpi-table-upgrade-v1-0-45902d2dedf9@iscas.ac.cn>
In-Reply-To: <20260616-riscv-acpi-table-upgrade-v1-0-45902d2dedf9@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.2
X-CM-TRANSID:rQCowAA3VdzjVDFqj0rvFA--.12812S3
X-Coremail-Antispam: 1UD129KBjvdXoWrury5Zr1xZr13uFWDGw18Grg_yoW3Jrb_C3
	W7Xr4S9ryjkw48t3WftFZxZFyqkrykXwn5uF1vqw1ay3WkAryfGa1kX3W8Za1UuFyrKFn8
	u3WDt3s7Cr43GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
	0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
	x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E
	0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67
	AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
	0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42
	xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjfUwfOzDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

drivers/acpi/tables.c uses NR_FIX_BTMAPS without including
<asm/fixmap.h>. This isn't a problem for existing archs, but would be
when ARCH_HAS_ACPI_TABLE_UPGRADE is enabled for RISC-V. Add the missing
include.

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
---
 drivers/acpi/tables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 4286e4af1092..eb93c060426f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -22,6 +22,7 @@
 #include <linux/initrd.h>
 #include <linux/security.h>
 #include <linux/kmemleak.h>
+#include <asm/fixmap.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT

-- 
2.54.0

