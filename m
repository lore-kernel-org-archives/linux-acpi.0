From: <gregkh@linuxfoundation.org>
Subject: FAILED: patch "[PATCH] acpi, nfit: check for the correct event code in notifications" failed to apply to 4.4-stable tree
Date: Thu, 20 Oct 2016 17:52:28 +0200
Message-ID: <1476978748226120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: vishal.l.verma@intel.com, dan.j.williams@intel.com, linda.knippers@hpe.com, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


The patch below does not apply to the 4.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

>From c09f12186d6b03b798832d95289af76495990192 Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Fri, 19 Aug 2016 14:40:58 -0600
Subject: [PATCH] acpi, nfit: check for the correct event code in notifications

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
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 80cc7c089a15..4a363bed89b3 100644
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
index e894ded24d99..51d23f130d86 100644
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
