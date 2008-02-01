From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/37] suspend: build fix responding to 2.6.25 kset change
Date: Thu, 31 Jan 2008 23:36:41 -0500
Message-ID: <21779c8de31b1c9e749af676a033109f70156678.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:61249 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757837AbYBAEl5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:41:57 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/main.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 84e1ae6..fc717b8 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -53,7 +53,8 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
 	[TEST_FREEZER] = "freezer",
 };
 
-static ssize_t pm_test_show(struct kset *kset, char *buf)
+static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
+				char *buf)
 {
 	char *s = buf;
 	int level;
@@ -73,7 +74,8 @@ static ssize_t pm_test_show(struct kset *kset, char *buf)
 	return (s - buf);
 }
 
-static ssize_t pm_test_store(struct kset *kset, const char *buf, size_t n)
+static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
+				const char *buf, size_t n)
 {
 	const char * const *s;
 	int level;
@@ -104,6 +106,7 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
+
 #ifdef CONFIG_SUSPEND
 
 /* This is just an arbitrary number */
-- 
1.5.4.rc5.16.gc0279

