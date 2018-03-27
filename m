From: Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 2/2] power/hibernate: Change message when writing to /sys/power/resume
Date: Tue, 27 Mar 2018 15:58:53 -0500
Message-ID: <1522184333-27582-2-git-send-email-mario.limonciello@dell.com>
References: <1522184333-27582-1-git-send-email-mario.limonciello@dell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522184333-27582-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

This file is used both for setting the wakeup device without kernel
command line as well as for actually waking the system (when appropriate
swap header is in place).

To avoid confusion on incorrect logs in system log downgrade the
message to debug and make it clearer.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 16e8645..15bc3cd 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1053,7 +1053,7 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	lock_system_sleep();
 	swsusp_resume_device = res;
 	unlock_system_sleep();
-	pr_info("Starting manual resume from disk\n");
+	pm_pr_dbg("Configured resume from disk to %u\n", swsusp_resume_device);
 	noresume = 0;
 	software_resume();
 	return n;
-- 
2.7.4
