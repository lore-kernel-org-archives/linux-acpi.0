From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/6] cpuidle: fix cpuidle time and usage overflow
Date: Wed, 26 Mar 2008 01:13:39 -0400
Message-ID: <8b78cf602fd3bd97c0080edd22fe8fd5d0fa7832.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19001 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753280AbYCZFXa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:23:30 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
In-Reply-To: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Yi Yang <yi.y.yang@intel.com>, Len Brown <len.brown@intel.com>

From: Yi Yang <yi.y.yang@intel.com>

cpuidle C-state sysfs node time and usage are very easy to overflow because
they are all of unsigned int type, time will overflow within about two hours,
usage will take longer time to overflow, but they are increasing for ever.

This patch will convert them to unsigned long long.

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    2 +-
 drivers/cpuidle/sysfs.c   |   10 ++++++++--
 include/linux/cpuidle.h   |    4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d73663a..d42deb3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -67,7 +67,7 @@ static void cpuidle_idle_call(void)
 	/* enter the state and update stats */
 	dev->last_residency = target_state->enter(dev, target_state);
 	dev->last_state = target_state;
-	target_state->time += dev->last_residency;
+	target_state->time += (unsigned long long)dev->last_residency;
 	target_state->usage++;
 
 	/* give the governor an opportunity to reflect on the outcome */
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 69102ca..e949618 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -218,6 +218,12 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 	return sprintf(buf, "%u\n", state->_name);\
 }
 
+#define define_show_state_ull_function(_name) \
+static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
+{ \
+	return sprintf(buf, "%llu\n", state->_name);\
+}
+
 #define define_show_state_str_function(_name) \
 static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 { \
@@ -228,8 +234,8 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 
 define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
-define_show_state_function(usage)
-define_show_state_function(time)
+define_show_state_ull_function(usage)
+define_show_state_ull_function(time)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 6b72a45..51e6b1e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -38,8 +38,8 @@ struct cpuidle_state {
 	unsigned int	power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 
-	unsigned int	usage;
-	unsigned int	time; /* in US */
+	unsigned long long	usage;
+	unsigned long long	time; /* in US */
 
 	int (*enter)	(struct cpuidle_device *dev,
 			 struct cpuidle_state *state);
-- 
1.5.5.rc1.6.g5cc8f

