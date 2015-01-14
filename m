From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v7 05/17] ARM64 / ACPI: If we chose to boot from acpi then
 disable FDT
Date: Wed, 14 Jan 2015 23:04:53 +0800
Message-ID: <1421247905-3749-6-git-send-email-hanjun.guo@linaro.org>
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

From: Graeme Gregory <graeme.gregory@linaro.org>

If the early boot methods of acpi are happy that we have valid ACPI
tables and acpi=force has been passed, then do not unflat devicetree
effectively disabling further hardware probing from DT.

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4580ed3..5d139e1 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -411,7 +411,8 @@ void __init setup_arch(char **cmdline_p)
 	efi_idmap_init();
 	early_ioremap_reset();
 
-	unflatten_device_tree();
+	if (acpi_disabled)
+		unflatten_device_tree();
 
 	psci_init();
 
-- 
1.9.1
