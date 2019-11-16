Return-Path: <SRS0=e88u=ZI=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA03C43215
	for <linux-acpi@archiver.kernel.org>; Sat, 16 Nov 2019 16:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEBA2089D
	for <linux-acpi@archiver.kernel.org>; Sat, 16 Nov 2019 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921012;
	bh=Obg1p7S3J0MkR3yuSxhUyoV5Ni3xlnofF+hMIyYxgDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWqjCiErOi7Fj8J5vL/fKF3XsexoboKMDdw3jzI0grcJ9A8OdJRfcmEX8vlYi5XcQ
	 JMmeImdn6Ugtm1NzoWJq6SnkzDFvg3yq9d7rbLB/yWNRtTZQDPRTUswpuSCO4tGWkp
	 e4BHMkB2EKgw0dXGbeQzQ7XYzYbmoJLJSq5cjBsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfKPPqz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:46:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729554AbfKPPqz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:55 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BCBE208C0;
        Sat, 16 Nov 2019 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919214;
        bh=Obg1p7S3J0MkR3yuSxhUyoV5Ni3xlnofF+hMIyYxgDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9RY9sjI7MSw4DjXRueGmKcYitI/LBTjCNvc0djIo5bGNBOY6gaJZ3rx/NcoE3uhp
         fKSSEb2glfdEo+tRlzng/a+hJW5eKQL4g+NDXeuBqAr9OI2o6sCf38zkZMws/gZlX3
         9QnjeEK4YWHlLBP+hD2d2lPkvi//hStANeqcQGRI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 4.19 220/237] ACPICA: Use %d for signed int print formatting instead of %u
Date:   Sat, 16 Nov 2019 10:40:55 -0500
Message-Id: <20191116154113.7417-220-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit f8ddf49b420112e28bdd23d7ad52d7991a0ccbe3 ]

Fix warnings found using static analysis with cppcheck, use %d printf
format specifier for signed ints rather than %u

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/acpi/tools/acpidump/apmain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/acpidump/apmain.c b/tools/power/acpi/tools/acpidump/apmain.c
index db213171f8d99..2d9b94b631cb9 100644
--- a/tools/power/acpi/tools/acpidump/apmain.c
+++ b/tools/power/acpi/tools/acpidump/apmain.c
@@ -106,7 +106,7 @@ static int ap_insert_action(char *argument, u32 to_be_done)
 
 	current_action++;
 	if (current_action > AP_MAX_ACTIONS) {
-		fprintf(stderr, "Too many table options (max %u)\n",
+		fprintf(stderr, "Too many table options (max %d)\n",
 			AP_MAX_ACTIONS);
 		return (-1);
 	}
-- 
2.20.1

