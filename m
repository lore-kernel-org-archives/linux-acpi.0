From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v3 1/2] acpi: apei: remove the unused dead-code for SEA notification type
Date: Thu, 28 Sep 2017 20:41:37 +0800
Message-ID: <1506602498-25752-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, tbaicar@codeaurora.org, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gengdongjiu@huawei.com, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com
List-Id: linux-acpi@vger.kernel.org

In current code logic, the two functions ghes_sea_add() and
ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
is defined. If not, it will return errors in the ghes_probe()
and not continue. If the probe is failed, the ghes_sea_remove()
also has no chance to be called. Hence, remove the unnecessary
handling when CONFIG_ACPI_APEI_SEA is not defined.

In the firmware-first RAS solution, the IPA fault address recorded
by hpfar_el2 may be UNKNOWN, and also current code does not use it,
so remove it.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

---
v2->v3:
1. remove the fault_ipa address
If ESR_ELx.DFSC is Synchronous External Abort on memory access(0b010000),
the hpfar_el2's value will be UNKNOWN, so this value is not accurate.

It is ever discussed here:
https://lkml.org/lkml/2017/9/8/623
---
 arch/arm/include/asm/system_misc.h   |  2 +-
 arch/arm64/include/asm/system_misc.h |  2 +-
 arch/arm64/mm/fault.c                |  2 +-
 drivers/acpi/apei/ghes.c             | 14 --------------
 virt/kvm/arm/mmu.c                   |  2 +-
 5 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 8c4a89f..5b53a1c 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -22,7 +22,7 @@ extern void (*arm_pm_idle)(void);
 
 extern unsigned int user_debug;
 
-static inline int handle_guest_sea(phys_addr_t addr, unsigned int esr)
+static inline int handle_guest_sea(unsigned int esr)
 {
 	return -1;
 }
diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 07aa8e3..3f0d0a8 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -56,7 +56,7 @@ extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 	__show_ratelimited;						\
 })
 
-int handle_guest_sea(phys_addr_t addr, unsigned int esr);
+int handle_guest_sea(unsigned int esr);
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2509e4f..13391f4 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -677,7 +677,7 @@ static const struct fault_info fault_info[] = {
  * and non-zero if there was an error processing the error or there was
  * no error to process.
  */
-int handle_guest_sea(phys_addr_t addr, unsigned int esr)
+int handle_guest_sea(unsigned int esr)
 {
 	int ret = -ENOENT;
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..c15a08d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -813,7 +813,6 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-#ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
 
 /*
@@ -848,19 +847,6 @@ static void ghes_sea_remove(struct ghes *ghes)
 	mutex_unlock(&ghes_list_mutex);
 	synchronize_rcu();
 }
-#else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
-
-static inline void ghes_sea_remove(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
-#endif /* CONFIG_ACPI_APEI_SEA */
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 2ea21da..07636c2 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1504,7 +1504,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	 * is no need to pass the error into the guest.
 	 */
 	if (is_abort_sea(fault_status)) {
-		if (!handle_guest_sea(fault_ipa, kvm_vcpu_get_hsr(vcpu)))
+		if (!handle_guest_sea(kvm_vcpu_get_hsr(vcpu)))
 			return 1;
 	}
 
-- 
2.10.1
