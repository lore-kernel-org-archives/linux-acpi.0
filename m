From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: patch for video.c driver
Date: Fri, 13 Mar 2009 10:08:12 +0800
Message-ID: <1236910092.2807.103.camel@rzhang-dt>
References: <20090312154741.GA1055@hygelac>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RwamavdvbR3ftzaneZzt"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:38069 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbZCMCHS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 12 Mar 2009 22:07:18 -0400
In-Reply-To: <20090312154741.GA1055@hygelac>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Terence Ripperda <tripperda@nvidia.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>


--=-RwamavdvbR3ftzaneZzt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cc linux-acpi mail list to get more comments. :)
the patch in the original email is also attached.

On Thu, 2009-03-12 at 23:47 +0800, Terence Ripperda wrote:
> Hello,
> 
> I work on the Linux driver team at nvidia and we've been working on improving
> our notebook support. One area that we're working on is improved hotkey
> support for display switching.
> 
> As you may know, notebooks tend to vary quite a bit in architecture. For the
> majority of notebooks, the current video.ko driver works great for routing
> hotkey events to userspace for higher level drivers to handle. But there are
> some notebooks that use different mechanisms to support hotkeys. For nvidia,
> this is via an NVIF ACPI extension (my understanding is that other vendors
> have similar extensions).

I saw NVIF method implemented on some laptops, but not one is using it.
so do you mean there will be a Nvidia platform specific driver using
NVIF for hotkeys?

> 
> NVIDIA would like to be able to support these extensions,

that's a good news. :)

> using the standard
> video.ko driver. To support this (in a neutral manner), our team has put
> together a patch to allow registration of generic ACPI methods to deliver
> events back to acpid.

I'm a little confused here.
First, NVIF is usually defined as a control method of an ACPI video bus
device. And this is why you want to support this in the generic ACPI
video driver, rather than a platform specific driver like the others,
right?
But I didn't see this piece of code(poking NVIF) in the patch below.
If you do this in another patch, please send the full patch set here. :)

>  The intent was to follow the same architecture that the
> video.ko driver already follows and to make the support generic enough for
> many different users. For example, above I mentioned that both NVIDIA and
> other vendors have ACPI extension methods, the support we're adding would be
> usable by all such vendors.

Makes sense, although the other vendors usually offers a platform
specific device rather than a platform specific control method.

> 
> The idea is that a higher level driver (for example, acpid) can request that a
> new method be enabled via the procfs interface to the video.ko driver.

If we need such an I/F, we'd better introduce a sysfs I/F rather than a
procfs one, because the ACPI procfs I/F is marked as deprecated and will
be removed sooner or later.

>  The
> video.ko driver would then register this method for incoming events.

But I see that only user space can register the customized method and
events, and ACPI video driver do nothing but sending the events to user
space again.
So my question is that, why would we need "﻿char method_name[5];" in
"﻿struct custom_method_data"?

>  Upon
> receiving these events, the video.ko would pass them on to the higher level
> drivers for processing.

the higher level drivers means user space here, right?

Thanks,
rui


--=-RwamavdvbR3ftzaneZzt
Content-Disposition: attachment; filename=video.c.3.patch
Content-Type: text/x-patch; name=video.c.3.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.28/drivers/acpi/video.c.orig	2009-03-06 08:40:07.000000000 -0600
+++ linux-2.6.28/drivers/acpi/video.c	2009-03-06 08:40:07.000000000 -0600
@@ -57,6 +57,7 @@
 #define ACPI_VIDEO_NOTIFY_DISPLAY_OFF		0x89
 
 #define MAX_NAME_LEN	20
+#define MAX_CUSTOM_METHODS		10
 
 #define ACPI_VIDEO_DISPLAY_CRT	1
 #define ACPI_VIDEO_DISPLAY_TV	2
@@ -132,9 +133,15 @@ struct acpi_video_enumerated_device {
 	struct acpi_video_device *bind_info;
 };
 
+struct custom_method_data {
+	char method_name[5]; 
+	u32  method_event_id;
+};
+
 struct acpi_video_bus {
 	struct acpi_device *device;
 	u8 dos_setting;
+	struct custom_method_data method_data[MAX_CUSTOM_METHODS];
 	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
 	struct acpi_video_bus_cap cap;
@@ -233,6 +240,15 @@ static struct file_operations acpi_video
 	.release = single_release,
 };
 
