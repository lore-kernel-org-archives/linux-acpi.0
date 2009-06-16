From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 15/15] eeepc-laptop: cpufv updates
Date: Tue, 16 Jun 2009 21:28:56 +0200
Message-ID: <1245180536-28009-16-git-send-email-corentincj@iksaif.net>
References: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-2-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-3-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-4-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-5-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-6-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-7-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-8-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-9-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-10-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-11-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-12-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-13-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-14-git-send-email-corentincj@iksaif.net>
 <1245180536-28009-15-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60973 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754898AbZFPTb2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:28 -0400
In-Reply-To: <1245180536-28009-15-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Limit cpufv input to acceptables values.
Add an available_cpufv file to show available
presets.
Change cpufv ouput format from %d to %#x, it won't
break compatibility with existing userspace tools, but
it provide a more human readable output.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   77 ++++++++++++++++++++++++++++++++++-
 1 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index deb103c..86f9f80 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -436,13 +436,88 @@ static ssize_t show_sys_acpi(int cm, char *buf)
 EEEPC_CREATE_DEVICE_ATTR(camera, CM_ASL_CAMERA);
 EEEPC_CREATE_DEVICE_ATTR(cardr, CM_ASL_CARDREADER);
 EEEPC_CREATE_DEVICE_ATTR(disp, CM_ASL_DISPLAYSWITCH);
-EEEPC_CREATE_DEVICE_ATTR(cpufv, CM_ASL_CPUFV);
+
+struct eeepc_cpufv {
+	int num;
+	int cur;
+};
+
+static int get_cpufv(struct eeepc_cpufv *c)
+{
+	c->cur = get_acpi(CM_ASL_CPUFV);
+	c->num = (c->cur >> 8) & 0xff;
+	c->cur &= 0xff;
+	if (c->cur < 0 || c->num <= 0 || c->num > 12)
+		return -ENODEV;
+	return 0;
+}
+
+static ssize_t show_available_cpufv(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct eeepc_cpufv c;
+	int i;
+	ssize_t len = 0;
+
+	if (get_cpufv(&c))
+		return -ENODEV;
+	for (i = 0; i < c.num; i++)
+		len += sprintf(buf + len, "%d ", i);
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+
+static ssize_t show_cpufv(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct eeepc_cpufv c;
+
+	if (get_cpufv(&c))
+		return -ENODEV;
+	return sprintf(buf, "%#x\n", (c.num << 8) | c.cur);
+}
+
+static ssize_t store_cpufv(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct eeepc_cpufv c;
+	int rv, value;
+
+	if (get_cpufv(&c))
+		return -ENODEV;
+	rv = parse_arg(buf, count, &value);
+	if (rv < 0)
+		return rv;
+	if (!rv || value < 0 || value >= c.num)
+		return -EINVAL;
+	set_acpi(CM_ASL_CPUFV, value);
+	return rv;
+}
+
+static struct device_attribute dev_attr_cpufv = {
+	.attr = {
+		.name = "cpufv",
+		.mode = 0644 },
+	.show   = show_cpufv,
+	.store  = store_cpufv
+};
+
+static struct device_attribute dev_attr_available_cpufv = {
+	.attr = {
+		.name = "available_cpufv",
+		.mode = 0444 },
+	.show   = show_available_cpufv
+};
 
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
 	&dev_attr_cardr.attr,
 	&dev_attr_disp.attr,
 	&dev_attr_cpufv.attr,
+	&dev_attr_available_cpufv.attr,
 	NULL
 };
 
-- 
1.6.3.1

