Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7AC433E6
	for <linux-acpi@archiver.kernel.org>; Thu, 14 Jan 2021 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF11023B1F
	for <linux-acpi@archiver.kernel.org>; Thu, 14 Jan 2021 18:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbhANSss (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:48:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51348 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbhANSss (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 13:48:48 -0500
Received: from 89-64-81-33.dynamic.chello.pl (89.64.81.33) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 46e5cad22987c8fd; Thu, 14 Jan 2021 19:48:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] ACPI: scan: Janitorial changes in acpi_device_add()
Date:   Thu, 14 Jan 2021 19:45:41 +0100
Message-ID: <3494203.VBaj39JGmp@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

As per the subject on top of linux-next from today.

Please refer to the patch changelogs for details.

Thanks!



