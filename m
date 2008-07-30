From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Fwd: Re: 2.6.27-rc1 oops on boot -- cs423x? (Corrected subject)
Date: Wed, 30 Jul 2008 08:39:18 -0600
Message-ID: <200807300839.18425.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:29859 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbYG3Ojf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2008 10:39:35 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org

Hi Andi,

Can you put the patch below in your acpi tree?  It fixes an issue
in 2.6.27-rc1 (URL below).  Thanks.

----------  Forwarded Message  ----------

Subject: Re: 2.6.27-rc1 oops on boot -- cs423x? (Corrected subject)
Date: Tuesday 29 July 2008
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Rene Herman <rene.herman@keyaccess.nl>

On Tuesday 29 July 2008 6:02:46 pm Rene Herman wrote:
> On 29-07-08 22:52, Pete Clements wrote:
> > [Previously sent with wrong subject line (2.6.26-rc1...) applicable
> > to post 2.6.26 series]
> >
> > Missed most of the 26-git series, git6 first one tried and oops
> > showed in that one as well as those tried after. oops below.
>
> http://marc.info/?l=linux-kernel&m=121736480005656&w=2
>
> For now just adding a CC as I'm off to bed. Note -- snd-cs4236 has been
> one of the most tested drivers with the new PNP code.

Thanks very much for the report.  Can I trouble you to test the
patch below and see whether it fixes the problem?



PNP: fix formatting of dbg_pnp_show_resources() output

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

Each resource should be printed on its own line, so start snprintf'ing
at the beginning of the buffer every time through the loop.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/support.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
index bbf78ef..57b775b 100644
--- a/drivers/pnp/support.c
+++ b/drivers/pnp/support.c
@@ -77,7 +77,7 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 {
 #ifdef DEBUG
 	char buf[128];
-	int len = 0;
+	int len;
 	struct pnp_resource *pnp_res;
 	struct resource *res;
 
@@ -89,6 +89,7 @@ void dbg_pnp_show_resources(struct pnp_dev *dev, char *desc)
 	dev_dbg(&dev->dev, "%s: current resources:\n", desc);
 	list_for_each_entry(pnp_res, &dev->resources, list) {
 		res = &pnp_res->res;
+		len = 0;
 
 		len += snprintf(buf + len, sizeof(buf) - len, "  %-3s ",
 				pnp_resource_type_name(res));

-------------------------------------------------------
