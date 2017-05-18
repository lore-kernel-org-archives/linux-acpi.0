From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V3] acpi: apei: check for pending errors when probing GHES entries
Date: Thu, 18 May 2017 15:22:42 -0600
Message-ID: <1495142562-7318-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756074AbdERVWt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 May 2017 17:22:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, bp@suse.de, prarit@redhat.com, bhelgaas@google.com, punit.agrawal@arm.com, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shiju.jose@huawei.com, James.Morse@arm.com, ahs3@redhat.com
Cc: Tyler Baicar <tbaicar@codeaurora.org>

Check for pending errors when probing GHES entries. It is possible
that a fatal error is already pending at this point, so we should
handle it as soon as the driver is probed. This also avoids a
potential issue if there was an interrupt that was already
cleared for an error since the GHES driver wasn't present.

V3: Check for pending errors of all GHES types

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d0855c0..5347230 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1039,6 +1039,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	}
 	platform_set_drvdata(ghes_dev, ghes);
 
+	/* Handle any pending errors right away */
+	ghes_proc(ghes);
+
 	return 0;
 err_edac_unreg:
 	ghes_edac_unregister(ghes);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

