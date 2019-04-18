Return-Path: <SRS0=Z37m=SU=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B0CC10F0E
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CAF217D7
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Apr 2019 11:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbfDRLjg (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDRLjg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Apr 2019 07:39:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC2F230BA368;
        Thu, 18 Apr 2019 11:39:35 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-101.ams2.redhat.com [10.36.117.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 919541001F41;
        Thu, 18 Apr 2019 11:39:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Robert R . Howell" <RHowell@uwyo.edu>, linux-acpi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ACPI / LPSS: Use acpi_lpss_* instead of acpi_subsys_* functions for hibernate
Date:   Thu, 18 Apr 2019 13:39:33 +0200
Message-Id: <20190418113933.11158-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 18 Apr 2019 11:39:36 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from
resume_noirq") makes acpi_lpss_{suspend_late,resume_early}() bail early
on BYT/CHT as resume_from_noirq is set.

This means that on resume from hibernate dw_i2c_plat_resume() doesn't get
called by the restore_early callback, acpi_lpss_resume_early(). Instead it
should be called by the restore_noirq callback matching how things are done
when resume_from_noirq is set and we are doing a regular resume.

Change the restore_noirq callback to acpi_lpss_resume_noirq so that
dw_i2c_plat_resume() gets properly called when resume_from_noirq is set
and we are resuming from hibernate.

Likewise also change the poweroff_noirq callback so that
dw_i2c_plat_suspend gets called properly.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202139
Fixes: 48402cee6889 ("ACPI / LPSS: Resume BYT/CHT I2C controllers from resume_noirq")
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 1e2a10a06b9d..cf768608437e 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -1142,8 +1142,8 @@ static struct dev_pm_domain acpi_lpss_pm_domain = {
 		.thaw_noirq = acpi_subsys_thaw_noirq,
 		.poweroff = acpi_subsys_suspend,
 		.poweroff_late = acpi_lpss_suspend_late,
-		.poweroff_noirq = acpi_subsys_suspend_noirq,
-		.restore_noirq = acpi_subsys_resume_noirq,
+		.poweroff_noirq = acpi_lpss_suspend_noirq,
+		.restore_noirq = acpi_lpss_resume_noirq,
 		.restore_early = acpi_lpss_resume_early,
 #endif
 		.runtime_suspend = acpi_lpss_runtime_suspend,
-- 
2.21.0

