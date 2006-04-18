From: mochel@linux.intel.com
Subject: [PATCH 11/24] Remove unneeded debugging macros in drivers/acpi/hotkey.c
Date: Mon, 17 Apr 2006 18:21:53 -0700
Message-ID: <11453233132210-git-send-email-mochel@linux.intel.com>
References: <11453233132362-git-send-email-mochel@linux.intel.com>
Reply-To: mochel@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr20.intel.com ([134.134.136.19]:25734 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932120AbWDRBZZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Apr 2006 21:25:25 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr005.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k3I1PP6X013968
	for <linux-acpi@vger.kernel.org>; Tue, 18 Apr 2006 01:25:25 GMT
In-Reply-To: <11453233132362-git-send-email-mochel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Patrick Mochel <mochel@linux.intel.com>

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/acpi/hotkey.c |  115 ++++++++++++++-----------------------------------
 1 files changed, 34 insertions(+), 81 deletions(-)

applies-to: 7b8aca2a44864c5cde93e035b223a5317e749232
8773774970d07b8f36e55150d58609de77a244c4
diff --git a/drivers/acpi/hotkey.c b/drivers/acpi/hotkey.c
index 37dcb1f..ed8a1ae 100644
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -231,11 +231,9 @@ struct list_head hotkey_entries;	/* head
 
 static int hotkey_info_seq_show(struct seq_file *seq, void *offset)
 {
-	ACPI_FUNCTION_TRACE("hotkey_info_seq_show");
-
 	seq_printf(seq, "Hotkey generic driver ver: %s\n", HOTKEY_ACPI_VERSION);
 
-	return_VALUE(0);
+	return 0;
 }
 
 static int hotkey_info_open_fs(struct inode *inode, struct file *file)
@@ -266,15 +264,13 @@ static int hotkey_polling_seq_show(struc
 	    (struct acpi_polling_hotkey *)seq->private;
 	char *buf;
 
-	ACPI_FUNCTION_TRACE("hotkey_polling_seq_show");
-
 	if (poll_hotkey->poll_result) {
 		buf = format_result(poll_hotkey->poll_result);
 		if (buf)
 			seq_printf(seq, "%s", buf);
 		kfree(buf);
 	}
-	return_VALUE(0);
+	return 0;
 }
 
 static int hotkey_polling_open_fs(struct inode *inode, struct file *file)
@@ -293,8 +289,6 @@ static int hotkey_get_internal_event(int
 	struct list_head *entries;
 	int val = -1;
 
-	ACPI_FUNCTION_TRACE("hotkey_get_internal_event");
-
 	list_for_each(entries, list->entries) {
 		union acpi_hotkey *key =
 		    container_of(entries, union acpi_hotkey, entries);
@@ -305,7 +299,7 @@ static int hotkey_get_internal_event(int
 		}
 	}
 
-	return_VALUE(val);
+	return val;
 }
 
 static void
@@ -314,15 +308,12 @@ acpi_hotkey_notify_handler(acpi_handle h
 	struct acpi_device *device = NULL;
 	u32 internal_event;
 
-	ACPI_FUNCTION_TRACE("acpi_hotkey_notify_handler");
-
 	if (acpi_bus_get_device(handle, &device))
-		return_VOID;
+		return;
 
 	internal_event = hotkey_get_internal_event(event, &global_hotkey_list);
 	acpi_bus_generate_event(device, internal_event, 0);
 
-	return_VOID;
 }
 
 /* Need to invent automatically hotkey add method */
@@ -344,10 +335,7 @@ static int create_polling_proc(union acp
 {
 	struct proc_dir_entry *proc;
 	char proc_name[80];
-	mode_t mode;
-
-	ACPI_FUNCTION_TRACE("create_polling_proc");
-	mode = S_IFREG | S_IRUGO | S_IWUGO;
+	mode_t mode = S_IFREG | S_IRUGO | S_IWUGO;
 
 	sprintf(proc_name, "%d", device->link.hotkey_standard_num);
 	/*
@@ -356,7 +344,7 @@ static int create_polling_proc(union acp
 	proc = create_proc_entry(proc_name, mode, hotkey_proc_dir);
 
 	if (!proc) {
-		return_VALUE(-ENODEV);
+		return -ENODEV;
 	} else {
 		proc->proc_fops = &hotkey_polling_fops;
 		proc->owner = THIS_MODULE;
@@ -365,7 +353,7 @@ static int create_polling_proc(union acp
 		proc->gid = 0;
 		device->poll_hotkey.proc = proc;
 	}
-	return_VALUE(0);
+	return 0;
 }
 
 static int hotkey_add(union acpi_hotkey *device)
@@ -373,8 +361,6 @@ static int hotkey_add(union acpi_hotkey 
 	int status = 0;
 	struct acpi_device *dev = NULL;
 
-	ACPI_FUNCTION_TRACE("hotkey_add");
-
 	if (device->link.hotkey_type == ACPI_HOTKEY_EVENT) {
 		acpi_bus_get_device(device->event_hotkey.bus_handle, &dev);
 		status = acpi_install_notify_handler(dev->handle,
@@ -388,15 +374,13 @@ static int hotkey_add(union acpi_hotkey 
 
 	list_add_tail(&device->link.entries, global_hotkey_list.entries);
 
-	return_VALUE(status);
+	return status;
 }
 
 static int hotkey_remove(union acpi_hotkey *device)
 {
 	struct list_head *entries, *next;
 
-	ACPI_FUNCTION_TRACE("hotkey_remove");
-
 	list_for_each_safe(entries, next, global_hotkey_list.entries) {
 		union acpi_hotkey *key =
 		    container_of(entries, union acpi_hotkey, entries);
@@ -409,15 +393,13 @@ static int hotkey_remove(union acpi_hotk
 		}
 	}
 	kfree(device);
-	return_VALUE(0);
+	return 0;
 }
 
 static int hotkey_update(union acpi_hotkey *key)
 {
 	struct list_head *entries;
 
-	ACPI_FUNCTION_TRACE("hotkey_update");
-
 	list_for_each(entries, global_hotkey_list.entries) {
 		union acpi_hotkey *tmp =
 		    container_of(entries, union acpi_hotkey, entries);
@@ -458,20 +440,18 @@ static int hotkey_update(union acpi_hotk
 				 */
 				kfree(key);
 			}
-			return_VALUE(0);
+			return 0;
 			break;
 		}
 	}
 
