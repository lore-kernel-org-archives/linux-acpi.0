Return-Path: <SRS0=QYL1=A7=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB41C433E2
	for <linux-acpi@archiver.kernel.org>; Mon, 20 Jul 2020 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315BF22B51
	for <linux-acpi@archiver.kernel.org>; Mon, 20 Jul 2020 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGTRzA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 20 Jul 2020 13:55:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:29589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgGTRzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jul 2020 13:55:00 -0400
IronPort-SDR: Tgybqp1Pol1apO510ZwsvOBTTP+UImRe1CQaKJ6raANrIvViij8i8fx2xtFSaeuft1dm4WRWGg
 33WitOeIeOwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137463851"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="137463851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 10:54:54 -0700
IronPort-SDR: wXppVZgJRmRH1EKLqPF4uFTs/GqEYeh8JYskNKLnU4GlhP7Z3hqQUCPhgsbrJbMsKD/PYa0bPn
 pSdAfaLe/UvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="392105225"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2020 10:54:53 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/3] ACPICA release 20200717
Date:   Mon, 20 Jul 2020 10:31:18 -0700
Message-Id: <20200720173121.2580755-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains patches relevant to linux kernel from ACPICA's
20200717 release. This ACPICA release contains a change in the ACPI
object reference counting mechanism to allow firmware to declare a
large amount of OperationRegion field units without overflowing the
reference count.

Bob Moore (1):
  ACPICA: Update version to 20200717 Version 20200717.

Erik Kaneda (1):
  ACPICA: Do not increment operation_region reference counts for field
    units

Gustavo A. R. Silva (1):
  ACPICA: Replace one-element array with flexible-array

 drivers/acpi/acpica/exprep.c   | 4 ----
 drivers/acpi/acpica/utdelete.c | 6 +-----
 drivers/acpi/acpica/utids.c    | 3 +--
 include/acpi/acpixf.h          | 2 +-
 include/acpi/actypes.h         | 2 +-
 5 files changed, 4 insertions(+), 13 deletions(-)

-- 
2.25.1

