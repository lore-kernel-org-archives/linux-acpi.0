From: Yu Luming <luming.yu@gmail.com>
Subject: [patch 2/6] Add display output class support
Date: Thu, 2 Nov 2006 13:14:24 +0000 (UTC)
Message-ID: <200611042113.56913.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:3823 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752820AbWKBNOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Nov 2006 08:14:14 -0500
Received: by nz-out-0102.google.com with SMTP id z3so97344nzf
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2006 05:14:14 -0800 (PST)
Date: Sat, 4 Nov 2006 21:13:56 +0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>, Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr, Richard Hughes <hughsient@gmail.com>


Add display output class support

signed-off-by =A0 Luming.yu@gmail.com
---
 drivers/video/output.c |  129 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
 include/linux/output.h |   42 +++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/drivers/video/output.c b/drivers/video/output.c
new file mode 100644
index 0000000..4142662
--- /dev/null
+++ b/drivers/video/output.c
@@ -0,0 +1,129 @@
+/*
+ *  output.c - Display output swither driver
+ *
+ *  Copyright (C) 2006 Luming Yu <luming.yu@gmail.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
+ *  the Free Software Foundation; either version 2 of the License, or =
(at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, bu=
t
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, write to the Free Software Foundation, =
Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/output.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+
+
+MODULE_DESCRIPTION("Display Output Switcher Lowlevel Control Abstracti=
on");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Luming Yu <luming.yu@intel.com>");
+
+static ssize_t video_output_show_state(struct class_device *dev,char *=
buf)
+{
+	ssize_t ret_size =3D 0;
+	struct output_device *od =3D to_output_device(dev);
+	if (od->props)
+		ret_size =3D sprintf(buf,"%.8x\n",od->props->get_status(od));
+	return ret_size;
+}
+
+static ssize_t video_output_store_state(struct class_device *dev,
+	const char *buf,size_t count)
+{
+	char *endp;
+	struct output_device *od =3D to_output_device(dev);
+	int request_state =3D simple_strtoul(buf,&endp,0);
+	size_t size =3D endp - buf;
+
+        if (*endp && isspace(*endp))
+                size++;
+        if (size !=3D count)
+                return -EINVAL;
+
+	if (od->props) {
+		od->request_state =3D request_state;
+		od->props->set_state(od);
+	}
+	return count;
+}
+
+static void video_output_class_release(struct class_device *dev)
+{
+        struct output_device *od =3D to_output_device(dev);
+        kfree(od);
+}
+
+static struct class_device_attribute video_output_attributes[] =3D {
+	__ATTR(state, 0644, video_output_show_state, video_output_store_state=
),
+	__ATTR_NULL,
+};
+
+static struct class video_output_class =3D {
+	.name =3D "video_output",
+	.release =3D video_output_class_release,
+	.class_dev_attrs =3D video_output_attributes,
+};
+
+struct output_device *video_output_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct output_properties *op)
+{
+	struct output_device *new_dev;
+	int ret_code =3D 0;
+
+	new_dev =3D kzalloc(sizeof(struct output_device),GFP_KERNEL);
+	if (!new_dev) {
+		ret_code =3D -ENOMEM;
+		goto error_return;
+	}
+	new_dev->props =3D op;
+	new_dev->class_dev.class =3D &video_output_class;
+	new_dev->class_dev.dev =3D dev;
+	strlcpy(new_dev->class_dev.class_id,name,KOBJ_NAME_LEN);
+	class_set_devdata(&new_dev->class_dev,devdata);
+	ret_code =3D class_device_register(&new_dev->class_dev);
+	if (ret_code) {
+		kfree(new_dev);
+		goto error_return;
+	}
+	return new_dev;
+
+error_return:
+	return ERR_PTR(ret_code);
+}
+EXPORT_SYMBOL(video_output_register);
+
+void video_output_unregister(struct output_device *dev)
+{
+	if (!dev)
+		return;
+	class_device_unregister(&dev->class_dev);
+}
+EXPORT_SYMBOL(video_output_unregister);
+
+static void __exit video_output_class_exit(void)
+{
+	class_unregister(&video_output_class);
+}
+
+static int __init video_output_class_init(void)
+{
+	return class_register(&video_output_class);
+}
+
+postcore_initcall(video_output_class_init);
+module_exit(video_output_class_exit);
diff --git a/include/linux/output.h b/include/linux/output.h
new file mode 100644
index 0000000..6fc47f5
--- /dev/null
+++ b/include/linux/output.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  Copyright (C) 2006 Luming Yu <luming.yu@gmail.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License as published =
by
+ *  the Free Software Foundation; either version 2 of the License, or =
(at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, bu=
t
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, write to the Free Software Foundation, =
Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
+ */
+#ifndef _LINUX_OUTPUT_H
+#define _LINUX_OUTPUT_H
+#include <linux/device.h>
+struct output_device;
+struct output_properties {
+	int (*set_state)(struct output_device *);
+	int (*get_status)(struct output_device *);
+};
+struct output_device {
+	int request_state;
+	struct output_properties *props;
+	struct class_device class_dev;
+};
+#define to_output_device(obj) container_of(obj, struct output_device, =
class_dev)
+struct output_device *video_output_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct output_properties *op);
+void video_output_unregister(struct output_device *dev);
+#endif
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
