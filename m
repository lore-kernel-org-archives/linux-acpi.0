From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/22] cpuidle: make code static
Date: Fri,  9 Mar 2007 23:00:46 -0500
Message-ID: <1173499268979-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:10115 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945910AbXCJEBJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:09 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <3d869f55bda8b0b6f0cb55f9a85a6f855a016092.1173498654.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@stusta.de>

This patch makes the following needlessly global code static:
- driver.c: __cpuidle_find_driver()
- governor.c: __cpuidle_find_governor()
- ladder.c: struct ladder_governor

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Adam Belay <abelay@novell.com>
Cc: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.h          |    2 --
 drivers/cpuidle/driver.c           |    2 +-
 drivers/cpuidle/governor.c         |    2 +-
 drivers/cpuidle/governors/ladder.c |    2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index 2defa39..8bbc090 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -23,13 +23,11 @@ extern void cpuidle_rescan_device(struct cpuidle_device *dev);
 /* drivers */
 extern int cpuidle_attach_driver(struct cpuidle_device *dev);
 extern void cpuidle_detach_driver(struct cpuidle_device *dev);
-extern struct cpuidle_driver * __cpuidle_find_driver(const char *str);
 extern int cpuidle_switch_driver(struct cpuidle_driver *drv);
 
 /* governors */
 extern int cpuidle_attach_governor(struct cpuidle_device *dev);
 extern void cpuidle_detach_governor(struct cpuidle_device *dev);
-extern struct cpuidle_governor * __cpuidle_find_governor(const char *str);
 extern int cpuidle_switch_governor(struct cpuidle_governor *gov);
 
 /* sysfs */
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 1111279..de8c627 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -73,7 +73,7 @@ void cpuidle_detach_driver(struct cpuidle_device *dev)
  *
  * Must be called with cpuidle_lock aquired.
  */
-struct cpuidle_driver * __cpuidle_find_driver(const char *str)
+static struct cpuidle_driver * __cpuidle_find_driver(const char *str)
 {
 	struct cpuidle_driver *drv;
 
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index b2d6a69..fa637fa 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -72,7 +72,7 @@ void cpuidle_detach_governor(struct cpuidle_device *dev)
  *
  * Must be called with cpuidle_lock aquired.
  */
-struct cpuidle_governor * __cpuidle_find_governor(const char *str)
+static struct cpuidle_governor * __cpuidle_find_governor(const char *str)
 {
 	struct cpuidle_governor *gov;
 
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index d999393..87d2e54 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -199,7 +199,7 @@ static void ladder_exit_device(struct cpuidle_device *dev)
 	kfree(dev->governor_data);
 }
 
-struct cpuidle_governor ladder_governor = {
+static struct cpuidle_governor ladder_governor = {
 	.name =		"ladder",
 	.init =		ladder_init_device,
 	.exit =		ladder_exit_device,
-- 
1.5.0.3.310.g05ef5
