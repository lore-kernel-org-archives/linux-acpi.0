From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Wed, 25 Apr 2018 18:31:12 -0500
Message-ID: <20180425233121.13270-5-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: Mark.Rutland@arm.com, austinwc@codeaurora.org, tnowicki@caviumnetworks.com, Catalin.Marinas@arm.com, palmer@sifive.com, Will.Deacon@arm.com, linux-riscv@lists.infradead.org, Morten.Rasmussen@arm.com, vkilari@codeaurora.org, Lorenzo.Pieralisi@arm.com, ahs3@redhat.com, lenb@kernel.org, john.garry@huawei.com, wangxiongfeng2@huawei.com, jhugo@qti.qualcomm.com, Dietmar.Eggemann@arm.com, linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, timur@qti.qualcomm.com, hanjun.guo@linaro.org, Sudeep.Holla@arm.com
List-Id: linux-acpi@vger.kernel.org

Its helpful to be able to lookup the acpi_processor_id associated
with a logical cpu. Provide an arm64 helper to do this.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 32f465a80e4e..0db62a4cbce2 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+{
+	return	acpi_cpu_get_madt_gicc(cpu)->uid;
+}
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
-- 
2.13.6
