From: Len Brown <lenb@kernel.org>
Subject: [PATCH 49/70] PNP: whitespace/coding style fixes
Date: Fri, 20 Jun 2008 03:43:51 -0400
Message-ID: <10a23ce8fc9c024d8da95e2e3b0ffb524af6bfc5.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40470 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbYFTHou (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:50 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00DC246KZ2I2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:45 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

No functional change; just make a couple declarations
consistent with the rest of the file.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Rene Herman <rene.herman@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/interface.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 674e8ba..239923a 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -216,12 +216,12 @@ static ssize_t pnp_show_options(struct device *dmdev,
 				struct device_attribute *attr, char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	pnp_info_buffer_t *buffer;
 	struct pnp_option *independent = dev->independent;
 	struct pnp_option *dependent = dev->dependent;
 	int ret, dep = 1;
 
-	pnp_info_buffer_t *buffer = (pnp_info_buffer_t *)
-	    pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
 
@@ -248,17 +248,18 @@ static ssize_t pnp_show_current_resources(struct device *dmdev,
 					  char *buf)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	pnp_info_buffer_t *buffer;
 	struct pnp_resource *pnp_res;
 	struct resource *res;
 	int ret;
-	pnp_info_buffer_t *buffer;
 
 	if (!dev)
 		return -EINVAL;
 
-	buffer = (pnp_info_buffer_t *) pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
 	if (!buffer)
 		return -ENOMEM;
+
 	buffer->len = PAGE_SIZE;
 	buffer->buffer = buf;
 	buffer->curr = buffer->buffer;
@@ -295,9 +296,9 @@ static ssize_t pnp_show_current_resources(struct device *dmdev,
 	return ret;
 }
 
-static ssize_t
-pnp_set_current_resources(struct device *dmdev, struct device_attribute *attr,
-			  const char *ubuf, size_t count)
+static ssize_t pnp_set_current_resources(struct device *dmdev,
+					 struct device_attribute *attr,
+					 const char *ubuf, size_t count)
 {
 	struct pnp_dev *dev = to_pnp_dev(dmdev);
 	char *buf = (void *)ubuf;
-- 
1.5.6

