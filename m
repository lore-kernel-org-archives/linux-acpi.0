Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8BAC2BB48
	for <linux-acpi@archiver.kernel.org>; Mon, 14 Dec 2020 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BCE2246B
	for <linux-acpi@archiver.kernel.org>; Mon, 14 Dec 2020 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502864AbgLNUgF (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 14 Dec 2020 15:36:05 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45592 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503357AbgLNUef (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Dec 2020 15:34:35 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id c066d0382b008ef8; Mon, 14 Dec 2020 21:33:42 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans De Goede <hdegoede@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [RFT][PATCH v1 0/3] ACPI: scan: Defer enumeration of devices with significant dependencies
Date:   Mon, 14 Dec 2020 21:23:47 +0100
Message-ID: <1646930.v2jOOB1UEN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

This series addresses some enumeration ordering issues by using information
from _DEP to defer the enumeration of devices that are likely to depend on
operation region (OpRegion) handlers supplied by the drivers of other
devices.

This allows the OpRegion suppliers to be probed and start working before the
devices depending on them are enumerated.

Please see the patch changelogs for details.

Hans, please test this series on the system with OpRegion dependencies in
control methods used for device enumeration.

Thanks!



