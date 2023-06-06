Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D599CC7EE2F
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Jun 2023 09:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjFFJgO (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjFFJfv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 05:35:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E799610C0;
        Tue,  6 Jun 2023 02:35:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD922F4;
        Tue,  6 Jun 2023 02:36:31 -0700 (PDT)
Received: from josmar02Desktop.cambridge.arm.com (josmar02Desktop.cambridge.arm.com [10.2.78.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 413243F587;
        Tue,  6 Jun 2023 02:35:44 -0700 (PDT)
From:   Jose Marinho <jose.marinho@arm.com>
Cc:     Jose Marinho <jose.marinho@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3 v2] Update ACPI documentation for Arm systems
Date:   Tue,  6 Jun 2023 10:35:25 +0100
Message-Id: <20230606093528.1494344-1-jose.marinho@arm.com>
X-Mailer: git-send-email 2.40.0.141.g8d90352acc
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This set of patches updates the Linux kernel ACPI documentation for Arm
systems. The intent is to integrate the developments in the BBR
specification that happened over the last couple of years.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
Cc: James Morse <James.Morse@arm.com>
Cc: Rob Herring <Rob.Herring@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-acpi@vger.kernel.org

v2:
 - Clarify that the RAS tables are conditionaly required when ACPI
   Platform Error Interfaces are required: Hanjun Guo.
 - Clarify that HMAT is required if NUMA is supported and the system
   contains heterogeneous memory: Hanjun Guo.


Jose Marinho (3):
  Documentation/arm64: Update ARM and arch reference
  Documentation/arm64: Update references in arm-acpi
  Documentation/arm64: Update ACPI tables from BBR

 Documentation/arm64/acpi_object_usage.rst |  81 ++++++++++-
 Documentation/arm64/arm-acpi.rst          | 168 ++++++++++++++--------
 2 files changed, 183 insertions(+), 66 deletions(-)

-- 
2.40.0.141.g8d90352acc

