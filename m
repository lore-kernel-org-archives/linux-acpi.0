From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 28/48] thermal: Add event notification to thermal framework
Date: Thu, 13 Jan 2011 12:14:14 +0100
Message-ID: <201101131214.14677.trenn@suse.de>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org> <4cb18728709683c91a5f6f8d5f337bfb498b089a.1294827492.git.len.brown@intel.com> <201101131207.01290.trenn@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53166 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756577Ab1AMLOQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jan 2011 06:14:16 -0500
In-Reply-To: <201101131207.01290.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, "R.Durgadoss" <durgadoss.r@intel.com>

thermal: Rename exported func generate_netlink_event to thermal_netlink_event

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: R.Durgadoss <durgadoss.r@intel.com>
CC: Len Brown <len.brown@intel.com>

---
 drivers/thermal/thermal_sys.c |    8 ++++----
 include/linux/thermal.h       |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 5bbacff..02283f3 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -78,7 +78,7 @@ static struct genl_multicast_group thermal_event_mcgrp = {
 static int genetlink_init(void);
 static void genetlink_exit(void);
 
-int generate_netlink_event(u32 orig, enum events event)
+int thermal_netlink_event(u32 orig, enum events event)
 {
 	struct sk_buff *skb;
 	struct nlattr *attr;
@@ -137,7 +137,7 @@ int generate_netlink_event(u32 orig, enum events event)
 
 	return result;
 }
-EXPORT_SYMBOL(generate_netlink_event);
+EXPORT_SYMBOL(thermal_netlink_event);
 
 static int genetlink_init(void)
 {
@@ -163,8 +163,8 @@ static void genetlink_exit(void)
 
 static void genetlink_exit(void) {};
 static int genetlink_init(void) { return 0; }
-int generate_netlink_event(u32 orig, enum events event) { return 0; }
-EXPORT_SYMBOL(generate_netlink_event);
+int thermal_netlink_event(u32 orig, enum events event) { return 0; }
+EXPORT_SYMBOL(thermal_netlink_event);
 
 #endif /* CONFIG_NET */
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 1c31614..c24756e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -161,7 +161,7 @@ enum {
 };
 #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
 #endif
-extern int generate_netlink_event(u32 orig, enum events event);
+extern int thermal_netlink_event(u32 orig, enum events event);
 
 struct thermal_zone_device *thermal_zone_device_register(char *, int, void *,
 		const struct thermal_zone_device_ops *, int tc1, int tc2,
