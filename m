From: fu.wei@linaro.org
Subject: [PATCH v6 06/10] acpi: Add GTDT driver to kernel build system
Date: Thu, 30 Jun 2016 02:15:49 +0800
Message-ID: <1467224153-22873-7-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: wei@redhat.com, harba@codeaurora.org, Fu Wei <fu.wei@linaro.org>, al.stone@linaro.org, graeme.gregory@linaro.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, timur@codeaurora.org, will.deacon@arm.com, rruigrok@codeaurora.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wim@iguana.be, arnd@arndb.de, cov@codeaurora.org, Suravee.Suthikulpanit@amd.com, catalin.marinas@arm.com, leo.duran@amd.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/acpi/Kconfig  | 9 +++++++++
 drivers/acpi/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b7e2e77..27a5cf9 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -521,4 +521,13 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_GTDT
+	bool "ACPI GTDT Support"
+	depends on ARM64
+	help
+	  GTDT (Generic Timer Description Table) provides information
+	  for per-processor timers and Platform (memory-mapped) timers
+	  for ARM platforms. Select this option to provide information
+	  needed for the timers init.
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 251ce85..848aa8a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -99,5 +99,6 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= acpi_gtdt.o
 
 video-objs			+= acpi_video.o video_detect.o
-- 
2.5.5
