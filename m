Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A60AC433B4
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Apr 2021 22:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0340D613CC
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Apr 2021 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhDFWFu (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Apr 2021 18:05:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:54928 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243477AbhDFWFg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:36 -0400
IronPort-SDR: b5GW0lBfeBYSnPULgjJD5Lz23v3iC7Gsp7asM3CgAe000ENnu6KEu1RTuubufBkIEb5W9CZKKm
 iiXn9ukBLvPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640470"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640470"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:10 -0700
IronPort-SDR: U2FIVSwkfzF4PI1X3jpnn13ZCtUOT6CC1OGL8fJimQBXm+t8Ot0ONbJOUH2BoxCrJ0npnFzuQA
 s5gfuzppiEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581769"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:09 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 19/22] ACPICA: iASL: Decode subtable type field for VIOT
Date:   Tue,  6 Apr 2021 14:30:25 -0700
Message-Id: <20210406213028.718796-20-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210406213028.718796-1-erik.kaneda@intel.com>
References: <20210406213028.718796-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

For the table disassembler, decode the subtable type field to a descriptive string.

ACPICA commit 2197e354fb5dcafaddd2016ffeb0620e5bc3d5e2

Link: https://github.com/acpica/acpica/commit/2197e354
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl3.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index e9bd7ce65f7c..c0e68331f1fc 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -514,6 +514,7 @@ enum acpi_viot_node_type {
 	ACPI_VIOT_NODE_MMIO = 0x02,
 	ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI = 0x03,
 	ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO = 0x04,
+	ACPI_VIOT_RESERVED = 0x05
 };
 
 /* VIOT subtables */
-- 
2.29.2

