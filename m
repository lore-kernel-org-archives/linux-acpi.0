From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 1/4] ACPI: Allow _DMA method in walk resources
Date: Thu, 20 Jul 2017 15:45:13 +0100
Message-ID: <20170720144517.32529-2-lorenzo.pieralisi@arm.com>
References: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170720144517.32529-1-lorenzo.pieralisi@arm.com>
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
Cc: Feng Kan <fkan@apm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>, Nate Watterson <nwatters@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

The _DMA object contains a resource template, this change adds support
for the walk resources function so that ACPI devices containing a _DMA
object can actually parse it to detect DMA ranges for the respective
bus.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Robert Moore <robert.moore@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/acpica/rsxface.c | 7 ++++---
 include/acpi/acnames.h        | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 59a4f9e..be65e65 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -615,7 +615,7 @@ ACPI_EXPORT_SYMBOL(acpi_walk_resource_buffer)
  *                                device we are querying
  *              name            - Method name of the resources we want.
  *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
- *                                METHOD_NAME__AEI)
+ *                                METHOD_NAME__AEI or METHOD_NAME__DMA)
  *              user_function   - Called for each resource
  *              context         - Passed to user_function
  *
@@ -641,11 +641,12 @@ acpi_walk_resources(acpi_handle device_handle,
 	if (!device_handle || !user_function || !name ||
 	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
 	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__DMA))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the _CRS/_PRS/_AEI resource list */
+	/* Get the _CRS/_PRS/_AEI/_DMA resource list */
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	status = acpi_rs_get_method_data(device_handle, name, &buffer);
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index b421584..d8dd3bf 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -54,6 +54,7 @@
 #define METHOD_NAME__CLS        "_CLS"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__DDN        "_DDN"
+#define METHOD_NAME__DMA        "_DMA"
 #define METHOD_NAME__HID        "_HID"
 #define METHOD_NAME__INI        "_INI"
 #define METHOD_NAME__PLD        "_PLD"
-- 
2.10.0
