Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2408C433E9
	for <linux-acpi@archiver.kernel.org>; Tue,  5 Jan 2021 09:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD5D229CA
	for <linux-acpi@archiver.kernel.org>; Tue,  5 Jan 2021 09:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbhAEJNi (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 5 Jan 2021 04:13:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:50274 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbhAEJNh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 04:13:37 -0500
IronPort-SDR: aFYyTwkkOO51OzhiK9CXy4FsjM4rmXkqDabpuIHL0OILHRtiU2dY1/wHrHZpftN70r1mu/r8Ub
 IYD7g0sU2NsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156862078"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="156862078"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:51 -0800
IronPort-SDR: VVhF95p9st5xLBTXdLZ6yja8BVMHiBlCOm/ZMHGL6AmvzZXwA4+G3hwSiRE1uoUxK+B8JXqBOA
 jypsA8TDu8mQ==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="378794974"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 01:11:49 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        heikki.krogerus@linux.intel.com, rafael@kernel.org
Cc:     bard.liao@intel.com
Subject: [PATCH 2/2] device property: add description of fwnode cases
Date:   Tue,  5 Jan 2021 17:11:46 +0800
Message-Id: <20210105091146.25422-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There are only four valid fwnode cases which are
- primary --> secondary --> -ENODEV
- primary --> NULL
- secondary --> -ENODEV
- NULL

dev->fwnode should be converted between the 4 cases above no matter
how/when set_primary_fwnode() and set_secondary_fwnode() are called.
Describe it in the code so people will keep it in mind.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 51b9545a050b..17eb14607074 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4414,6 +4414,12 @@ static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
  *
  * Set the device's firmware node pointer to @fwnode, but if a secondary
  * firmware node of the device is present, preserve it.
+ *
+ * Valid fwnode cases are:
+ *  - primary --> secondary --> -ENODEV
+ *  - primary --> NULL
+ *  - secondary --> -ENODEV
+ *  - NULL
  */
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 {
@@ -4432,6 +4438,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 	} else {
 		if (fwnode_is_primary(fn)) {
 			dev->fwnode = fn->secondary;
+			/* Set fn->secondary = NULL to keep fn as a primary fwnode */
 			if (!(parent && fn == parent->fwnode))
 				fn->secondary = NULL;
 		} else {
-- 
2.17.1

