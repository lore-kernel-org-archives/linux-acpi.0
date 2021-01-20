Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3204CC43381
	for <linux-acpi@archiver.kernel.org>; Wed, 20 Jan 2021 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC59323443
	for <linux-acpi@archiver.kernel.org>; Wed, 20 Jan 2021 19:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392389AbhATTHG (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:07:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57174 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392444AbhATTD1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2021 14:03:27 -0500
Received: from 89-64-80-175.dynamic.chello.pl (89.64.80.175) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 2d6cdd356bd74ad0; Wed, 20 Jan 2021 20:02:17 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v1 0/6] ACPI:  Clean up printing messages in some source files
Date:   Wed, 20 Jan 2021 19:56:12 +0100
Message-ID: <2809410.8bz27usjlQ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This series cleans up messaging in some source files under drivers/acpi/
and get rids of some debug code pieces that aren't needed any more.

The primary goal here was to get rid of things like ACPI_DEBUG_PRINT()
or ACPI_EXCEPTION() from non-ACPICA code (they are specific to ACPICA and
should not be used outside of it) and allow the usual dynamic debug to
be used in the files in question instead, but also there are some
cleanups related to the raw printk() usage and so on.

Please refer to patch changelogs for details.

Thanks!



