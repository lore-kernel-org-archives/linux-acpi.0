From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v5 3/5] arm64: cpuidle: drop __init section marker to arm_cpuidle_init
Date: Wed, 11 May 2016 16:37:40 +0100
Message-ID: <1462981062-24909-4-git-send-email-sudeep.holla@arm.com>
References: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462981062-24909-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Al Stone <al.stone@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Commit ea389daa7fd9 ("arm64: cpuidle: add __init section marker to
arm_cpuidle_init") added the __init annotation to arm_cpuidle_init
as it was not needed after booting which was correct at that time.

However with the introduction of ACPI LPI support, this will be used
from cpuhotplug path in ACPI processor driver.

This patch drops the __init annotation from arm_cpuidle_init to avoid
the following warning:

WARNING: vmlinux.o(.text+0x113c8): Section mismatch in reference from the
	function acpi_processor_ffh_lpi_probe() to the function
	.init.text:arm_cpuidle_init()
The function acpi_processor_ffh_lpi_probe() references
the function __init arm_cpuidle_init().
This is often because acpi_processor_ffh_lpi_probe lacks a __init
annotation or the annotation of arm_cpuidle_init is wrong.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index 9047cab68fd3..7ce589ca54a4 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -15,7 +15,7 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int __init arm_cpuidle_init(unsigned int cpu)
+int arm_cpuidle_init(unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
-- 
1.9.1
