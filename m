From: <gregkh@linuxfoundation.org>
Subject: Patch "acpi, nfit: check for the correct event code in notifications" has been added to the 4.8-stable tree
Date: Thu, 20 Oct 2016 17:53:58 +0200
Message-ID: <147697883817697@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: vishal.l.verma@intel.com, dan.j.williams@intel.com, gregkh@linuxfoundation.org, linda.knippers@hpe.com, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    acpi, nfit: check for the correct event code in notifications

to the 4.8-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     acpi-nfit-check-for-the-correct-event-code-in-notifications.patch
and it can be found in the queue-4.8 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From c09f12186d6b03b798832d95289af76495990192 Mon Sep 17 00:00:00 2001
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Fri, 19 Aug 2016 14:40:58 -0600
Subject: acpi, nfit: check for the correct event code in notifications

From: Vishal Verma <vishal.l.verma@intel.com>

commit c09f12186d6b03b798832d95289af76495990192 upstream.

Commit 209851649dc4 "acpi: nfit: Add support for hot-add" added
support for _FIT notifications, but it neglected to verify the
notification event code matches the one in the ACPI spec for
"NFIT Update". Currently there is only one code in the spec, but
once additional codes are added, older kernels (without this fix)
will misbehave by assuming all event notifications are for an
NFIT Update.

Fixes: 209851649dc4 ("acpi: nfit: Add support for hot-add")
Cc: <linux-acpi@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Linda Knippers <linda.knippers@hpe.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    3 +++
 drivers/acpi/nfit/nfit.h |    4 ++++
 2 files changed, 7 insertions(+)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2689,6 +2689,9 @@ static void acpi_nfit_notify(struct acpi
 
 	dev_dbg(dev, "%s: event: %d\n", __func__, event);
 
+	if (event != NFIT_NOTIFY_UPDATE)
+		return;
+
 	device_lock(dev);
 	if (!dev->driver) {
 		/* dev->driver may be null if we're being removed */
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


Patches currently in stable-queue which might be from vishal.l.verma@intel.com are

queue-4.8/acpi-nfit-check-for-the-correct-event-code-in-notifications.patch
