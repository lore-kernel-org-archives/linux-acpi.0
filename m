From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Mon,  2 Feb 2015 20:45:30 +0800
Message-ID: <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58158 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbbBBMsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Feb 2015 07:48:23 -0500
Received: by mail-pa0-f41.google.com with SMTP id kq14so82108539pab.0
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2015 04:48:22 -0800 (PST)
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>, wangyijing@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Mark Salter <msalter@redhat.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Mark Salter <msalter@redhat.com>

The acpi_os_ioremap() function may be used to map normal RAM or IO
regions. The current implementation simply uses ioremap_cache(). This
will work for some architectures, but arm64 ioremap_cache() cannot be
used to map IO regions which don't support caching. So for arm64, use
ioremap() for non-RAM regions.

CC: Rafael J Wysocki <rjw@rjwysocki.net>
Signed-off-by: Mark Salter <msalter@redhat.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/acpi/acpi_io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index 444671e..9d573db 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -1,11 +1,17 @@
 #ifndef _ACPI_IO_H_
 #define _ACPI_IO_H_
 
+#include <linux/mm.h>
 #include <linux/io.h>
 
 static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 					    acpi_size size)
 {
+#ifdef CONFIG_ARM64
+	if (!page_is_ram(phys >> PAGE_SHIFT))
+		return ioremap(phys, size);
+#endif
+
        return ioremap_cache(phys, size);
 }
 
-- 
1.9.1

