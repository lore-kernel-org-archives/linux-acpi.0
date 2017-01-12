From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/2] ACPI / button: Change default behavior to lid_init_state=open
Date: Thu, 12 Jan 2017 15:47:34 +0800
Message-ID: <bff3bf44b249007e41f1922590b567eabb999021.1484206801.git.lv.zheng@intel.com>
References: <cover.1484206801.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41842 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbdALHri (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Jan 2017 02:47:38 -0500
In-Reply-To: <cover.1484206801.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

More and more platforms need the button.lid_init_state=open quirk. This
patch sets it the default behavior.

If a platform doesn't send lid open event or lid open event is lost due to
the underlying system problems, then we can compare various combinations:
1. systemd/acpid is used to suspend system or not, systemd has a special
   logic forcing open event after resuming;
2. _LID returns a cached value or not.

The result is as follows:
1. lid_init_state=method
   1. cached
      1. resumed by lid:
         (x) event=close
         (x) systemd=suspends again
         (x) acpid=suspends again
         (x) state=close
      2. resumed by other:
         (o) event=close
         (x) systemd=suspends again
         (x) acpid=suspends again
         (o) state=close
   2. non-cached
      1. resumed by lid:
         (o) event=open
         (o) systemd=resumes
         (o) acpid=resumes
         (o) state=open
      2. resumed by other:
         (o) event=close
         (x) systemd=suspends again
         (x) acpid=suspends again
         (o) state=close
2. lid_init_state=open
   1. cached
      1. resumed by lid:
         (o) event=open
         (o) systemd=resumes
         (o) acpid=resumes
         (x) state=close
      2. resumed by other:
         (x) event=open
         (o) systemd=resumes
         (o) acpid=resumes
         (o) state=close
   2. non-cached
      1. resumed by lid:
         (o) event=open
         (o) systemd=resumes
         (o) acpid=resumes
         (o) state=open
      2. resumed by other:
         (x) event=open
         (o) systemd=resumes
         (o) acpid=resumes
         (o) state=close
3. lid_init_state=ignore
   1. cached
      1. resumed by lid:
         (o) event=none
         (x) systemd=suspends again
         (o) acpid=resumes
         (x) state=close
      2. resumed by other:
         (o) event=none
         (x) systemd=suspends again
         (o) acpid=resumes
         (o) state=close
   2. non-cached
      1. resumed by lid:
         (o) event=none
         (x) systemd=suspends again
         (o) acpid=resumes
         (o) state=open
      2. resumed by other:
         (o) event=none
         (x) systemd=suspends again
         (o) acpid=resumes
         (o) state=close
As a conclusion:
1. With systemd changed, lid_init_state=ignore has only one problem and the
   problem comes from an underlying issue, not userspace and kernel lid
   handling.
2. Without systemd changed, lid_init_state=open can be the default
   behavior as the pass ratio is not much worse than lid_init_state=ignore.
3. lid_init_state=method is buggy, we can have a separate patch to make it
   deprectated.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=187271
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e19f530..6d5a8c1 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -113,7 +113,7 @@ struct acpi_button {
 
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
-static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
+static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
 
 static unsigned long lid_report_interval __read_mostly = 500;
 module_param(lid_report_interval, ulong, 0644);
-- 
2.7.4

