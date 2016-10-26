From: <gregkh@linuxfoundation.org>
Subject: Patch "acpi, nfit: check for the correct event code in notifications" has been added to the 4.4-stable tree
Date: Wed, 26 Oct 2016 11:26:40 +0200
Message-ID: <147747400010364@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49721 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbcJZJ0c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2016 05:26:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: vishal.l.verma@intel.com, dan.j.williams@intel.com, gregkh@linuxfoundation.org, linda.knippers@hpe.com, linux-acpi@vger.kernel.org
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    acpi, nfit: check for the correct event code in notifications

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     acpi-nfit-check-for-the-correct-event-code-in-notifications.patch
and it can be found in the queue-4.4 subdirectory.

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
Cc: <stable@vger.kernel.org>
Cc: <linux-acpi@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Linda Knippers <linda.knippers@hpe.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit.c |    3 +++
 drivers/acpi/nfit.h |    4 ++++
 2 files changed, 7 insertions(+)

--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1806,6 +1806,9 @@ static void acpi_nfit_notify(struct acpi
 
 	dev_dbg(dev, "%s: event: %d\n", __func__, event);
 
+	if (event != NFIT_NOTIFY_UPDATE)
+		return;
+
 	device_lock(dev);
 	if (!dev->driver) {
 		/* dev->driver may be null if we're being removed */
--- a/drivers/acpi/nfit.h
+++ b/drivers/acpi/nfit.h
@@ -45,6 +45,10 @@ enum {
 	ND_BLK_DCR_LATCH = 2,
 };
 
+enum nfit_root_notifiers {
+	NFIT_NOTIFY_UPDATE = 0x80,
+};
+
 struct nfit_spa {
 	struct acpi_nfit_system_address *spa;
 	struct list_head list;


Patches currently in stable-queue which might be from vishal.l.verma@intel.com are

queue-4.4/acpi-nfit-check-for-the-correct-event-code-in-notifications.patch
