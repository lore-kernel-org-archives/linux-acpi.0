Return-Path: <SRS0=EQPP=WT=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952FC3A5A2
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Aug 2019 20:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6508621897
	for <linux-acpi@archiver.kernel.org>; Fri, 23 Aug 2019 20:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbfHWUcb (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:32:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:1733 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbfHWUcb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Aug 2019 16:32:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 13:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="330829128"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2019 13:32:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E0A4D4; Fri, 23 Aug 2019 23:32:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1] device property: Remove duplicate test for NULL
Date:   Fri, 23 Aug 2019 23:32:27 +0300
Message-Id: <20190823203227.75639-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to check twice for a NULL in fwnode_call_bool_op().

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index a11c8c56c78b..ababd6bc82f3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -110,10 +110,11 @@ struct fwnode_operations {
 	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
 		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
 	 -EINVAL)
-#define fwnode_call_bool_op(fwnode, op, ...)				\
-	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
-		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : false) : \
-	 false)
+
+#define fwnode_call_bool_op(fwnode, op, ...)		\
+	(fwnode_has_op(fwnode, op) ?			\
+	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : false)
+
 #define fwnode_call_ptr_op(fwnode, op, ...)		\
 	(fwnode_has_op(fwnode, op) ?			\
 	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : NULL)
-- 
2.23.0.rc1

