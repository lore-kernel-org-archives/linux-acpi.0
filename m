From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] irqchip: gic-v3-its: keep the head file include in alphabetic order
Date: Wed, 14 Sep 2016 21:49:54 +0800
Message-ID: <1473860994-3996-3-git-send-email-guohanjun@huawei.com>
References: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

The head file is strictly in alphabetic order now, so let's
not be the rule breaker.

And acpi_iort.h includes acpi.h, remove acpi.h here.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 35c851c..b1ff440 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -15,13 +15,12 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
-#include <linux/acpi_iort.h>
 #include <linux/log2.h>
 #include <linux/mm.h>
 #include <linux/msi.h>
-- 
1.7.12.4
