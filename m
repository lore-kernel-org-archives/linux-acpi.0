From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v8 01/21] acpi: add arm64 to the platforms that use ioremap
Date: Mon,  2 Feb 2015 20:45:29 +0800
Message-ID: <1422881149-8177-2-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
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
Cc: Mark Langsdorf <mlangsdo@redhat.com>, linaro-acpi@lists.linaro.org, wangyijing@huawei.com, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Ashwin Chaugule <ashwinc@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

From: Graeme Gregory <graeme.gregory@linaro.org>

Now with the base changes to the arm memory mapping it is safe
to convert to using ioremap to map in the tables after
acpi_gbl_permanent_mmap is set.

CC: Rafael J Wysocki <rjw@rjwysocki.net>
Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/osl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f9eeae8..39748bb 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -336,11 +336,11 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
 	return NULL;
 }
 
-#ifndef CONFIG_IA64
-#define should_use_kmap(pfn)   page_is_ram(pfn)
-#else
+#if defined(CONFIG_IA64) || defined(CONFIG_ARM64)
 /* ioremap will take care of cache attributes */
 #define should_use_kmap(pfn)   0
+#else
+#define should_use_kmap(pfn)   page_is_ram(pfn)
 #endif
 
 static void __iomem *acpi_map(acpi_physical_address pg_off, unsigned long pg_sz)
-- 
1.9.1
