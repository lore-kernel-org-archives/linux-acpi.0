Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC3C433E0
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Feb 2021 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3630164DA1
	for <linux-acpi@archiver.kernel.org>; Thu, 18 Feb 2021 23:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBRXu1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:50:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:26827 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhBRXu0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 18:50:26 -0500
IronPort-SDR: HhNhxdLDRF4VWfA7K77cHAZ/MZ/gpGTe0s420scq8iY2iozeNh6NFZ/Hs5Mp1KgER4NkLWyyjh
 RhTDDkuxlxvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="163462463"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="163462463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 15:49:46 -0800
IronPort-SDR: 9Oh8+PTK3mYQKl9FTw45YVchyVRkmJS22xmzSlXowtesOB0oUnzioB1iF058Ou79nYZdXvYbyh
 gELGD5aET31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="367723348"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga007.fm.intel.com with ESMTP; 18 Feb 2021 15:49:46 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 0/2] Hans's generic serial bus fix
Date:   Thu, 18 Feb 2021 15:17:06 -0800
Message-Id: <20210218231708.1143640-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans and Rafael,

Sorry about the late responses. I've accidentally dropped the ball on
the comunication of this pull request. Bob has merged it now and here
are the linux-ized versions of them.

Rafael, if you haven't merged the patches, please consider taking
these as it will keep things easier to maintain on my end..

Thanks and apologies,
Erik Kaneda


Hans de Goede (2):
  ACPICA: Fix race in generic_serial_bus (I2C) and GPIO op_region
    parameter handling
  ACPICA: Remove some code duplication from
    acpi_ev_address_space_dispatch

 drivers/acpi/acpica/acobject.h  |  1 +
 drivers/acpi/acpica/evhandler.c |  7 ++++
 drivers/acpi/acpica/evregion.c  | 69 ++++++++++++++++++++-------------
 drivers/acpi/acpica/evxfregn.c  |  2 +
 4 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.29.2

