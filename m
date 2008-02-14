From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] CPUidle: Increase size of cumulative residency time to u64
Date: Wed, 13 Feb 2008 17:58:10 -0800
Message-ID: <1202954290-19828-1-git-send-email-khilman@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deeprooted.net ([216.254.16.51]:37468 "EHLO paris.hilman.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763025AbYBNCHG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 21:07:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kevin Hilman <khilman@mvista.com>

Since this is cumulative time in usecs, increase to a 64-bit value.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/cpuidle/sysfs.c |    6 +++++-
 include/linux/cpuidle.h |    2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 0f3515e..a3e8e22 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -218,6 +218,11 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
 	return sprintf(buf, "%u\n", state->_name);\
 }
 
+static ssize_t show_state_time(struct cpuidle_state *state, char *buf)
+{
+	return sprintf(buf, "%llu\n", state->time);
+}
+
 static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
 {
 	return sprintf(buf, "%s\n", state->name);
@@ -226,7 +231,6 @@ static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
 define_show_state_function(exit_latency)
 define_show_state_function(power_usage)
 define_show_state_function(usage)
-define_show_state_function(time)
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(latency, show_state_exit_latency);
 define_one_state_ro(power, show_state_power_usage);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c4e0016..c5c39f6 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -37,7 +37,7 @@ struct cpuidle_state {
 	unsigned int	target_residency; /* in US */
 
 	unsigned int	usage;
-	unsigned int	time; /* in US */
+	unsigned long long time; /* in US */
 
 	int (*enter)	(struct cpuidle_device *dev,
 			 struct cpuidle_state *state);
-- 
1.5.4

