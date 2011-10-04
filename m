From: pingfank@linux.vnet.com
Subject: [PATCH 1/2] ACPI: Update cpu hotplug event for guest
Date: Tue,  4 Oct 2011 19:13:37 +0800
Message-ID: <1317726818-8514-3-git-send-email-pingfank@linux.vnet.com>
References: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: linux-acpi@vger.kernel.org, qemu-devel@nongnu.org
Cc: aliguori@us.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ryanh@us.ibm.com, shaohua.li@intel.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Need to update cpu hotplug event for guest when updating SCI event

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 hw/acpi_piix4.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/hw/acpi_piix4.c b/hw/acpi_piix4.c
index 44eb8ae..f585226 100644
--- a/hw/acpi_piix4.c
+++ b/hw/acpi_piix4.c
@@ -94,7 +94,8 @@ static void pm_update_sci(PIIX4PMState *s)
                    ACPI_BITMASK_POWER_BUTTON_ENABLE |
                    ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
                    ACPI_BITMASK_TIMER_ENABLE)) != 0) ||
-        (((s->gpe.sts[0] & s->gpe.en[0]) & PIIX4_PCI_HOTPLUG_STATUS) != 0);
+                (((s->gpe.sts[0] & s->gpe.en[0]) &
+                  (PIIX4_PCI_HOTPLUG_STATUS | PIIX4_CPU_HOTPLUG_STATUS)) != 0);
 
     qemu_set_irq(s->irq, sci_level);
     /* schedule a timer interruption if needed */
-- 
1.7.4.4
