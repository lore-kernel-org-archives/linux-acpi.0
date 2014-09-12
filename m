From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 07/18] ARM64 / ACPI: If we chose to boot from acpi then disable FDT
Date: Fri, 12 Sep 2014 22:00:05 +0800
Message-ID: <1410530416-30200-8-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Graeme Gregory <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=off has not been passed. Then do not unflat
devicetree effectively disabling further hardware probing from DT.

Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 5b05227..5796734 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -398,7 +398,8 @@ void __init setup_arch(char **cmdline_p)
 	efi_idmap_init();
 
 	cpu_logical_map(0) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.7.9.5
