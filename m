From: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: [PATCH v2 1/2] acpi/nfit: Add support of NVDIMM memory error
 notification in ACPI 6.2
Date: Thu,  8 Jun 2017 12:36:57 -0600
Message-ID: <20170608183658.24731-2-toshi.kani@hpe.com>
References: <20170608183658.24731-1-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20170608183658.24731-1-toshi.kani-ZPxbGqLxI0U@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

ACPI 6.2 defines a new ACPI notification value to NVDIMM Root Device
in Table 5-169.

 0x81 Unconsumed Uncorrectable Memory Error Detected
      Used to pro-actively notify OSPM of uncorrectable memory errors
      detected (for example a memory scrubbing engine that continuously
      scans the NVDIMMs memory). This is an optional notification. Only
      locations that were mapped in to SPA by the platform will generate
      a notification.

Add support of this notification value by initiating an ARS scan. This
will find new error locations and add their badblocks information.

Link: http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
Signed-off-by: Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
---
 drivers/acpi/nfit/core.c |   28 ++++++++++++++++++++++------
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 656acb5..cc22778 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2967,7 +2967,7 @@ static int acpi_nfit_remove(struct acpi_device *adev)
 	return 0;
 }
 
-void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
+static void acpi_nfit_update_notify(struct device *dev, acpi_handle handle)
 {
 	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -2975,11 +2975,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 	acpi_status status;
 	int ret;
 
-	dev_dbg(dev, "%s: event: %d\n", __func__, event);
-
-	if (event != NFIT_NOTIFY_UPDATE)
-		return;
-
 	if (!dev->driver) {
 		/* dev->driver may be null if we're being removed */
 		dev_dbg(dev, "%s: no driver found for dev\n", __func__);
@@ -3016,6 +3011,27 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 		dev_err(dev, "Invalid _FIT\n");
 	kfree(buf.pointer);
 }
+
+static void acpi_nfit_uc_error_notify(struct device *dev, acpi_handle handle)
+{
+	struct acpi_nfit_desc *acpi_desc = dev_get_drvdata(dev);
+
+	acpi_nfit_ars_rescan(acpi_desc);
+}
+
+void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
+{
+	dev_dbg(dev, "%s: event: 0x%x\n", __func__, event);
+
+	switch (event) {
+	case NFIT_NOTIFY_UPDATE:
+		return acpi_nfit_update_notify(dev, handle);
+	case NFIT_NOTIFY_UC_MEMORY_ERROR:
+		return acpi_nfit_uc_error_notify(dev, handle);
+	default:
+		return;
+	}
+}
 EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
 static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 58fb7d6..6cf9d21 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -80,6 +80,7 @@ enum {
 
 enum nfit_root_notifiers {
 	NFIT_NOTIFY_UPDATE = 0x80,
+	NFIT_NOTIFY_UC_MEMORY_ERROR = 0x81,
 };
 
 enum nfit_dimm_notifiers {
