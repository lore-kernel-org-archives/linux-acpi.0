Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD83C04FF3
	for <linux-acpi@archiver.kernel.org>; Fri, 21 May 2021 23:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA23613F2
	for <linux-acpi@archiver.kernel.org>; Fri, 21 May 2021 23:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEUXET (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 21 May 2021 19:04:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:11009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhEUXET (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 May 2021 19:04:19 -0400
IronPort-SDR: 9S+3lxPu8o/K0Ny4NvUq293XbEGYbHLPlCbnZugmjpCdrsjXhtT0AsaRTS6wmxoQz0N+8ripX+
 66d081kgM9Bg==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265494907"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265494907"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 16:02:54 -0700
IronPort-SDR: sPTRrcZbr59EtzrjGvSGefjwgy9GSpt5ayJhmin502Zg+I7XsXRCnbckxwCiyQMEASuNg+3IWm
 Ab4yXELBRL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="544253753"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 16:02:54 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/1] Mutex memory leak fix
Date:   Fri, 21 May 2021 15:28:07 -0700
Message-Id: <20210521222808.2174134-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, we fixed a memory leak from a patch that was added to kernel
in the previous ACPICA release. Please take this patch for the rc series.

Thanks,

Erik

Erik Kaneda (1):
  ACPICA: Clean up context mutex during object deletion

 drivers/acpi/acpica/utdelete.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.29.2

