Return-Path: <SRS0=P5bh=SM=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321EBC10F11
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D7420820
	for <linux-acpi@archiver.kernel.org>; Wed, 10 Apr 2019 15:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733184AbfDJPZ2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:25:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:15584 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733170AbfDJPZ1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 10 Apr 2019 11:25:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="163102962"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 08:25:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 07/12] device connection: Find connections also by checking the references
Date:   Wed, 10 Apr 2019 18:25:00 +0300
Message-Id: <20190410152505.87041-8-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
References: <20190410152505.87041-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410152500.ERjMdhOy6MoTHs5DjSpXdaMLG1G4aluYkXUAhjzLlH0@z>

We can also use this API to find named references that the
device nodes have by using fwnode_property_get_reference_args()
function.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/base/devcon.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
index 04db9ae235e4..4cdf95532b63 100644
--- a/drivers/base/devcon.c
+++ b/drivers/base/devcon.c
@@ -38,6 +38,30 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static void *
+fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
+		    void *data, devcon_match_fn_t match)
+{
+	struct device_connection con = { };
+	struct fwnode_reference_args args;
+	void *ret;
+	int i;
+
+	for (i = 0; ; i++) {
+		if (fwnode_property_get_reference_args(fwnode, con_id, NULL, 0,
+						       i, &args))
+			break;
+
+		con.fwnode = args.fwnode;
+		ret = match(&con, -1, data);
+		fwnode_handle_put(args.fwnode);
+		if (ret)
+			return ret;
+	}
+
+	return NULL;
+}
+
 /**
  * device_connection_find_match - Find physical connection to a device
  * @dev: Device with the connection
@@ -65,6 +89,10 @@ void *device_connection_find_match(struct device *dev, const char *con_id,
 		ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
 		if (ret)
 			return ret;
+
+		ret = fwnode_devcon_match(fwnode, con_id, data, match);
+		if (ret)
+			return ret;
 	}
 
 	mutex_lock(&devcon_lock);
-- 
2.20.1

