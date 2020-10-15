Return-Path: <SRS0=fmxS=DW=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B9C433DF
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF522225D
	for <linux-acpi@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgJORAI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:00:08 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49192 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389998AbgJORAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2020 13:00:06 -0400
Received: from 89-64-88-192.dynamic.chello.pl (89.64.88.192) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id 2a5fe0e506130c9a; Thu, 15 Oct 2020 19:00:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 0/2] ACPI: DPTF: Driver name fixes and Kconfig update
Date:   Thu, 15 Oct 2020 18:57:22 +0200
Message-ID: <2206290.MayQypTng0@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

These patches fix the names of two DPTF drivers to adhere to the sysfs file
naming conventions and rework the DPTF part of Kconfig.

Please refer to the patch changelogs for details.

Thanks!



