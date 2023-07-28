Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCDC001DE
	for <linux-acpi@archiver.kernel.org>; Fri, 28 Jul 2023 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbjG1NzY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 28 Jul 2023 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjG1NzT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2023 09:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45506DB;
        Fri, 28 Jul 2023 06:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D733F62159;
        Fri, 28 Jul 2023 13:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32028C433C8;
        Fri, 28 Jul 2023 13:55:15 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org, Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()
Date:   Fri, 28 Jul 2023 14:55:13 +0100
Message-Id: <169055250812.1025105.13485697321170348706.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 17 Jul 2023 19:33:45 +0800, Guanghui Feng wrote:
> According to the ARM IORT specifications DEN 0049 issue E,
> the "Number of IDs" field in the ID mapping format reports
> the number of IDs in the mapping range minus one.
> 
> In iort_node_get_rmr_info(), we erroneously skip ID mappings
> whose "Number of IDs" equal to 0, resulting in valid mapping
> nodes with a single ID to map being skipped, which is wrong.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()
      https://git.kernel.org/arm64/c/003e6b56d780

-- 
Catalin

