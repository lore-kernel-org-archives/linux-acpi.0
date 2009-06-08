From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/4] eeepc-laptop: Fix cpufv
Date: Mon,  8 Jun 2009 10:16:48 +0200
Message-ID: <1244449010-7995-3-git-send-email-corentincj@iksaif.net>
References: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
 <1244449010-7995-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:52388 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbZFHIYV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 04:24:21 -0400
In-Reply-To: <1244449010-7995-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Limit cpufv input to acceptable values.
Make cpufv output more readable.

According to the dsdt, the value returned by CFVG
is composed by the current setting in the first byte
and the number of settings (starting from 0) in the
second byte.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   58 ++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index a0845b2..ae1fb7b 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -395,7 +395,63 @@ static ssize_t show_sys_acpi(int cm, char *buf)
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
+static ssize_t show_cpufv(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct eeepc_cpufv c;
+	int i;
+	ssize_t len = 0;
+
+	if (get_cpufv(&c))
+		return sprintf(buf, "<unsupported>\n");
+	for (i = 0; i < c.num; i++)
+		len += sprintf(buf + len, i == c.cur ? "[%d] " : "%d ", i);
+	len += sprintf(buf + len, "\n");
+	return len;
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
 
 static struct attribute *platform_attributes[] = {
 	&dev_attr_camera.attr,
-- 
1.6.3.1

