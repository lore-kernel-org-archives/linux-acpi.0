Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E325EC4361B
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Dec 2020 16:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39F523888
	for <linux-acpi@archiver.kernel.org>; Mon,  7 Dec 2020 16:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgLGQzy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:55:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:58684 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQzy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 11:55:54 -0500
Received: from 89-64-79-106.dynamic.chello.pl (89.64.79.106) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 6b646fca232dded6; Mon, 7 Dec 2020 17:55:11 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] ACPI: scan: Drop INT3396 from acpi_ignore_dep_ids[]
Date:   Mon, 07 Dec 2020 17:55:11 +0100
Message-ID: <12017158.VsPUki9SGr@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to Hans, all device objects where the _HID returns
"INT3396" also have a _CID returning "PNP0D80", so the former
need not be present in acpi_ignore_dep_ids[] any more.

Link: https://lore.kernel.org/linux-acpi/52a2b98c-6bf3-760b-eca9-93cf05fb4877@redhat.com/
Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/project/linux-acpi/patch/3849919.JfvvSOo2yN@kreacher/

---
 drivers/acpi/scan.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -751,7 +751,6 @@ static bool acpi_info_matches_ids(struct
 
 /* List of HIDs for which we ignore matching ACPI devices, when checking _DEP lists. */
 static const char * const acpi_ignore_dep_ids[] = {
-	"INT3396", /* Windows System Power Management Controller */
 	"PNP0D80", /* Windows-compatible System Power Management Controller */
 	NULL
 };



