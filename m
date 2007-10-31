From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.6.24-rc1 regression] AC adapter state does not change after
 resume
Date: Wed, 31 Oct 2007 09:27:33 +0300
Message-ID: <47282055.2000409@gmail.com>
References: <200710302324.52822.arvidjaar@mail.ru> <47279D8C.5040708@gmail.com> <200710310709.06621.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060108090007090604040507"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:6757 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXJaG1j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Oct 2007 02:27:39 -0400
Received: by ug-out-1314.google.com with SMTP id z38so250605ugc
        for <linux-acpi@vger.kernel.org>; Tue, 30 Oct 2007 23:27:38 -0700 (PDT)
In-Reply-To: <200710310709.06621.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

This is a multi-part message in MIME format.
--------------060108090007090604040507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrey Borzenkov wrote:
> On Wednesday 31 October 2007, Alexey Starikovskiy wrote:
>> Andrey Borzenkov wrote:
>>> I suspect new ACPI AC adapter code but have to add some printk's to be
>>> sure.
>>>
>>> To reproduce - plug in AC cord, suspend, unplug, resume - kpowersave and
>>> sysfs still show AC adapter online. Or other way round.
>>>
>>> -andrey
>> Please check if this patch helps.
>>
> 
> It does not even compile :)
> 
> On serious note (after adding forward declaration) - patch half works. It does 
> make "online" return true value (which confirms that underlying ACPI works 
> correctly) but HAL still does not notice it.
> 
> The problem is, with power_supply interface HAL does not use polling, it 
> relies on CHANGE event. This event is apparently never generated if AC 
> adapter state changes on resume. So the obvious fix is to compare AC state 
> before and after suspend in ->resume function and generate synthetic CHANGE 
> event if something has changed.
> 
> This will also make superfluous polling redundant.
Ok, here. This one compiles :)

Regards,
Alex.

--------------060108090007090604040507
Content-Type: text/x-diff;
 name="update_ac_state_on_sysfs_read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="update_ac_state_on_sysfs_read.patch"

ACPI: AC: Update AC state on resume

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Check if AC state has changed across resume and notify userspace if so.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ac.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index e03de37..06308ff 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -54,6 +54,7 @@ extern void *acpi_unlock_ac_dir(struct proc_dir_entry *acpi_ac_dir);
 
 static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
+static int acpi_ac_resume(struct acpi_device *device);
 static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 
 const static struct acpi_device_id ac_device_ids[] = {
@@ -69,6 +70,7 @@ static struct acpi_driver acpi_ac_driver = {
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
+		.resume = acpi_ac_resume,
 		},
 };
 
@@ -294,6 +296,21 @@ static int acpi_ac_add(struct acpi_device *device)
 	return result;
 }
 
+static int acpi_ac_resume(struct acpi_device *device)
+{
+	struct acpi_ac *ac;
+	unsigned old_state;
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+	ac = acpi_driver_data(device);
+	old_state = ac->state;
+	if (acpi_ac_get_state(ac))
+		return 0;
+	if (old_state != ac->state)
+		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
+	return 0;
+}
+
 static int acpi_ac_remove(struct acpi_device *device, int type)
 {
 	acpi_status status = AE_OK;

--------------060108090007090604040507--
