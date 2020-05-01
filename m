Return-Path: <SRS0=8Yal=6P=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71320C47253
	for <linux-acpi@archiver.kernel.org>; Fri,  1 May 2020 16:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50FB8216FD
	for <linux-acpi@archiver.kernel.org>; Fri,  1 May 2020 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588349426;
	bh=WdDDo0kFFFObg+/uRnNWj+161scQaRmsJMatdV7pV5U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jAocGH1U0gyUr68JR/UKl+8kBUKQN8T19fLO576H8cLxZ6kpPTMHWj5xzfd173CX1
	 UYxDRB7RmXoE2Eui1kbP4Hadg+HThoqDHom+i5QmgylJJdie7QjWGzzGDSI8OTrths
	 ip04FUhdeeuME+hCyuRyzH3JWS9wCsHyk7IODJZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgEAQKZ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 1 May 2020 12:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQKZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 12:10:25 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA7B208DB;
        Fri,  1 May 2020 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588349425;
        bh=WdDDo0kFFFObg+/uRnNWj+161scQaRmsJMatdV7pV5U=;
        h=From:To:Cc:Subject:Date:From;
        b=MA3fRVpgbAwk4MbkZocX2oK8yNI5ti+nmUYRwldUlDMHT8FS7vzyfXKBySKSJw6Sv
         j2ONn/PcdhgJQky4VdZfA4hNPog25MFejK61c769W9psABCI0DJ6M02r6MCTWDuTep
         mJd1gZUoZpGNGP3YejCeuN7NBeptjthM0XnXMM7c=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 0/2] ACPI/IORT: rework num_ids off-by-one quirk
Date:   Fri,  1 May 2020 18:10:12 +0200
Message-Id: <20200501161014.5935-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Replace the ACPI OEM ID matching based IORT quirk for the ID region size
ambiguity with runtime handling of this condition.

This is based on the observation that we only care about this when it
causes ambiguity regarding the output reference, which means that we
will have more than one match for the input ID. In this case, we can
just disregard the one at the end of a multi-ID region: if we hit it
first, we record it tentatively but allow a subsequent match to
supersede it. If we hit the correct match first, there is nothing we
need to do.

Changes since v1:
- print FW_BUG error to the kernel log when a duplicate match is found
- ignore duplicate matches unless they occur at the start of a region
  (for compatibility with broken systems that might exist that happen to
  work today because the first match is always chosen)

Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>

Ard Biesheuvel (2):
  Revert "ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()"
  ACPI/IORT: work around num_ids ambiguity

 drivers/acpi/arm64/iort.c | 95 ++++++++------------
 1 file changed, 35 insertions(+), 60 deletions(-)

-- 
2.17.1

