From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] X86 platform: hp-wmi Better match the HP WMI query interface
Date: Fri, 21 May 2010 16:42:40 +0200
Message-ID: <1274452960-21873-1-git-send-email-trenn@suse.de>
References: <1274451495-10252-8-git-send-email-trenn@suse.de>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1274451495-10252-8-git-send-email-trenn@suse.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: mjg@redhat.com
Cc: platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>
List-Id: linux-acpi@vger.kernel.org

- Improve error handling, by explictly return zero for success, error otherwise
- WMI query command can have arbitrary input sized params
- WMI query command can have specific output sized params (0, 4, 128,..) byte

I like to go on here, but this is a rather intrusive change that should
be looked at first. I am sure the one or other thing can be done better or
there might be typo/bug somewhere.

This did not get any testing yet, only compile tested.

Next steps could be:
  - Eventually introduce hp_wmi_perform_{read,write}_query macros
  - Introduce new wireless query interface (0x1B)
  - more

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: mjg@redhat.com
CC: linux-acpi@vger.kernel.org
CC: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/hp-wmi.c |  137 ++++++++++++++++++++++++++++++++---------
 1 files changed, 107 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
index 0ba7015..5d79c3f 100644
--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -80,13 +80,12 @@ struct bios_args {
 	u32 command;
 	u32 commandtype;
 	u32 datasize;
-	u32 data;
+	char *data;
 };
 
 struct bios_return {
 	u32 sigpass;
 	u32 return_code;
-	u32 value;
 };
 
 struct key_entry {
@@ -131,7 +130,27 @@ static struct platform_driver hp_wmi_driver = {
 	.remove = hp_wmi_bios_remove,
 };
 
-static int hp_wmi_perform_query(int query, int write, int value)
+/*
+ * hp_wmi_perform_query
+ *
+ * query:	The commandtype -> What should be queried
+ * write:	The command -> 0 read, 1 write, 3 ODM specific
+ * buffer:	Buffer used as input and/or output
+ * buffersize:	Size of buffer
+ *
+ * returns zero on success
+ *         an HP WMI query specific error code (which is positive)
+ *         -EINVAL if the query was not successful at all
+ *         -EINVAL if the output buffer size exceeds buffersize
+ *
+ * Note: The buffersize must at least be the maximum of the input and output
+ *       size. E.g. Battery info query (0x7) is defined to have 1 byte input
+ *       and 128 byte output. The caller would do:
+ *       buffer = kzalloc(128, GFP_KERNEL);
+ *       ret = hp_wmi_perform_query(0x7, 0, buffer, 128)
+ */
+static int hp_wmi_perform_query(int query, int write, char *buffer,
+				int buffersize)
 {
 	struct bios_return bios_return;
 	acpi_status status;
@@ -140,8 +159,8 @@ static int hp_wmi_perform_query(int query, int write, int value)
 		.signature = 0x55434553,
 		.command = write ? 0x2 : 0x1,
 		.commandtype = query,
-		.datasize = write ? 0x4 : 0,
-		.data = value,
+		.datasize = buffersize,
+		.data = buffer,
 	};
 	struct acpi_buffer input = { sizeof(struct bios_args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -158,54 +177,90 @@ static int hp_wmi_perform_query(int query, int write, int value)
 	}
 
 	bios_return = *((struct bios_return *)obj->buffer.pointer);
+
+	if (bios_return.return_code) {
+		printk(KERN_WARNING PREFIX "Query %d returned %d\n", query,
+		       bios_return.return_code);
+		kfree(obj);
+		return bios_return.return_code;
+	}
+	if (obj->buffer.length - sizeof(bios_return) > buffersize) {
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	memset(buffer, 0, buffersize);
+	memcpy(buffer,
+	       ((char *)obj->buffer.pointer) + sizeof(struct bios_return),
+	       obj->buffer.length - sizeof(bios_return));
 	kfree(obj);
-	if (bios_return.return_code > 0)
-		return bios_return.return_code * -1;
-	else
-		return bios_return.value;
+	return 0;
 }
 
 static int hp_wmi_display_state(void)
 {
-	return hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, 0, 0);
+	int state;
+	int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, 0, (char *)&state,
+				       sizeof(state));
+	if (ret)
+		return -EINVAL;
+	return state;
 }
 
 static int hp_wmi_hddtemp_state(void)
 {
-	return hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, 0, 0);
+	int state;
+	int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, 0, (char *)&state,
+				       sizeof(state));
+	if (ret)
+		return -EINVAL;
+	return state;
 }
 
 static int hp_wmi_als_state(void)
 {
-	return hp_wmi_perform_query(HPWMI_ALS_QUERY, 0, 0);
+	int state;
+	int ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, 0, (char *)&state,
+				       sizeof(state));
+	if (ret)
+		return -EINVAL;
+	return state;
 }
 
 static int hp_wmi_dock_state(void)
 {
-	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, 0, 0);
+	int state;
+	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, 0, (char *)&state,
+				       sizeof(state));
 
