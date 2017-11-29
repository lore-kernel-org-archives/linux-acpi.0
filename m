From: Len Brown <lenb@kernel.org>
Subject: Dell XPS13 9360 - 1,000ms acpi_pm_finish()
Date: Wed, 29 Nov 2017 01:06:37 -0500
Message-ID: <CAJvTdK=gJk3N+75G97QpXiTnw9FDJPQiuR66sGgyc6e_zcesHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46817 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdK2GGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Nov 2017 01:06:39 -0500
Received: by mail-qk0-f194.google.com with SMTP id b184so2992448qkc.13
        for <linux-acpi@vger.kernel.org>; Tue, 28 Nov 2017 22:06:38 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Rafael,

Per our discussion...

As of Linux-4.14, acpi_pm_finish() takes over 1,000 ms on the Dell
XPS13.  This routine accounts for 50% of the total resume time of this
machine.

So I commented _WAK out of acpi_hw_legacy_wake(), and  that 1000ms
became 2ms.  (and the system also seemed to resume fine without _WAK,
though I didn't test it extensively)

So I effectively pre-pended acpi_pm_finish() to acpi_pm_end() with the
hack patch below, and that seems to work fine.

(Note that it seems that the relative ordering of enabling run-time
GPEs and invoking _WAK is already correct in acpi_hw_legacy_wake() --
the GPEs are enabled first.)

So the question becomes...  How early does _WAK really need to be?

thanks
Len Brown, Intel Open Source Technology Center

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 8082871b409a..f25f1874cfaf 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -495,6 +495,8 @@ static void acpi_pm_start(u32 acpi_state)
  */
 static void acpi_pm_end(void)
 {
+       printk("lenb: acpi_pm_finish from within acpi_pm_end\n");
+       acpi_pm_finish();
        acpi_turn_off_unused_power_resources();
        acpi_scan_lock_release();
        /*
@@ -639,7 +641,6 @@ static const struct platform_suspend_ops
acpi_suspend_ops = {
        .begin = acpi_suspend_begin,
        .prepare_late = acpi_pm_prepare,
        .enter = acpi_suspend_enter,
-       .wake = acpi_pm_finish,
        .end = acpi_pm_end,
 };
