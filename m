From: akpm@linux-foundation.org
Subject: [patch 2/6] drivers/cpuidle/: make code static
Date: Tue, 06 Mar 2007 02:29:40 -0800
Message-ID: <200703061029.l26ATeKJ019119@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34215 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933222AbXCFKem (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 05:34:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, bunk@stusta.de, abelay@novell.com, shaohua.li@intel.com, venkatesh.pallipadi@intel.com

From: Adrian Bunk <bunk@stusta.de>

This patch makes the following needlessly global code static:
- driver.c: __cpuidle_find_driver()
- governor.c: __cpuidle_find_governor()
- ladder.c: struct ladder_governor

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Cc: Len Brown <lenb@kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Adam Belay <abelay@novell.com>
Cc: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/cpuidle/cpuidle.h          |    2 --
 drivers/cpuidle/driver.c           |    2 +-
 drivers/cpuidle/governor.c         |    2 +-
 drivers/cpuidle/governors/ladder.c |    2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)

diff -puN drivers/cpuidle/cpuidle.h~drivers-cpuidle-make-code-static drivers/cpuidle/cpuidle.h
--- a/drivers/cpuidle/cpuidle.h~drivers-cpuidle-make-code-static
+++ a/drivers/cpuidle/cpuidle.h
@@ -23,13 +23,11 @@ extern void cpuidle_rescan_device(struct
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
diff -puN drivers/cpuidle/driver.c~drivers-cpuidle-make-code-static drivers/cpuidle/driver.c
--- a/drivers/cpuidle/driver.c~drivers-cpuidle-make-code-static
+++ a/drivers/cpuidle/driver.c
@@ -73,7 +73,7 @@ void cpuidle_detach_driver(struct cpuidl
  *
  * Must be called with cpuidle_lock aquired.
  */
-struct cpuidle_driver * __cpuidle_find_driver(const char *str)
+static struct cpuidle_driver * __cpuidle_find_driver(const char *str)
 {
 	struct cpuidle_driver *drv;
 
diff -puN drivers/cpuidle/governor.c~drivers-cpuidle-make-code-static drivers/cpuidle/governor.c
--- a/drivers/cpuidle/governor.c~drivers-cpuidle-make-code-static
+++ a/drivers/cpuidle/governor.c
@@ -72,7 +72,7 @@ void cpuidle_detach_governor(struct cpui
  *
  * Must be called with cpuidle_lock aquired.
  */
-struct cpuidle_governor * __cpuidle_find_governor(const char *str)
+static struct cpuidle_governor * __cpuidle_find_governor(const char *str)
 {
 	struct cpuidle_governor *gov;
 
diff -puN drivers/cpuidle/governors/ladder.c~drivers-cpuidle-make-code-static drivers/cpuidle/governors/ladder.c
--- a/drivers/cpuidle/governors/ladder.c~drivers-cpuidle-make-code-static
+++ a/drivers/cpuidle/governors/ladder.c
@@ -199,7 +199,7 @@ static void ladder_exit_device(struct cp
 	kfree(dev->governor_data);
 }
 
-struct cpuidle_governor ladder_governor = {
+static struct cpuidle_governor ladder_governor = {
 	.name =		"ladder",
 	.init =		ladder_init_device,
 	.exit =		ladder_exit_device,
_
