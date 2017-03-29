From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V2] acpi: apei: check for pending errors when probing HED type GHES entries
Date: Wed, 29 Mar 2017 09:54:40 -0600
Message-ID: <1490802880-10239-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932318AbdC2Pyq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 11:54:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, bp@suse.de, prarit@redhat.com, bhelgaas@google.com, punit.agrawal@arm.com, mingo@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, shiju.jose@huawei.com, James.Morse@arm.com, ahs3@redhat.com
Cc: Tyler Baicar <tbaicar@codeaurora.org>

If a HED type error occurs prior to GHES probing, the kernel will
never report the error. The HED driver will see that no notifiers
are registered, and clear the interrupt.

This becomes a more serious problem with firmware that supports
GHESv2 acknowledgements from the kernel. The firmware will populate
the error and wait for the kernel ack. But since the kernel will
never process the error we get into a state that the firmware will
not send any more errors and the kernel will never see or ack the
original error.

Check for pending errors when probing HED type GHES entries to
avoid the above situation.

This patch is based on Shiju's patch that adds support for GSIV
and GPIO notification types:
https://patchwork.kernel.org/patch/9628817/

Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fd39929..cf5e938 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1035,6 +1035,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			register_acpi_hed_notifier(&ghes_notifier_hed);
 		list_add_rcu(&ghes->list, &ghes_hed);
 		mutex_unlock(&ghes_list_mutex);
+		ghes_proc(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

