From: akpm@linux-foundation.org
Subject: [patch (for 2.6.26?) 3/3] PNPACPI: use _CRS IRQ descriptor length for _SRS
Date: Mon, 09 Jun 2008 16:52:06 -0700
Message-ID: <200806092352.m59Nq6li015771@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38201 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754916AbYFIXxu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:53:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, Robert.Moore@intel.com, ThJaeger@gmail.com, ambx1@neo.rr.com, castet.matthieu@free.fr, shaohua.li@intel.com

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
Cc: Adam Belay <ambx1@neo.rr.com>
Cc: Matthieu Castet <castet.matthieu@free.fr>
Cc: Li Shaohua <shaohua.li@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Tom Jaeger <ThJaeger@gmail.com>
Cc: Robert Moore <Robert.Moore@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/pnp/pnpacpi/rsparser.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff -puN drivers/pnp/pnpacpi/rsparser.c~pnpacpi-use-_crs-irq-descriptor-length-for-_srs-v2 drivers/pnp/pnpacpi/rsparser.c
--- a/drivers/pnp/pnpacpi/rsparser.c~pnpacpi-use-_crs-irq-descriptor-length-for-_srs-v2
+++ a/drivers/pnp/pnpacpi/rsparser.c
@@ -755,6 +755,9 @@ static acpi_status pnpacpi_type_resource
 	if (pnpacpi_supported_resource(res)) {
 		(*resource)->type = res->type;
 		(*resource)->length = sizeof(struct acpi_resource);
+		if (res->type == ACPI_RESOURCE_TYPE_IRQ)
+			(*resource)->data.irq.descriptor_length =
+					res->data.irq.descriptor_length;
 		(*resource)++;
 	}
 
@@ -810,10 +813,12 @@ static void pnpacpi_encode_irq(struct pn
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
_
