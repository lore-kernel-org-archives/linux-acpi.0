From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH] ISAPNP: don't unlock isapnp_cfg_mutex unless we've locked it
	first
Date: Tue, 02 Mar 2010 15:36:48 -0700
Message-ID: <20100302223648.7178.17333.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:43583 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0CBWgu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Mar 2010 17:36:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexander Strakh <strakh@ispras.ru>, Adam Belay <abelay@mit.edu>, Jaroslav Kysela <perex@perex.cz>


If isapnp_cfg_begin() fails, it returns without locking isapnp_cfg_mutex.
Previously, we always unlocked the mutex, even if we haven't locked it
first.

This patch checks the isapnp_cfg_begin() return value so we can just
exit and avoid this locking error.

Found by the Linux Device Drivers Verification Project and reported by
Alexander Strakh <strakh@ispras.ru>.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pnp/isapnp/core.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)


diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index e851160..93e95ad 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -903,7 +903,10 @@ static int isapnp_get_resources(struct pnp_dev *dev)
 
 	pnp_dbg(&dev->dev, "get resources\n");
 	pnp_init_resources(dev);
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
+
 	dev->active = isapnp_read_byte(ISAPNP_CFG_ACTIVATE);
 	if (!dev->active)
 		goto __end;
@@ -937,10 +940,13 @@ __end:
 static int isapnp_set_resources(struct pnp_dev *dev)
 {
 	struct resource *res;
-	int tmp;
+	int tmp, ret;
 
 	pnp_dbg(&dev->dev, "set resources\n");
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
+
 	dev->active = 1;
 	for (tmp = 0; tmp < ISAPNP_MAX_PORT; tmp++) {
 		res = pnp_get_resource(dev, IORESOURCE_IO, tmp);
@@ -986,9 +992,13 @@ static int isapnp_set_resources(struct pnp_dev *dev)
 
 static int isapnp_disable_resources(struct pnp_dev *dev)
 {
+	int ret;
+
 	if (!dev->active)
 		return -EINVAL;
-	isapnp_cfg_begin(dev->card->number, dev->number);
+	ret = isapnp_cfg_begin(dev->card->number, dev->number);
+	if (ret)
+		return ret;
 	isapnp_deactivate(dev->number);
 	dev->active = 0;
 	isapnp_cfg_end();

