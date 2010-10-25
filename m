From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/60] ACPI/PNP: A HID value of an object never changes -> make
 it const
Date: Mon, 25 Oct 2010 02:20:27 -0400
Message-ID: <620e112cfe1c9281c176de8ad1a7691c4eb4950d.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50545 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0JYHLV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:21 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:14 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c      |    4 ++--
 drivers/acpi/scan.c        |    5 ++---
 drivers/pnp/base.h         |    5 +++--
 drivers/pnp/core.c         |    3 ++-
 drivers/pnp/driver.c       |    2 +-
 drivers/pnp/pnpacpi/core.c |    2 +-
 include/acpi/acpi_bus.h    |    2 +-
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 1575a9b..71ef9cd 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -338,7 +338,8 @@ static int acpi_button_add(struct acpi_device *device)
 {
 	struct acpi_button *button;
 	struct input_dev *input;
-	char *hid, *name, *class;
+	const char *hid = acpi_device_hid(device);
+	char *name, *class;
 	int error;
 
 	button = kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
@@ -353,7 +354,6 @@ static int acpi_button_add(struct acpi_device *device)
 		goto err_free_button;
 	}
 
-	hid = acpi_device_hid(device);
 	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 81aec8d..6155eeb 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -26,8 +26,7 @@ extern struct acpi_device *acpi_root;
 
 #define ACPI_IS_ROOT_DEVICE(device)    (!(device)->parent)
 
-/* Should be const */
-static char* dummy_hid = "device";
+static const char *dummy_hid = "device";
 
 static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
@@ -1021,7 +1020,7 @@ static int acpi_dock_match(struct acpi_device *device)
 	return acpi_get_handle(device->handle, "_DCK", &tmp);
 }
 
-char *acpi_device_hid(struct acpi_device *device)
+const char *acpi_device_hid(struct acpi_device *device)
 {
 	struct acpi_hardware_id *hid;
 
diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index 0bab84e..19bc736 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -12,11 +12,12 @@ void pnp_unregister_protocol(struct pnp_protocol *protocol);
 
 #define PNP_EISA_ID_MASK 0x7fffffff
 void pnp_eisa_id_to_string(u32 id, char *str);
-struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id, char *pnpid);
+struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id,
+			      const char *pnpid);
 struct pnp_card *pnp_alloc_card(struct pnp_protocol *, int id, char *pnpid);
 
 int pnp_add_device(struct pnp_dev *dev);
-struct pnp_id *pnp_add_id(struct pnp_dev *dev, char *id);
+struct pnp_id *pnp_add_id(struct pnp_dev *dev, const char *id);
 
 int pnp_add_card(struct pnp_card *card);
 void pnp_remove_card(struct pnp_card *card);
diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index 88b3cde..c79ee1d 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -124,7 +124,8 @@ static void pnp_release_device(struct device *dmdev)
 	kfree(dev);
 }
 
-struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id, char *pnpid)
+struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
+			      const char *pnpid)
 {
 	struct pnp_dev *dev;
 	struct pnp_id *dev_id;
diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
index cd11b11..d1dbb9d 100644
--- a/drivers/pnp/driver.c
+++ b/drivers/pnp/driver.c
@@ -236,7 +236,7 @@ void pnp_unregister_driver(struct pnp_driver *drv)
  * @dev: pointer to the desired device
  * @id: pointer to an EISA id string
  */
-struct pnp_id *pnp_add_id(struct pnp_dev *dev, char *id)
+struct pnp_id *pnp_add_id(struct pnp_dev *dev, const char *id)
 {
 	struct pnp_id *dev_id, *ptr;
 
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index dc4e32e..4aafcf8 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -59,7 +59,7 @@ static inline int __init is_exclusive_device(struct acpi_device *dev)
 #define TEST_ALPHA(c) \
 	if (!('@' <= (c) || (c) <= 'Z')) \
 		return 0
-static int __init ispnpidacpi(char *id)
+static int __init ispnpidacpi(const char *id)
 {
 	TEST_ALPHA(id[0]);
 	TEST_ALPHA(id[1]);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 4de84ce..a47bb90 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -184,7 +184,7 @@ struct acpi_device_pnp {
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)
 #define acpi_device_adr(d)	((d)->pnp.bus_address)
-char *acpi_device_hid(struct acpi_device *device);
+const char *acpi_device_hid(struct acpi_device *device);
 #define acpi_device_name(d)	((d)->pnp.device_name)
 #define acpi_device_class(d)	((d)->pnp.device_class)
 
-- 
1.7.3.2.90.gd4c43

