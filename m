From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Bug Report - [Acer Aspire V5-122P] Unable to adjust screen brightness
Date: Fri, 23 May 2014 14:50:45 +0200
Message-ID: <537F4425.70205@redhat.com>
References: <CADNzsyM9qiWf_KV4uuNDnkcv7JvCSi00qHiNQTWfVN-pZtWqig@mail.gmail.com> <537BFF89.9010806@intel.com> <CADNzsyMn5viCQDc7HXqZiH92BYNp9TZAtMNbuQMAkZXy6hj0Dg@mail.gmail.com> <537C9DC5.5040408@intel.com> <CADNzsyO7gzhtng0WmKA9DGZAreEGVsbAJ+KGdgJu+9zr_LyR8g@mail.gmail.com> <537EA5B7.9050509@intel.com> <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080300060002030001030007"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24796 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbaEWMuw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 May 2014 08:50:52 -0400
In-Reply-To: <CADNzsyORVbpqUMsZmKzBn_=Ma99dbLhKo_bfw3bvOASLwTkLsA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lewis Toohey <lewis@toohey.co.uk>, Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------080300060002030001030007
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Lewis et all,

On 05/23/2014 02:07 PM, Lewis Toohey wrote:
> On 23 May 2014 02:34, Aaron Lu <aaron.lu@intel.com> wrote:
>> On 05/21/2014 09:02 PM, Lewis Toohey wrote:
>>> Hi Aaron
>>>
>>> I followed your instructions and can report some limited success. I
>>> have two interfaces listed in /sys/class/backlight namely:
>>>   acpi_video0  radeon_bl0
>>>
>>> max_brightness for acpi_video0 is 11. Echo-ing new values to
>>> brightness appears to have no effect.
>>>
>>> max_brightness for radeon_bl0 is 255. Echo-ing new values to
>>> brightness does adjust the screen brightness as you would expect.
>>>
>>> Results are the same on both battery and powered.
>>>
>>> I hope that is useful.
>>
>> I think Hans' patchset should solve your problem, can you please give it
>> a try? You will need to pass the video.use_native_backlight=1 to kernel
>> cmdline when testing, thanks.
>>
>> [PATCH resend 0/4] Make video.use_native_backlight=1 work properly with nouveau
>> http://www.spinics.net/lists/dri-devel/msg59941.html
>>
>> -Aaron
> 
> Aaron
> 
> Thank you for this. Unfortunately I am going to have to ask you for a
> bit of help here as I am now, officially, "out of my depth". I
> appreciate this is a pain as you will have to take time explaining it
> to me and I apologise for that.
> 
> I have figured out how to pass the kernel command line argument, this
> is not an issue.
> 
> I have located the patch you refer to here:
> https://bugzilla.redhat.com/attachment.cgi?id=894577
> (which I believe is correct) but I cannot figure out how to apply it.

That is not the right patch, you need a set of 2 patches. I've attached
them to this mail. Note please ignore the numbering starting at 6, these
are the 2 patches you need. You will need to build a Linux kernel with
these 2 patches applied, see your distributions documentation on how
to build a kernel from source.

I don't know which distro you are using, I've a Fedora kernel with this
patches included available here:

http://people.fedoraproject.org/~jwrdegoede/rhbz1093171/

Regards,

Hans

--------------080300060002030001030007
Content-Type: text/x-patch;
 name="0006-backlight-Add-backlight-device-un-registration-notif.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-backlight-Add-backlight-device-un-registration-notif.pa";
 filename*1="tch"

>From 6fbfb8e4474d01ab5b1dd7788534ee83a601926b Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 15 May 2014 14:36:04 +0200
Subject: [PATCH 6/8] backlight: Add backlight device (un)registration
 notification

Some firmware drivers, ie acpi-video want to get themselves out of the
way (in some cases) when their also is a raw backlight device available.

Due to module loading ordering being unknown, acpi-video cannot be certain
that the backlight_device_registered(BACKLIGHT_RAW) it does for this is
the final verdict wrt there being a BACKLIGHT_RAW device.

By adding notification acpi-video can listen for backlight devices showing
up after it has loaded, and unregister its backlight device if desired.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/video/backlight/backlight.c | 40 +++++++++++++++++++++++++++++++++++++
 include/linux/backlight.h           |  7 +++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index bd2172c..4280890 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -23,6 +23,7 @@
 
 static struct list_head backlight_dev_list;
 static struct mutex backlight_dev_list_mutex;
+static struct blocking_notifier_head backlight_notifier;
 
 static const char *const backlight_types[] = {
 	[BACKLIGHT_RAW] = "raw",
@@ -370,6 +371,9 @@ struct backlight_device *backlight_device_register(const char *name,
 	list_add(&new_bd->entry, &backlight_dev_list);
 	mutex_unlock(&backlight_dev_list_mutex);
 
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_REGISTERED, new_bd);
+
 	return new_bd;
 }
 EXPORT_SYMBOL(backlight_device_register);
@@ -413,6 +417,10 @@ void backlight_device_unregister(struct backlight_device *bd)
 		pmac_backlight = NULL;
 	mutex_unlock(&pmac_backlight_mutex);
 #endif
+
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_UNREGISTERED, bd);
+
 	mutex_lock(&bd->ops_lock);
 	bd->ops = NULL;
 	mutex_unlock(&bd->ops_lock);
