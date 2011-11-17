From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/6][resend] cpuidle : remove unused 'governor_data' field
Date: Thu, 17 Nov 2011 11:26:36 +0100
Message-ID: <1321525600-2466-3-git-send-email-daniel.lezcano@linaro.org>
References: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:47484 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544Ab1KQK04 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Nov 2011 05:26:56 -0500
In-Reply-To: <1321525600-2466-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org, deepthi@linux.vnet.ibm.com

As far as I can see, this field is never used in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpuidle.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c904188..4c8fd37 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -95,7 +95,6 @@ struct cpuidle_device {
 	struct list_head 	device_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-	void			*governor_data;
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
-- 
1.7.4.1

