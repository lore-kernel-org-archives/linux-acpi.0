From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [RESEND PATCH] ACPI/IORT: Fix rc_dma_get_range()
Date: Thu, 10 Jan 2019 18:41:51 +0000
Message-ID: <20190110184151.27492-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Eric Auger <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-acpi@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When executed for a PCI_ROOT_COMPLEX type, iort_match_node_callback()
expects the opaque pointer argument to be a PCI bus device. At the
moment rc_dma_get_range() passes the PCI endpoint instead of the bus,
and we've been lucky to have pci_domain_nr(ptr) return 0 instead of
crashing. Pass the bus device to iort_scan_node().

Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
Will, Catalin,

resending a reformatted version of this fix previously posted in [1],
please merge it for one of the upcoming -rc.

Thanks,
Lorenzo

[1] https://marc.info/?l=linux-acpi&m=154712742324811&w=2

 drivers/acpi/arm64/iort.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index fdd90ffceb85..c08afe44c488 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -952,9 +952,10 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
 {
 	struct acpi_iort_node *node;
 	struct acpi_iort_root_complex *rc;
+	struct pci_bus *pbus = to_pci_dev(dev)->bus;
 
 	node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-			      iort_match_node_callback, dev);
+			      iort_match_node_callback, &pbus->dev);
 	if (!node || node->revision < 1)
 		return -ENODEV;
 
-- 
2.19.2
