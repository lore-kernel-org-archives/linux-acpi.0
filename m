From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/3] ACPI / button: Send "open" state after boot/resume
Date: Fri, 27 May 2016 15:16:05 +0800
Message-ID: <4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com> <cover.1464332745.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464332745.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Bastien Nocera:" <hadess@hadess.net>
List-Id: linux-acpi@vger.kernel.org

Linux userspace (systemd-logind) keeps on rechecking lid state when the
lid state is closed. If it failed to update the lid state to open after
boot/resume, the system suspending right after the boot/resume could be
resulted.
Graphics drivers also uses the lid notifications to implment
MODESET_ON_LID_OPEN option.

Before the situation is improved from the userspace and from the graphics
driver, simply send initial "open" lid state to avoid issues. After this is
improved from the userspace and from the graphics driver, Linux kernel
could simply revert this minimal commit.

Link 1: https://lkml.org/2016/3/7/460
Link 2: https://github.com/systemd/systemd/issues/2087
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: Bastien Nocera: <hadess@hadess.net>
---
 drivers/acpi/button.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e706e4b..6e77312 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -342,6 +342,8 @@ static int acpi_button_resume(struct device *dev)
 	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
+	if (button->type == ACPI_BUTTON_TYPE_LID)
+		return acpi_lid_notify_state(device, 1);
 	return 0;
 }
 #endif
@@ -422,6 +424,7 @@ static int acpi_button_add(struct acpi_device *device)
 	if (error)
 		goto err_remove_fs;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
+		(void)acpi_lid_notify_state(device, 1);
 		/*
 		 * This assumes there's only one lid device, or if there are
 		 * more we only care about the last one...
-- 
1.7.10
