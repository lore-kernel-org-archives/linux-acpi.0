Return-Path: <SRS0=fe6V=7C=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F9EC433E1
	for <linux-acpi@archiver.kernel.org>; Wed, 20 May 2020 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CAB2072C
	for <linux-acpi@archiver.kernel.org>; Wed, 20 May 2020 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589997291;
	bh=tSusfwEtnTufQiTMMaZ15xY6HANjfc5RrrUfXAHd4bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYhc1zsUryodvRw6Q7rbZqz0U3Q5VXGbJv5d9fUsU6koa10Z4b4G7POg+HNj0zBxQ
	 OJNQojwmqTvB6s9V/GCOh0ONt/HsoVtbYewbEaKEswWUSI806RT99+BMKdZdJnotkW
	 nGgoqoqjEwalDYa6vVFm4nSkj3erTlOaGNbNXaF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETRyv (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 20 May 2020 13:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgETRyt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 13:54:49 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6973E20823;
        Wed, 20 May 2020 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589997288;
        bh=tSusfwEtnTufQiTMMaZ15xY6HANjfc5RrrUfXAHd4bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzowI8+GqPbs73hL8wdgdaas6aoLB4lvYGw1rWSCDNTR9IC7pFclCVbjgGMKgBAh5
         uB8VqgZAdfEHAyY7/qcBGKGpkHNPWQ1Y/ve3p3PeYIQ8Vv10LRnYd9/A8NnP+uNj10
         z/N/0AOm7CzIOSU+1BrQmu7FJsG6OoT+c8Inlxnk=
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        patches@amperecomputing.com, Robin Murphy <robin.murphy@arm.com>,
        Len Brown <lenb@kernel.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v5] ACPI/IORT: Fix PMCG node single ID mapping handling
Date:   Wed, 20 May 2020 18:54:38 +0100
Message-Id: <158999660879.126681.3746296394205258449.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
References: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 20 May 2020 10:13:07 -0700, Tuan Phan wrote:
> An IORT PMCG node can have no ID mapping if its overflow interrupt is
> wire based therefore the code that parses the PMCG node can not assume
> the node will always have a single mapping present at index 0.
> 
> Fix iort_get_id_mapping_index() by checking for an overflow interrupt
> and mapping count.
> 
> [...]

Applied to arm64 (for-next/acpi), thanks!

[1/1] ACPI/IORT: Fix PMCG node single ID mapping handling
      https://git.kernel.org/arm64/c/50c8ab8d9fbf

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