@@ -438,6 +446,36 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 }
 
 /**
+ * backlight_register_notifier - get notified of backlight (un)registration
+ * @nb: notifier block with the notifier to call on backlight (un)registration
+ *
+ * @return 0 on success, otherwise a negative error code
+ *
+ * Register a notifier to get notified when backlight devices get registered
+ * or unregistered.
+ */
+int backlight_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_register_notifier);
+
+/**
+ * backlight_unregister_notifier - unregister a backlight notifier
+ * @nb: notifier block to unregister
+ *
+ * @return 0 on success, otherwise a negative error code
+ *
+ * Register a notifier to get notified when backlight devices get registered
+ * or unregistered.
+ */
+int backlight_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&backlight_notifier, nb);
+}
+EXPORT_SYMBOL(backlight_unregister_notifier);
+
+/**
  * devm_backlight_device_register - resource managed backlight_device_register()
  * @dev: the device to register
  * @name: the name of the device
@@ -544,6 +582,8 @@ static int __init backlight_class_init(void)
 	backlight_class->pm = &backlight_class_dev_pm_ops;
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
+	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
+
 	return 0;
 }
 
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7264742..adb14a8 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -40,6 +40,11 @@ enum backlight_type {
 	BACKLIGHT_TYPE_MAX,
 };
 
+enum backlight_notification {
+	BACKLIGHT_REGISTERED,
+	BACKLIGHT_UNREGISTERED,
+};
+
 struct backlight_device;
 struct fb_info;
 
@@ -133,6 +138,8 @@ extern void devm_backlight_device_unregister(struct device *dev,
 extern void backlight_force_update(struct backlight_device *bd,
 				   enum backlight_update_reason reason);
 extern bool backlight_device_registered(enum backlight_type type);
+extern int backlight_register_notifier(struct notifier_block *nb);
+extern int backlight_unregister_notifier(struct notifier_block *nb);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
1.9.0


--------------080300060002030001030007
Content-Type: text/x-patch;
 name="0007-acpi-video-Unregister-the-backlight-device-if-a-raw-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0007-acpi-video-Unregister-the-backlight-device-if-a-raw-.pa";
 filename*1="tch"

>From b865e1e6ef6e0abcc5b4084d854418ebf7cd7772 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 15 May 2014 15:50:20 +0200
Subject: [PATCH 7/8] acpi-video: Unregister the backlight device if a raw one
 shows up later

When video.use_native_backlight=1 and non intel gfx are in use, the raw
backlight device of the gfx driver will show up after acpi-video has done its
acpi_video_verify_backlight_support() check.

This causes video.use_native_backlight=1 to not have the desired result.

This patch fixes this by adding a backlight notifier and when a raw
backlight is registered or unregistered re-doing the
acpi_video_verify_backlight_support() check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index aee85c4..123f919 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -151,6 +151,7 @@ struct acpi_video_enumerated_device {
 struct acpi_video_bus {
 	struct acpi_device *device;
 	bool backlight_registered;
+	bool backlight_notifier_registered;
 	u8 dos_setting;
 	struct acpi_video_enumerated_device *attached_array;
 	u8 attached_count;
@@ -162,6 +163,7 @@ struct acpi_video_bus {
 	struct input_dev *input;
 	char phys[32];	/* for input device */
 	struct notifier_block pm_nb;
+	struct notifier_block backlight_nb;
 };
 
 struct acpi_video_device_flags {
@@ -1836,6 +1838,9 @@ static int acpi_video_bus_register_backlight(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev;
 
+	if (video->backlight_registered)
+		return 0;
+
 	if (!acpi_video_verify_backlight_support())
 		return 0;
 
@@ -1980,6 +1985,56 @@ static void acpi_video_bus_remove_notify_handler(struct acpi_video_bus *video)
 	video->input = NULL;
 }
 
+static int acpi_video_backlight_notify(struct notifier_block *nb,
+					unsigned long val, void *bd)
+{
+	struct backlight_device *backlight = bd;
+	struct acpi_video_bus *video;
+
+	/* acpi_video_verify_backlight_support only cares about raw devices */
+	if (backlight->props.type != BACKLIGHT_RAW)
+		return NOTIFY_DONE;
+
+	video = container_of(nb, struct acpi_video_bus, backlight_nb);
+
+	switch (val) {
+	case BACKLIGHT_REGISTERED:
+		if (!acpi_video_verify_backlight_support())
+			acpi_video_bus_unregister_backlight(video);
+		break;
+	case BACKLIGHT_UNREGISTERED:
+		acpi_video_bus_register_backlight(video);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int acpi_video_bus_add_backlight_notify_handler(
+						struct acpi_video_bus *video)
+{
+	int error;
+
+	video->backlight_nb.notifier_call = acpi_video_backlight_notify;
+	video->backlight_nb.priority = 0;
+	error = backlight_register_notifier(&video->backlight_nb);
+	if (error == 0)
+		video->backlight_notifier_registered = true;
+
+	return error;
+}
+
+static int acpi_video_bus_remove_backlight_notify_handler(
+						struct acpi_video_bus *video)
+{
+	if (!video->backlight_notifier_registered)
+		return 0;
+
+	video->backlight_notifier_registered = false;
+
+	return backlight_unregister_notifier(&video->backlight_nb);
+}
+
 static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 {
 	struct acpi_video_device *dev, *next;
@@ -2061,6 +2116,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 
 	acpi_video_bus_register_backlight(video);
 	acpi_video_bus_add_notify_handler(video);
+	acpi_video_bus_add_backlight_notify_handler(video);
 
 	return 0;
 
@@ -2084,6 +2140,7 @@ static int acpi_video_bus_remove(struct acpi_device *device)
 
 	video = acpi_driver_data(device);
 
+	acpi_video_bus_remove_backlight_notify_handler(video);
 	acpi_video_bus_remove_notify_handler(video);
 	acpi_video_bus_unregister_backlight(video);
 	acpi_video_bus_put_devices(video);
-- 
1.9.0


--------------080300060002030001030007--