-	if (ret < 0)
-		return ret;
+	if (ret)
+		return -EINVAL;
 
-	return ret & 0x1;
+	return state & 0x1;
 }
 
 static int hp_wmi_tablet_state(void)
 {
-	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, 0, 0);
-
-	if (ret < 0)
+	int state;
+	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, 0, (char *)&state,
+				       sizeof(state));
+	if (ret)
 		return ret;
 
-	return (ret & 0x4) ? 1 : 0;
+	return (state & 0x4) ? 1 : 0;
 }
 
 static int hp_wmi_set_block(void *data, bool blocked)
 {
 	enum hp_wmi_radio r = (enum hp_wmi_radio) data;
 	int query = BIT(r + 8) | ((!blocked) << r);
+	int ret;
 
-	return hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 1, query);
+	ret = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 1,
+				   (char *)&query, sizeof(query));
+	if (ret)
+		return -EINVAL;
+	return 0;
 }
 
 static const struct rfkill_ops hp_wmi_rfkill_ops = {
@@ -214,8 +269,13 @@ static const struct rfkill_ops hp_wmi_rfkill_ops = {
 
 static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
 {
-	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
-	int mask = 0x200 << (r * 8);
+	int wireless;
+	int mask;
+	hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0,
+			     (char *)&wireless, sizeof(wireless));
+	/* TBD: Pass error */
+
+	mask = 0x200 << (r * 8);
 
 	if (wireless & mask)
 		return false;
@@ -225,8 +285,13 @@ static bool hp_wmi_get_sw_state(enum hp_wmi_radio r)
 
 static bool hp_wmi_get_hw_state(enum hp_wmi_radio r)
 {
-	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
-	int mask = 0x800 << (r * 8);
+	int wireless;
+	int mask;
+	hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0,
+			     (char *)&wireless, sizeof(wireless));
+	/* TBD: Pass error */
+
+	mask = 0x800 << (r * 8);
 
 	if (wireless & mask)
 		return false;
@@ -283,7 +348,11 @@ static ssize_t set_als(struct device *dev, struct device_attribute *attr,
 		       const char *buf, size_t count)
 {
 	u32 tmp = simple_strtoul(buf, NULL, 10);
-	hp_wmi_perform_query(HPWMI_ALS_QUERY, 1, tmp);
+	int ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, 1, (char *)&tmp,
+				       sizeof(tmp));
+	if (ret)
+		return -EINVAL;
+
 	return count;
 }
 
@@ -353,7 +422,7 @@ static void hp_wmi_notify(u32 value, void *context)
 	static struct key_entry *key;
 	union acpi_object *obj;
 	u32 event_id, event_data;
-	int key_code;
+	int key_code, ret;
 	u32 *location;
 	acpi_status status;
 
@@ -407,8 +476,11 @@ static void hp_wmi_notify(u32 value, void *context)
 		printk(KERN_INFO PREFIX UNIMP "Smart adapter event detected\n");
 		break;
 	case HPWMI_BEZEL_BUTTON:
-		key_code = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
-						 0);
+		ret = hp_wmi_perform_query(HPWMI_HOTKEY_QUERY, 0,
+					   (char *)&key_code,
+					   sizeof(key_code));
+		if (ret)
+			break;
 		key = hp_wmi_get_entry_by_scancode(key_code);
 		if (key) {
 			switch (key->type) {
@@ -507,7 +579,12 @@ static void cleanup_sysfs(struct platform_device *device)
 static int __devinit hp_wmi_bios_setup(struct platform_device *device)
 {
 	int err;
-	int wireless = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, 0);
+	int wireless;
+
+	err = hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, 0, (char *)&wireless,
+				   sizeof(wireless));
+	if (err)
+		return err;
 
 	err = device_create_file(&device->dev, &dev_attr_display);
 	if (err)
-- 
1.6.3

