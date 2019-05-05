Return-Path: <SRS0=u58W=TF=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D9C004C9
	for <linux-acpi@archiver.kernel.org>; Sun,  5 May 2019 22:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728D6205C9
	for <linux-acpi@archiver.kernel.org>; Sun,  5 May 2019 22:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEEWON (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 5 May 2019 18:14:13 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:30150 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfEEWOM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 May 2019 18:14:12 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 May 2019 18:14:12 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AMCQDJXc9c/4wNJK1lHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZQKCD4E6ATKyK4F6EIRtgggjOgQNAQMBAQQBAQIBAm0ohj8LgT4BgzS?=
 =?us-ascii?q?CC6sfiGOBRYEyAYZ3hFYXgX+BEYJkixIEk0mTaQmCC1aRYydugRABk0mMG5U?=
 =?us-ascii?q?RgWkLE4FWMxoIGxWDKJBwHwORbwEB?=
X-IronPort-AV: E=Sophos;i="5.60,435,1549929600"; 
   d="scan'208";a="554054908"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 May 2019 22:07:06 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id x45M76ds003095;
        Sun, 5 May 2019 22:07:06 GMT
From:   Ruslan Babayev <ruslan@babayev.com>
To:     linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, mika.westerberg@linux.intel.com,
        wsa@the-dreams.de, Andrew Morton <akpm@linux-foundation.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Enable SFP driver on ACPI based systems
Date:   Sun,  5 May 2019 15:05:21 -0700
Message-Id: <20190505220524.37266-1-ruslan@babayev.com>
X-Mailer: git-send-email 2.17.1
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190505220521.RfB90an-yD2-AMNHedS49hSkDc0dc08SEVh4TwdoIjY@z>

I have split the patch and resending to all relevant mailing lists as
requested by Heiner Kallweit.


[PATCH net-next 1/2] i2c: acpi: export
[PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on ACPI

