From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 13/16] platform/x86: wmi: Add an interface for subdrivers to access sibling devices
Date: Fri, 26 May 2017 22:31:27 -0700
Message-ID: <f366974b948a6d9dd720880e6b9989f88068336b.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdE0Fb7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 27 May 2017 01:31:59 -0400
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>

From: Andy Lutomirski <luto@kernel.org>

Some subdrivers need to access sibling devices. This gives them a
clean way to do so.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/wmi.c | 17 +++++++++++++++++
 include/linux/wmi.h        |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index f1c9464..8dd9988 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -344,6 +344,23 @@ union acpi_object *wmidev_block_query(struct wmi_device *wdev, u8 instance)
 }
 EXPORT_SYMBOL_GPL(wmidev_block_query);
 
+struct wmi_device *wmidev_get_other_guid(struct wmi_device *wdev,
+					 const char *guid_string)
+{
+	struct wmi_block *this_wb = container_of(wdev, struct wmi_block, dev);
+	struct wmi_block *other_wb;
+
+	if (!find_guid(guid_string, &other_wb))
+		return NULL;
+
+	if (other_wb->acpi_device != this_wb->acpi_device)
+		return NULL;
+
+	get_device(&other_wb->dev.dev);
+	return &other_wb->dev;
+}
+EXPORT_SYMBOL_GPL(wmidev_get_other_guid);
+
 /**
  * wmi_set_block - Write to a WMI block
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 0ab2540..a283768 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -33,6 +33,10 @@ struct wmi_device {
 extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 					     u8 instance);
 
+/* Gets another device on the same bus.  Caller must put_device the result. */
+extern struct wmi_device *wmidev_get_other_guid(struct wmi_device *wdev,
+						const char *guid_string);
+
 struct wmi_device_id {
 	const char *guid_string;
 };
-- 
2.9.4