-	return_VALUE(-ENODEV);
+	return -ENODEV;
 }
 
 static void free_hotkey_device(union acpi_hotkey *key)
 {
 	struct acpi_device *dev;
 
-	ACPI_FUNCTION_TRACE("free_hotkey_device");
-
 	if (key->link.hotkey_type == ACPI_HOTKEY_EVENT) {
 		acpi_bus_get_device(key->event_hotkey.bus_handle, &dev);
 		if (dev->handle)
@@ -490,7 +470,6 @@ static void free_hotkey_device(union acp
 		free_poll_hotkey_buffer(key);
 	}
 	kfree(key);
-	return_VOID;
 }
 
 static void free_hotkey_buffer(union acpi_hotkey *key)
@@ -511,8 +490,6 @@ init_hotkey_device(union acpi_hotkey *ke
 	acpi_handle tmp_handle;
 	acpi_status status = AE_OK;
 
-	ACPI_FUNCTION_TRACE("init_hotkey_device");
-
 	if (std_num < 0 || IS_POLL(std_num) || !key)
 		goto do_fail;
 
@@ -538,9 +515,9 @@ init_hotkey_device(union acpi_hotkey *ke
 				 method, &tmp_handle);
 	if (ACPI_FAILURE(status))
 		goto do_fail;
-	return_VALUE(AE_OK);
+	return AE_OK;
       do_fail:
-	return_VALUE(-ENODEV);
+	return -ENODEV;
 }
 
 static int
@@ -552,8 +529,6 @@ init_poll_hotkey_device(union acpi_hotke
 	acpi_status status = AE_OK;
 	acpi_handle tmp_handle;
 
-	ACPI_FUNCTION_TRACE("init_poll_hotkey_device");
-
 	if (std_num < 0 || IS_EVENT(std_num) || !key)
 		goto do_fail;
 
@@ -587,23 +562,19 @@ init_poll_hotkey_device(union acpi_hotke
 	    (union acpi_object *)kmalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!key->poll_hotkey.poll_result)
 		goto do_fail;
-	return_VALUE(AE_OK);
+	return AE_OK;
       do_fail:
-	return_VALUE(-ENODEV);
+	return -ENODEV;
 }
 
 static int hotkey_open_config(struct inode *inode, struct file *file)
 {
-	ACPI_FUNCTION_TRACE("hotkey_open_config");
-	return_VALUE(single_open
-		     (file, hotkey_config_seq_show, PDE(inode)->data));
+	return single_open(file, hotkey_config_seq_show, PDE(inode)->data);
 }
 
 static int hotkey_poll_open_config(struct inode *inode, struct file *file)
 {
-	ACPI_FUNCTION_TRACE("hotkey_poll_open_config");
-	return_VALUE(single_open
-		     (file, hotkey_poll_config_seq_show, PDE(inode)->data));
+	return single_open(file, hotkey_poll_config_seq_show, PDE(inode)->data);
 }
 
 static int hotkey_config_seq_show(struct seq_file *seq, void *offset)
@@ -615,8 +586,6 @@ static int hotkey_config_seq_show(struct
 	struct acpi_buffer bus = { ACPI_PATHNAME_MAX, bus_name };
 	struct acpi_buffer act = { ACPI_PATHNAME_MAX, action_name };
 
-	ACPI_FUNCTION_TRACE(("hotkey_config_seq_show"));
-
 	list_for_each(entries, hotkey_list->entries) {
 		union acpi_hotkey *key =
 		    container_of(entries, union acpi_hotkey, entries);
@@ -633,7 +602,7 @@ static int hotkey_config_seq_show(struct
 		}
 	}
 	seq_puts(seq, "\n");
-	return_VALUE(0);
+	return 0;
 }
 
 static int hotkey_poll_config_seq_show(struct seq_file *seq, void *offset)
@@ -645,8 +614,6 @@ static int hotkey_poll_config_seq_show(s
 	struct acpi_buffer bus = { ACPI_PATHNAME_MAX, bus_name };
 	struct acpi_buffer act = { ACPI_PATHNAME_MAX, action_name };
 
-	ACPI_FUNCTION_TRACE(("hotkey_config_seq_show"));
-
 	list_for_each(entries, hotkey_list->entries) {
 		union acpi_hotkey *key =
 		    container_of(entries, union acpi_hotkey, entries);
@@ -663,7 +630,7 @@ static int hotkey_poll_config_seq_show(s
 		}
 	}
 	seq_puts(seq, "\n");
-	return_VALUE(0);
+	return 0;
 }
 
 static int
@@ -675,8 +642,6 @@ get_parms(char *config_record,
 	  char **method, int *internal_event_num, int *external_event_num)
 {
 	char *tmp, *tmp1, count;
-	ACPI_FUNCTION_TRACE(("get_parms"));
-
 	sscanf(config_record, "%d", cmd);
 
 	if (*cmd == 1) {
@@ -741,9 +706,9 @@ get_parms(char *config_record,
 	    0)
 		goto do_fail;
 
-	return_VALUE(6);
+	return 6;
       do_fail:
-	return_VALUE(-1);
+	return -1;
 }
 
 /*  count is length for one input record */
@@ -760,16 +725,14 @@ static ssize_t hotkey_write_config(struc
 	int ret = 0;
 	union acpi_hotkey *key = NULL;
 
-	ACPI_FUNCTION_TRACE(("hotkey_write_config"));
-
 	config_record = (char *)kmalloc(count + 1, GFP_KERNEL);
 	if (!config_record)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 
 	if (copy_from_user(config_record, buffer, count)) {
 		kfree(config_record);
 		ACPI_ERROR((AE_INFO, "Invalid data"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 	config_record[count] = 0;
 
@@ -790,7 +753,7 @@ static ssize_t hotkey_write_config(struc
 		kfree(action_handle);
 		kfree(method);
 		ACPI_ERROR((AE_INFO, "Invalid data format ret=%d", ret));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	key = kmalloc(sizeof(union acpi_hotkey), GFP_KERNEL);
@@ -825,7 +788,7 @@ static ssize_t hotkey_write_config(struc
 			free_poll_hotkey_buffer(key);
 		kfree(key);
 		ACPI_ERROR((AE_INFO, "Invalid hotkey"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
       cont_cmd:
@@ -851,7 +814,7 @@ static ssize_t hotkey_write_config(struc
 		goto fail_out;
 		break;
 	}
-	return_VALUE(count);
+	return count;
       fail_out:
 	if (IS_EVENT(internal_event_num))
 		free_hotkey_buffer(key);
@@ -859,7 +822,7 @@ static ssize_t hotkey_write_config(struc
 		free_poll_hotkey_buffer(key);
 	kfree(key);
 	ACPI_ERROR((AE_INFO, "invalid key"));
-	return_VALUE(-EINVAL);
+	return -EINVAL;
 }
 
 /*
@@ -876,15 +839,13 @@ static int write_acpi_int(acpi_handle ha
 	union acpi_object in_obj;	/* the only param we use */
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("write_acpi_int");
-	params.count = 1;
 	params.pointer = &in_obj;
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = val;
 
 	status = acpi_evaluate_object(handle, (char *)method, &params, output);
 
-	return_VALUE(status == AE_OK);
+	return status == AE_OK;
 }
 
 static int read_acpi_int(acpi_handle handle, const char *method,
@@ -894,8 +855,6 @@ static int read_acpi_int(acpi_handle han
 	union acpi_object out_obj;
 	acpi_status status;
 
-	ACPI_FUNCTION_TRACE("read_acpi_int");
-	output.length = sizeof(out_obj);
 	output.pointer = &out_obj;
 
 	status = acpi_evaluate_object(handle, (char *)method, NULL, &output);
@@ -941,24 +900,22 @@ static ssize_t hotkey_execute_aml_method
 	int event, method_type, type, value;
 	union acpi_hotkey *key;
 
-	ACPI_FUNCTION_TRACE("hotkey_execte_aml_method");
-
 	arg = (char *)kmalloc(count + 1, GFP_KERNEL);
 	if (!arg)
-		return_VALUE(-ENOMEM);
+		return -ENOMEM;
 	arg[count] = 0;
 
 	if (copy_from_user(arg, buffer, count)) {
 		kfree(arg);
 		ACPI_ERROR((AE_INFO, "Invalid argument 2"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (sscanf(arg, "%d:%d:%d:%d", &event, &method_type, &type, &value) !=
 	    4) {
 		kfree(arg);
 		ACPI_ERROR((AE_INFO, "Invalid argument 3"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
 	kfree(arg);
 	if (type == ACPI_TYPE_INTEGER) {
@@ -984,11 +941,11 @@ static ssize_t hotkey_execute_aml_method
 		}
 	} else {
 		ACPI_WARNING((AE_INFO, "Not supported"));
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 	}
-	return_VALUE(count);
+	return count;
       do_fail:
-	return_VALUE(-EINVAL);
+	return -EINVAL;
 
 }
 
@@ -997,8 +954,6 @@ static int __init hotkey_init(void)
 	int result;
 	mode_t mode = S_IFREG | S_IRUGO | S_IWUGO;
 
-	ACPI_FUNCTION_TRACE("hotkey_init");
-
 	if (acpi_disabled)
 		return -ENODEV;
 
@@ -1084,8 +1039,6 @@ static void __exit hotkey_exit(void)
 {
 	struct list_head *entries, *next;
 
-	ACPI_FUNCTION_TRACE("hotkey_exit");
-
 	list_for_each_safe(entries, next, global_hotkey_list.entries) {
 		union acpi_hotkey *key =
 		    container_of(entries, union acpi_hotkey, entries);
---
0.99.9.GIT