+static int acpi_video_bus_custom_METHODS_open_fs(struct inode *inode,
+						 struct file *file);
+static struct file_operations acpi_video_bus_custom_METHODS_fops = {
+	.open = acpi_video_bus_custom_METHODS_open_fs,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 /* device */
 static int acpi_video_device_info_open_fs(struct inode *inode,
 					  struct file *file);
@@ -1291,6 +1307,24 @@ static int acpi_video_bus_DOS_seq_show(s
 	return 0;
 }
 
+static int acpi_video_bus_custom_METHODS_seq_show(struct seq_file *seq,
+						  void *offset)
+{
+	struct acpi_video_bus *video = seq->private;
+	int ctr = 0;
+
+	seq_printf(seq, "Custom methods:	Event-IDs\n");
+	for (ctr = 0; (video->method_data[ctr].method_name[0] != '\0') 
+			&& (ctr < MAX_CUSTOM_METHODS); ctr++) {
+		seq_printf(seq, "%s		0x%x\n", 
+			         video->method_data[ctr].method_name,
+			         video->method_data[ctr].method_event_id);
+	}
+
+	return 0;
+}
+
+
 static int acpi_video_bus_POST_open_fs(struct inode *inode, struct file *file)
 {
 	return single_open(file, acpi_video_bus_POST_seq_show,
@@ -1302,6 +1336,13 @@ static int acpi_video_bus_DOS_open_fs(st
 	return single_open(file, acpi_video_bus_DOS_seq_show, PDE(inode)->data);
 }
 
+static int acpi_video_bus_custom_METHODS_open_fs(struct inode *inode, 
+						 struct file *file)
+{
+	return single_open(file, acpi_video_bus_custom_METHODS_seq_show, 
+				 PDE(inode)->data);
+}
+
 static ssize_t
 acpi_video_bus_write_POST(struct file *file,
 			  const char __user * buffer,
@@ -1373,6 +1414,46 @@ acpi_video_bus_write_DOS(struct file *fi
 	return count;
 }
 
+static ssize_t
+acpi_video_bus_write_custom_METHODS(struct file *file,
+			 const char __user * buffer,
+			 size_t count, loff_t * data)
+{
+	struct seq_file *m = file->private_data;
+	struct acpi_video_bus *video = m->private;
+	char str[12] = { 0 };
+	int data_ctr = 0;
+	int ctr = 0;
+	
+
+	if (!video || count + 1 > sizeof(str))
+		return -EINVAL;
+
+	if (copy_from_user(str, buffer, count))
+		return -EFAULT;
+	
+	str[count] = 0;
+
+	while (video->method_data[ctr].method_name[0] != '\0') 
+		ctr++;
+
+	if (ctr+1 == MAX_CUSTOM_METHODS)
+		return -EFAULT;
+
+	while ((str[data_ctr] != '\0') && !(isspace(str[data_ctr])))
+		data_ctr++;
+
+	if (data_ctr > 4)
+		return -EFAULT;
+
+	strncpy(video->method_data[ctr].method_name, str, data_ctr);
+	video->method_data[ctr].method_name[data_ctr] = '\0';
+	video->method_data[ctr].method_event_id = strtoul(&str[data_ctr+1],
+							  NULL, 0);
+
+	return count;
+}
+
 static int acpi_video_bus_add_fs(struct acpi_device *device)
 {
 	struct acpi_video_bus *video = acpi_driver_data(device);
@@ -1424,9 +1505,20 @@ static int acpi_video_bus_add_fs(struct 
 	if (!entry)
 		goto err_remove_post;
 
+	/* 'custom_METHODS' [R/W] */
+	acpi_video_bus_custom_METHODS_fops.write = acpi_video_bus_write_custom_METHODS;
+	entry = proc_create_data("custom_METHODS", S_IFREG | S_IRUGO | S_IRUSR,
+				 device_dir,
+				 &acpi_video_bus_custom_METHODS_fops,
+				 acpi_driver_data(device));
+	if (!entry)
+		goto err_remove_dos;
+
 	video->dir = acpi_device_dir(device) = device_dir;
 	return 0;
 
+ err_remove_dos:
+	remove_proc_entry("DOS", device_dir);
  err_remove_post:
 	remove_proc_entry("POST", device_dir);
  err_remove_post_info:
@@ -1450,6 +1542,7 @@ static int acpi_video_bus_remove_fs(stru
 		remove_proc_entry("POST_info", device_dir);
 		remove_proc_entry("POST", device_dir);
 		remove_proc_entry("DOS", device_dir);
+		remove_proc_entry("custom_METHODS", device_dir);
 		remove_proc_entry(acpi_device_bid(device), acpi_video_dir);
 		acpi_device_dir(device) = NULL;
 	}
@@ -1836,6 +1929,8 @@ static void acpi_video_bus_notify(acpi_h
 	struct acpi_device *device = NULL;
 	struct input_dev *input;
 	int keycode;
+	int ctr = 0;
+	int custom_event = 0;
 
 	if (!video)
 		return;
@@ -1872,8 +1967,18 @@ static void acpi_video_bus_notify(acpi_h
 		break;
 
 	default:
+		while ((video->method_data[ctr].method_name[0] != '\0') &&
+				ctr < MAX_CUSTOM_METHODS) {  
+ 			if (event == video->method_data[ctr].method_event_id) { 
+				acpi_bus_generate_proc_event(device, event, 0);
+				custom_event = 1;
+				break;
+			}
+			ctr++;
+		}
 		keycode = KEY_UNKNOWN;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+		if (!custom_event)
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Unsupported event [0x%x]\n", event));
 		break;
 	}
@@ -1990,6 +2095,7 @@ static int acpi_video_bus_add(struct acp
 	video->device = device;
 	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	memset(video->method_data, 0, MAX_CUSTOM_METHODS * sizeof(struct custom_method_data));
 	device->driver_data = video;
 
 	acpi_video_bus_find_cap(video);

--=-RwamavdvbR3ftzaneZzt--

