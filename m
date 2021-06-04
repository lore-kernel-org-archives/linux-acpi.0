Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D41C4743D
	for <linux-acpi@archiver.kernel.org>; Fri,  4 Jun 2021 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1989611ED
	for <linux-acpi@archiver.kernel.org>; Fri,  4 Jun 2021 16:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhFDQwd (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:52:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:36391 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFDQwd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:52:33 -0400
IronPort-SDR: MCa3JiKRe+yT+Yi+xqZEjGZR2fjfqn8NFpRV3Di/L7d5k2uzGGWI1wh8QgC1dexDm9JzRlGLNH
 oC6H8zsy/Zcw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="204140056"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="204140056"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:50:34 -0700
IronPort-SDR: kdxGiPHU/CfTH9O916fNADLojD+A6edac2a2dRVNTHDISvpUA08VRUg3e16HHX7zithoDIzrR2
 iWaKDfWtAk9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="618318929"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2021 09:50:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 74F121C8; Fri,  4 Jun 2021 19:50:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/3] ACPI: bus: Constify stubs for CONFIG_ACPI=n case
Date:   Fri,  4 Jun 2021 19:50:45 +0300
Message-Id: <20210604165047.13243-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is a few stubs that left untouched during constification of
the fwnode related APIs. Constify three more stubs here.

Fixes: 8b9d6802583a ("ACPI: Constify acpi_bus helper functions, switch to macros")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: no changes
v2: new fix
 include/linux/acpi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..40657f220f8b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -765,7 +765,7 @@ static inline bool is_acpi_device_node(const struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_device *to_acpi_device_node(struct fwnode_handle *fwnode)
+static inline struct acpi_device *to_acpi_device_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
@@ -775,12 +775,12 @@ static inline bool is_acpi_data_node(const struct fwnode_handle *fwnode)
 	return false;
 }
 
-static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwnode)
+static inline struct acpi_data_node *to_acpi_data_node(const struct fwnode_handle *fwnode)
 {
 	return NULL;
 }
 
-static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
 					const char *name)
 {
 	return false;
-- 
2.30.2

