From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4/5] clocksource/acpi: Add probing infrastructure for ACPI-based clocksources
Date: Fri,  4 Sep 2015 18:06:51 +0100
Message-ID: <1441386412-8139-5-git-send-email-marc.zyngier@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44861 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760374AbbIDRHU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Sep 2015 13:07:20 -0400
In-Reply-To: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

DT enjoys a rather nice probing infrastructure for clocksources,
while ACPI is so far stuck into a very distant past.

This patch introduces a declarative API, allowing clocksources
to be self-contained and be called when parsing the GTDT table.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/clocksource/clksrc-of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/clksrc-of.c b/drivers/clocksource/clksrc-of.c
index 0093a8e..b351b1e 100644
--- a/drivers/clocksource/clksrc-of.c
+++ b/drivers/clocksource/clksrc-of.c
@@ -14,6 +14,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/clocksource.h>
@@ -38,6 +39,9 @@ void __init clocksource_of_init(void)
 		init_func(np);
 		clocksources++;
 	}
+
+	clocksources += acpi_probe_device_table(ACPI_SIG_GTDT);
+
 	if (!clocksources)
 		pr_crit("%s: no matching clocksources found\n", __func__);
 }
-- 
2.1.4

