From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V4 1/8] usb: convert port_owners type from void * to struct dev_state *
Date: Thu, 28 Jun 2012 15:31:35 +0800
Message-ID: <1340868702-1894-2-git-send-email-tianyu.lan@intel.com>
References: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:31769 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932433Ab2F1Hjm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2012 03:39:42 -0400
In-Reply-To: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, Lan Tianyu <tianyu.lan@intel.com>

This patch is to convert ort_owners type from void * to struct dev_state *
in order to make code more readable.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/usb/core/hub.c |   21 ++++++++++++---------
 drivers/usb/core/usb.h |    9 ++++++---
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 25a7422..4cc8dc9 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -81,7 +81,7 @@ struct usb_hub {
 	u8			indicator[USB_MAXCHILDREN];
 	struct delayed_work	leds;
 	struct delayed_work	init_work;
-	void			**port_owners;
+	struct dev_state	**port_owners;
 };
 
 static inline int hub_is_superspeed(struct usb_device *hdev)
@@ -1271,7 +1271,8 @@ static int hub_configure(struct usb_hub *hub,
 
 	hdev->children = kzalloc(hdev->maxchild *
 				sizeof(struct usb_device *), GFP_KERNEL);
-	hub->port_owners = kzalloc(hdev->maxchild * sizeof(void *), GFP_KERNEL);
+	hub->port_owners = kzalloc(hdev->maxchild * sizeof(struct dev_state *),
+				GFP_KERNEL);
 	if (!hdev->children || !hub->port_owners) {
 		ret = -ENOMEM;
 		goto fail;
@@ -1649,7 +1650,7 @@ hub_ioctl(struct usb_interface *intf, unsigned int code, void *user_data)
  * to one of these "claimed" ports, the program will "own" the device.
  */
 static int find_port_owner(struct usb_device *hdev, unsigned port1,
-		void ***ppowner)
+		struct dev_state ***ppowner)
 {
 	if (hdev->state == USB_STATE_NOTATTACHED)
 		return -ENODEV;
@@ -1664,10 +1665,11 @@ static int find_port_owner(struct usb_device *hdev, unsigned port1,
 }
 
 /* In the following three functions, the caller must hold hdev's lock */
-int usb_hub_claim_port(struct usb_device *hdev, unsigned port1, void *owner)
+int usb_hub_claim_port(struct usb_device *hdev, unsigned port1,
+		       struct dev_state *owner)
 {
 	int rc;
-	void **powner;
+	struct dev_state **powner;
 
 	rc = find_port_owner(hdev, port1, &powner);
 	if (rc)
@@ -1678,10 +1680,11 @@ int usb_hub_claim_port(struct usb_device *hdev, unsigned port1, void *owner)
 	return rc;
 }
 
-int usb_hub_release_port(struct usb_device *hdev, unsigned port1, void *owner)
+int usb_hub_release_port(struct usb_device *hdev, unsigned port1,
+			 struct dev_state *owner)
 {
 	int rc;
-	void **powner;
+	struct dev_state **powner;
 
 	rc = find_port_owner(hdev, port1, &powner);
 	if (rc)
@@ -1692,10 +1695,10 @@ int usb_hub_release_port(struct usb_device *hdev, unsigned port1, void *owner)
 	return rc;
 }
 
-void usb_hub_release_all_ports(struct usb_device *hdev, void *owner)
+void usb_hub_release_all_ports(struct usb_device *hdev, struct dev_state *owner)
 {
 	int n;
-	void **powner;
+	struct dev_state **powner;
 
 	n = find_port_owner(hdev, 1, &powner);
 	if (n == 0) {
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 5c5c538..67875a8 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -1,5 +1,7 @@
 #include <linux/pm.h>
 
+struct dev_state;
+
 /* Functions local to drivers/usb/core/ */
 
 extern int usb_create_sysfs_dev_files(struct usb_device *dev);
@@ -41,10 +43,11 @@ extern void usb_forced_unbind_intf(struct usb_interface *intf);
 extern void usb_rebind_intf(struct usb_interface *intf);
 
 extern int usb_hub_claim_port(struct usb_device *hdev, unsigned port,
-		void *owner);
+		struct dev_state *owner);
 extern int usb_hub_release_port(struct usb_device *hdev, unsigned port,
-		void *owner);
-extern void usb_hub_release_all_ports(struct usb_device *hdev, void *owner);
+		struct dev_state *owner);
+extern void usb_hub_release_all_ports(struct usb_device *hdev,
+		struct dev_state *owner);
 extern bool usb_device_is_owned(struct usb_device *udev);
 
 extern int  usb_hub_init(void);
-- 
1.7.6.rc2.8.g28eb

