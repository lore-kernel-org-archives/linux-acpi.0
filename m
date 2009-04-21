From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] pnp: add PNP resource range checking function
Date: Tue, 21 Apr 2009 09:55:30 -0600
Message-ID: <200904210955.32105.bjorn.helgaas@hp.com>
References: <20090414124618.0dd9f536@hobbes> <200904141653.11884.bjorn.helgaas@hp.com> <20090414155505.0c2b619f@hobbes>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:36151 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbZDUPzg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Apr 2009 11:55:36 -0400
In-Reply-To: <20090414155505.0c2b619f@hobbes>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

On Tuesday 14 April 2009 04:55:05 pm Jesse Barnes wrote:
> On Tue, 14 Apr 2009 16:53:11 -0600
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > On Tuesday 14 April 2009 01:46:18 pm Jesse Barnes wrote:
> > > This patch adds a new export from the ACPI PNP core,
> > > is_acpi_pnp_reserved, which is intended for use by drivers to check
> > > whether a given range is already reserved (and therefore likely
> > > safe to use) or not (indicating that new resource space should
> > > probably be allocated).
> > 
> > This doesn't really need to be ACPI-specific, does it?  And can't
> > you use the pre-parsed resources in pnp_dev->resources?  And wouldn't
> > you just look at all resources for all PNP devices, not just the
> > PNP0C01/2 ones?
> > 
> > Sorry I don't have time to code up an example right now; maybe next
> > week, though, if you remind me :-)
> 
> Sure, that all sounds reasonable...  I'll try to remind you.  :)

Here's the sort of thing I was thinking (untested).

---
 drivers/pnp/resource.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index f604061..6665562 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -638,6 +638,23 @@ int pnp_possible_config(struct pnp_dev *dev, int type, resource_size_t start,
 }
 EXPORT_SYMBOL(pnp_possible_config);
 
+int pnp_range_reserved(resource_size_t start, resource_size_t end)
+{
+	struct pnp_dev *dev;
+	struct pnp_resource *pnp_res;
+	resource_size_t *dev_start, *dev_end;
+
+	pnp_for_each_dev(dev) {
+		list_for_each_entry(pnp_res, &dev->resources, list) {
+			dev_start = &pnp_res->res.start;
+			dev_end   = &pnp_res->res.end;
+			if (ranged_conflict(&start, &end, dev_start, dev_end))
+				return 1;
+		}
+	}
+	return 0;
+}
+
 /* format is: pnp_reserve_irq=irq1[,irq2] .... */
 static int __init pnp_setup_reserve_irq(char *str)
 {
