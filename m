From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 11/13] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64
Date: Fri, 27 Jun 2014 11:49:34 +0800
Message-ID: <1403840976-7456-12-git-send-email-hanjun.guo@linaro.org>
References: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403840976-7456-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, rric@kernel.org, Grant Likely <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Charles.Garcia-Tobin@arm.com, lorenzo.pieralisi@arm.com, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Al Stone <al.stone@linaro.org>

ACPI reduced hardware mode is disabled by default, but ARM64
can only run properly in ACPI hardware reduced mode, so select
ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.

Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index db5190a..102384e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,5 +1,6 @@
 config ARM64
 	def_bool y
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-- 
1.7.9.5
