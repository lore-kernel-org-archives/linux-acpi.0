From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: [PATCH V5 3/9] ACPI: Adding DMA Attribute APIs for ACPI Device
Date: Wed, 28 Oct 2015 15:50:48 -0700
Message-ID: <1446072654-5608-4-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446072654-5608-1-git-send-email-Suravee.Suthikulpanit@amd.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, will.deacon@arm.com
Cc: thomas.lendacky@amd.com, herbert@gondor.apana.org.au, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Adding acpi_get_dma_attr() to query DMA attributes of ACPI devices.
It returns the enum dev_dma_attr, which communicates DMA information
more clearly. This API replaces the acpi_check_dma(), which will be
removed in subsequent patch.

This patch also provides a convenient function, acpi_dma_supported(),
to check DMA support of the specified ACPI device.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
CC: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/acpi/scan.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h |  3 +++
 include/linux/acpi.h    | 10 ++++++++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index daf9fc8..78d5f02 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1308,6 +1308,48 @@ void acpi_free_pnp_ids(struct acpi_device_pnp *pnp)
 	kfree(pnp->unique_id);
 }
 
+/**
+ * acpi_dma_supported - Check DMA support for the specified device.
+ * @adev: The pointer to acpi device
+ *
+ * Return false if DMA is not supported. Otherwise, return true
+ */
+bool acpi_dma_supported(struct acpi_device *adev)
+{
+	if (!adev)
+		return false;
+
+	if (adev->flags.cca_seen)
+		return true;
+
+	/*
+	* Per ACPI 6.0 sec 6.2.17, assume devices can do cache-coherent
+	* DMA on "Intel platforms".  Presumably that includes all x86 and
+	* ia64, and other arches will set CONFIG_ACPI_CCA_REQUIRED=y.
+	*/
+	if (!IS_ENABLED(CONFIG_ACPI_CCA_REQUIRED))
+		return true;
+
+	return false;
+}
+
+/**
+ * acpi_get_dma_attr - Check the supported DMA attr for the specified device.
+ * @adev: The pointer to acpi device
+ *
+ * Return enum dev_dma_attr.
+ */
+enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
+{
+	if (!acpi_dma_supported(adev))
+		return DEV_DMA_NOT_SUPPORTED;
+
+	if (adev->flags.coherent_dma)
+		return DEV_DMA_COHERENT;
+	else
+		return DEV_DMA_NON_COHERENT;
+}
+
 static void acpi_init_coherency(struct acpi_device *adev)
 {
 	unsigned long long cca = 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0f131d2..920b774 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -596,6 +596,9 @@ struct acpi_pci_root {
 
 /* helper */
 
+bool acpi_dma_supported(struct acpi_device *adev);
+enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
 int acpi_is_root_bridge(acpi_handle);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 82f56bb..6527920 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -598,6 +598,16 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
 	return false;
 }
 
+static inline bool acpi_dma_supported(struct acpi_device *adev)
+{
+	return false;
+}
+
+static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
+{
+	return DEV_DMA_NOT_SUPPORTED;
+}
+
 #define ACPI_PTR(_ptr)	(NULL)
 
 #endif	/* !CONFIG_ACPI */
-- 
2.1.0
