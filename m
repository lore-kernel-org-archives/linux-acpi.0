From: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH] thermal: shorten too long mcast group name
Date: Thu, 21 Mar 2013 19:08:19 +0900 (JST)
Message-ID: <20130321.190819.892238877314124764.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384Ab3CUKIV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Mar 2013 06:08:21 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2LA8LRb014605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Thu, 21 Mar 2013 06:08:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: yamato@redhat.com

You will see garbage at the end of line in the output of following command line:

        $ genl ctrl show | grep thermal_mc_group
        #1:  ID-0x2  name: thermal_mc_group^B

The type of structure field for "name" is char[16] in the kernel:

    #define GENL_NAMSIZ 16      /* length of family name */
    ...
    struct genl_multicast_group {
            ...
            char                name[GENL_NAMSIZ];
            ...
    };

strlen("thermal_mc_group") == 16 is too long for the array size.

"thermal_mc_grp" is more readable than "thermal_mc_grou". However,
I choose latter; the patch for genl command side may truncate the
last char in the name:

     http://marc.info/?l=linux-netdev&m=136371412625262&w=2

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 include/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index f0bd7f9..a65dff3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -44,7 +44,7 @@
 /* Adding event notification support elements */
 #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
 #define THERMAL_GENL_VERSION                    0x01
-#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_group"
+#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grou"
 
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
-- 
1.7.11.7

