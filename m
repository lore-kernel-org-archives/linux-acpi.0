From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 07/17] ARM64 / ACPI: Disable ACPI if FADT revision is less
 than 5.1
Date: Wed, 14 Jan 2015 23:04:55 +0800
Message-ID: <1421247905-3749-8-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, wangyijing@huawei.com, Mark Brown <broonie@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, phoenix.liyi@huawei.com, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

FADT Major.Minor version was introduced in ACPI 5.1, it is the same
as ACPI version.

In ACPI 5.1, some major gaps are fixed for ARM, such as updates in
MADT table for GIC and SMP init, without those updates, we can not
get the MPIDR for SMP init, and GICv2/3 related init information, so
we can't boot arm64 ACPI properly with table versions predating 5.1.

If firmware provides ACPI tables with ACPI version less than 5.1,
OS will be messed up with those information and have no way to init
smp and GIC, so disable ACPI if we get an FADT table with version
less that 5.1.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 39a1655..4177758 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -13,6 +13,8 @@
  *  published by the Free Software Foundation.
  */
 
+#define pr_fmt(fmt) "ACPI: " fmt
+
 #include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/cpumask.h>
@@ -49,10 +51,32 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
 	early_memunmap(map, size);
 }
 
+static int __init acpi_parse_fadt(struct acpi_table_header *table)
+{
+	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
+
+	/*
+	 * Revision in table header is the FADT Major revision,
+	 * and there is a minor revision of FADT which was introduced
+	 * by ACPI 5.1, we only deal with ACPI 5.1 or newer revision
+	 * to get arm boot flags, or we will disable ACPI.
+	 */
+	if (table->revision > 5 ||
+	    (table->revision == 5 && fadt->minor_revision >= 1))
+		return 0;
+
+	pr_warn("Unsupported FADT revision %d.%d, should be 5.1+, will disable ACPI\n",
+		table->revision, fadt->minor_revision);
+	disable_acpi();
+
+	return -EINVAL;
+}
+
 /*
  * acpi_boot_table_init() called from setup_arch(), always.
  *	1. find RSDP and get its address, and then find XSDT
  *	2. extract all tables and checksums them all
+ *	3. check ACPI FADT revision
  *
  * We can parse ACPI boot-time tables such as MADT after
  * this function is called.
@@ -64,8 +88,13 @@ void __init acpi_boot_table_init(void)
 		return;
 
 	/* Initialize the ACPI boot-time table parser. */
-	if (acpi_table_init())
+	if (acpi_table_init()) {
 		disable_acpi();
+		return;
+	}
+
+	if (acpi_table_parse(ACPI_SIG_FADT, acpi_parse_fadt))
+		pr_err("Can't find FADT or error happened during parsing FADT\n");
 }
 
 static int __init parse_acpi(char *arg)
-- 
1.9.1
