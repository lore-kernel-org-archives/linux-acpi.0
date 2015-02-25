From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v9 10/21] ARM64 / ACPI: If we chose to boot from acpi then disable FDT
Date: Wed, 25 Feb 2015 16:39:50 +0800
Message-ID: <1424853601-6675-11-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=force has been passed, then do not unflat devicetree
effectively disabling further hardware probing from DT.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4f1a014..e8c7000 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -390,7 +390,8 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_reset();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.9.1
