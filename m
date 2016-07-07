From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v8 3/6] arm64: cpuidle: drop __init section marker to
 arm_cpuidle_init
Date: Thu,  7 Jul 2016 18:10:48 +0100
Message-ID: <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-2-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, PrashanthPrakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, ALKML <linux-arm-kernel@lists.infradead.org>, Sunil <sunil.vl@hpe.com>
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

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index e11857fce05f..06786fdaadeb 100644
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
2.7.4
