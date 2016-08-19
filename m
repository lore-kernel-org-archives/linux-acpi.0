From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] acpi, nfit: check for the correct event code in notifications
Date: Fri, 19 Aug 2016 14:40:58 -0600
Message-ID: <1471639258-28106-1-git-send-email-vishal.l.verma@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-kernel@vger.kernel.org, Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

Commit 209851649dc4 "acpi: nfit: Add support for hot-add" added
support for _FIT notifications, but it neglected to verify the
notification event code matches the one in the ACPI spec for
"NFIT Update". Currently there is only one code in the spec, but
once additional codes are added, older kernels (without this fix)
will misbehave by assuming all event notifications are for an
NFIT Update.

Fixes: 209851649dc4 ("acpi: nfit: Add support for hot-add")
Cc: <stable@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Linda Knippers <linda.knippers@hpe.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/acpi/nfit/core.c | 3 +++
 drivers/acpi/nfit/nfit.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 80cc7c0..4a363be 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2681,6 +2681,9 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 
 	dev_dbg(dev, "%s: event: %d\n", __func__, event);
 
+	if (event != NFIT_NOTIFY_UPDATE)
+		return;
+
 	device_lock(dev);
 	if (!dev->driver) {
 		/* dev->driver may be null if we're being removed */
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index e894ded..51d23f1 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -78,6 +78,10 @@ enum {
 	NFIT_ARS_TIMEOUT = 90,
 };
 
+enum nfit_root_notifiers {
+	NFIT_NOTIFY_UPDATE = 0x80,
+};
+
 struct nfit_spa {
 	struct list_head list;
 	struct nd_region *nd_region;
-- 
2.7.4
