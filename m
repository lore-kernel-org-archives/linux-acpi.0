From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 090/112] acpi, nfit: check for the correct event code in notifications
Date: Wed, 26 Oct 2016 14:23:13 +0200
Message-ID: <20161026122308.573606581@linuxfoundation.org>
References: <20161026122304.797016625@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56029 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942287AbcJZMfC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2016 08:35:02 -0400
In-Reply-To: <20161026122304.797016625@linuxfoundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Linda Knippers <linda.knippers@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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


