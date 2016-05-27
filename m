From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/3] ACPI / button: Remove initial lid state notification
Date: Fri, 27 May 2016 15:15:53 +0800
Message-ID: <8fac04a50e5853590b157a617ea9fddaa697db53.1464332745.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com> <cover.1464332745.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464332745.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The _LID control method's initial returning value is not reliable.

The _LID control method is described to return the "current" lid state.
However the word of "current" has ambiguity, many BIOSen return the lid
state upon the last lid notification instead of returning the lid state
upon the last _LID evaluation. There won't be difference when the _LID
control method is evaluated during the runtime, the problem is its initial
returning value. When the BIOSen implement this control method with cached
value, the initial returning value is likely not reliable. There are simply
so many examples retuning "close" as initial lid state (Link 1), sending
this state to the userspace causes suspending right after booting/resuming.

Since the lid state is implemented by the BIOSen, the kernel lid driver has
no idea how it can be correct, this patch stops sending the initial lid
state to the userspace to try to avoid sending the wrong lid state to the
userspace to trigger such kind of wrong suspending. This actually reverts
the following commit introduced for fixing a novell bug (Link 2):
  Commit: 23de5d9ef2a4bbc4f733f58311bcb7cf6239c813
  Subject: ACPI: button: send initial lid state after add and resume

Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=89211
        https://bugzilla.kernel.org/show_bug.cgi?id=106151
        https://bugzilla.kernel.org/show_bug.cgi?id=106941
Link 2: https://bugzilla.novell.com/show_bug.cgi?id=326814
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 5c3b091..9863278 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -334,8 +334,6 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
-	if (button->type == ACPI_BUTTON_TYPE_LID)
-		return acpi_lid_send_state(device);
 	return 0;
 }
 #endif
@@ -416,7 +414,6 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
-		acpi_lid_send_state(device);
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
-- 
1.7.10
