From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 2/2] eeepc-laptop: make libsensors work
Date: Sat, 12 Jul 2008 12:05:19 +0200
Message-ID: <200807121205.19533.corentincj@iksaif.net>
References: <200807121159.03034.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:39960 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbYGLKFl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2008 06:05:41 -0400
In-Reply-To: <200807121159.03034.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi4asus-user@lists.sourceforge.net
Cc: Len Brown <lenb@kernel.org>, eeecommunity-donated@lists.sourceforge.net, linux-acpi@vger.kernel.org

From: Alexandre d'Alton <alex@alexdalton.org>

Creates a name file in the sysfs directory, that
seems to be needed for the libsensors library to work.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 eeepc-laptop.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/misc/eeepc-laptop.c	2008-07-10 13:53:00.000000000 +0200
+++ b/drivers/misc/eeepc-laptop.c	2008-07-10 12:14:46.000000000 +0200
@@ -527,10 +527,18 @@
 EEEPC_CREATE_SENSOR_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
 			 eeepc_get_fan_ctrl, eeepc_set_fan_ctrl);
 
+static ssize_t
+show_name(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "fan\n");
+}
+static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
 static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_fan1_pwm.dev_attr.attr,
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
+	&sensor_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
