From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/23] PNPACPI: use _CRS IRQ descriptor length for _SRS
Date: Wed, 11 Jun 2008 03:59:14 -0400
Message-ID: <710faf8ca29bb73b8877f562c46d0e816ae8ee05.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59179 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384AbYFKH7e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:34 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A006IEGK6UOSI@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:52:55 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

When configuring the resources of an ACPI device, we first evaluate _CRS
to get a template of resource descriptors, then fill in the specific
resource values we want, and finally evaluate _SRS to actually configure
the device.

Some resources have optional fields, so the size of encoded descriptors
varies depending on the specific values.  For example, IRQ descriptors can
be either two or three bytes long.  The third byte contains triggering
information and can be omitted if the IRQ is edge-triggered and active
high.

The BIOS often assumes that IRQ descriptors in the _SRS buffer use the
same format as those in the _CRS buffer, so this patch enforces that
constraint.

The "Start Dependent Function" descriptor also has an optional byte, but
we don't currently encode those descriptors, so I didn't do anything for
those.

I have tested this patch on a Toshiba Portege 4000.  Without the patch,
parport_pc claims the parallel port only if I use "pnpacpi=off".  This
patch makes it work with PNPACPI.

This is an extension of a patch by Tom Jaeger:
    http://bugzilla.kernel.org/show_bug.cgi?id=9487#c42

References:
    http://bugzilla.kernel.org/show_bug.cgi?id=5832 Enabling ACPI Plug and Play in kernels >2.6.9 kills Parallel support
    http://bugzilla.kernel.org/show_bug.cgi?id=9487 buggy firmware expects four-byte IRQ resource descriptor (was: Serial port disappears after Suspend on Toshiba R25)
    http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1d5b285da1893b90507b081664ac27f1a8a3dc5b related ACPICA fix

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/rsparser.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 8681ff6..46c791a 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -755,6 +755,9 @@ static acpi_status pnpacpi_type_resources(struct acpi_resource *res, void *data)
 	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
 		(*resource)->length = sizeof(struct acpi_resource);
+		if (res->type == ACPI_RESOURCE_TYPE_IRQ)
+			(*resource)->data.irq.descriptor_length =
+					res->data.irq.descriptor_length;
 		(*resource)++;
 	}
 
@@ -810,10 +813,12 @@ static void pnpacpi_encode_irq(struct pnp_dev *dev,
 	irq->interrupt_count = 1;
 	irq->interrupts[0] = p->start;
 
-	dev_dbg(&dev->dev, "  encode irq %d %s %s %s\n", (int) p->start,
+	dev_dbg(&dev->dev, "  encode irq %d %s %s %s (%d-byte descriptor)\n",
+		(int) p->start,
 		triggering == ACPI_LEVEL_SENSITIVE ? "level" : "edge",
 		polarity == ACPI_ACTIVE_LOW ? "low" : "high",
-		irq->sharable == ACPI_SHARED ? "shared" : "exclusive");
+		irq->sharable == ACPI_SHARED ? "shared" : "exclusive",
+		irq->descriptor_length);
 }
 
 static void pnpacpi_encode_ext_irq(struct pnp_dev *dev,
-- 
1.5.6.rc2.23.gea81e

