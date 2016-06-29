From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2 4/4] ACPI,PCI,IRQ: correct operator precedence
Date: Wed, 29 Jun 2016 04:27:38 -0400
Message-ID: <1467188859-28188-5-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, agross@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, tiwai@suse.com, perex@perex.cz, Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

The omitted parenthesis prevents the addition operation when
acpi_penalize_isa_irq function is called.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 8c08971..c983bf7 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -872,7 +872,7 @@ void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
 		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
+		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.8.2.1
