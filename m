From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: [PATCH v4 1/4] ACPI, CPER: add arm error info type definition
Date: Wed, 27 Sep 2017 20:50:17 +0800
Message-ID: <1506516620-20033-2-git-send-email-xiexiuqi@huawei.com>
References: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7050 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdI0Mr3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Sep 2017 08:47:29 -0400
In-Reply-To: <1506516620-20033-1-git-send-email-xiexiuqi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, stephen.boyd@linaro.org, bp@suse.de, julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xiexiuqi@huawei.com, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org, cj.chengjian@huawei.com

Add arm error info type definition according to ACPI6.1
Table 261. ARM Processor Error Information Structure,
which is used for error recovery in the following patches.

Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 include/linux/cper.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index 723e952..9106e2b 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -275,6 +275,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
+#define CPER_ARM_INFO_TYPE_CACHE		0
+#define CPER_ARM_INFO_TYPE_TLB			1
+#define CPER_ARM_INFO_TYPE_BUS			2
+#define CPER_ARM_INFO_TYPE_UARCH		3
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
-- 
1.8.3.1

