Return-Path: <SRS0=hTGP=TX=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE161C282DD
	for <linux-acpi@archiver.kernel.org>; Thu, 23 May 2019 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27E62177E
	for <linux-acpi@archiver.kernel.org>; Thu, 23 May 2019 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbfEWWk2 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 23 May 2019 18:40:28 -0400
Received: from foss.arm.com ([217.140.101.70]:57868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387546AbfEWWk2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 May 2019 18:40:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96C0D374;
        Thu, 23 May 2019 15:40:27 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.30.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 266A83F5AF;
        Thu, 23 May 2019 15:40:27 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        sudeep.holla@arm.com, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/2] arm64/PPTT ACPI 6.3 thread flag support
Date:   Thu, 23 May 2019 17:40:13 -0500
Message-Id: <20190523224015.56270-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 adds a flag to the CPU node to indicate whether
the given CPU is a thread. Add a function to return that
information for a given linux logical CPU and then utilize
it while building the arm64 topology.

Jeremy Linton (2):
  ACPI/PPTT: Add support for ACPI 6.3 thread flag
  arm64: topology: Use PPTT to determine if PE is a thread

 arch/arm64/kernel/topology.c |  8 ++++--
 drivers/acpi/pptt.c          | 53 +++++++++++++++++++++++++++++++++++-
 include/linux/acpi.h         |  5 ++++
 3 files changed, 62 insertions(+), 4 deletions(-)

-- 
2.21.0

