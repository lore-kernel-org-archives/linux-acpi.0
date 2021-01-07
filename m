Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA028C433E0
	for <linux-acpi@archiver.kernel.org>; Thu,  7 Jan 2021 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E5723142
	for <linux-acpi@archiver.kernel.org>; Thu,  7 Jan 2021 11:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAGLSw (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:18:52 -0500
Received: from foss.arm.com ([217.140.110.172]:58052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbhAGLSv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 06:18:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53FE11FB;
        Thu,  7 Jan 2021 03:18:06 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E9413F719;
        Thu,  7 Jan 2021 03:18:05 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com
Cc:     viro@zeniv.linux.org.uk, catalin.marinas@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 0/3] acpi: cppc_acpi: fix sparse warnings
Date:   Thu,  7 Jan 2021 11:17:14 +0000
Message-Id: <20210107111717.5571-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

These patches just fix some trivial sparse warnings.

Hope they help,
Ionela.

Ionela Voinescu (3):
  acpi: cppc_acpi: remove __iomem annotation for cpc_reg's address
  acpi: cppc_acpi: add __iomem annotation to generic_comm_base pointer
  acpi: cppc_acpi: initialise vaddr pointers to NULL

 drivers/acpi/cppc_acpi.c | 8 ++++----
 include/acpi/cppc_acpi.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)


base-commit: e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62
-- 
2.29.2.dirty

