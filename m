Return-Path: <SRS0=lFH/=EB=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C91C2D0A3
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Oct 2020 23:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFA9218AC
	for <linux-acpi@archiver.kernel.org>; Mon, 26 Oct 2020 23:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756439;
	bh=HOQPy0p4Pi0/XvfEJsVuHquvnr0IOxQpH7ArqHJntZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KnEsyFqrtA+rZbJpZs57QgwtTUef0iANYBy19puwJKCs+eUVLlxb2wSd+b/ViH2OM
	 W715+wkXe5mYKW5JKMApNBXKR+6GhHV89bxKkEOkmxukmCxMzhdUkTOUvp4aNvh0Ja
	 CObqtztyzOU6SeBORzuSTLfelFsKWcawVBPEvaCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410270AbgJZXx6 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410262AbgJZXx4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:53:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A75F20882;
        Mon, 26 Oct 2020 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756435;
        bh=HOQPy0p4Pi0/XvfEJsVuHquvnr0IOxQpH7ArqHJntZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSHRqqC6O0VD+2Udzw1/w8Tefpkjdojo5ZucRijGZqts+v8DZwtpI+24z6/p9Ww0l
         vkmgvVdlDANTc0UwgN1UBrWYWuJXolLt59YBvMAtkgqbq4YPO0NtrOB/bEKzHtA8VW
         JDrxkvL0lhGqK8H3GQrVpSLt346vFBKw3FpGCH3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 090/132] ACPI: HMAT: Fix handling of changes from ACPI 6.2 to ACPI 6.3
Date:   Mon, 26 Oct 2020 19:51:22 -0400
Message-Id: <20201026235205.1023962-90-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 2c5b9bde95c96942f2873cea6ef383c02800e4a8 ]

In ACPI 6.3, the Memory Proximity Domain Attributes Structure
changed substantially.  One of those changes was that the flag
for "Memory Proximity Domain field is valid" was deprecated.

This was because the field "Proximity Domain for the Memory"
became a required field and hence having a validity flag makes
no sense.

So the correct logic is to always assume the field is there.
Current code assumes it never is.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa/hmat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c32cfb723701..6a91a55229aee 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -424,7 +424,8 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
 			p->flags, p->processor_PD, p->memory_PD);
 
-	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
+	if ((hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID) ||
+	    hmat_revision > 1) {
 		target = find_mem_target(p->memory_PD);
 		if (!target) {
 			pr_debug("HMAT: Memory Domain missing from SRAT\n");
-- 
2.25.1

