Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64651C433ED
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Apr 2021 08:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434C5613C0
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Apr 2021 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbhDNIbI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 14 Apr 2021 04:31:08 -0400
Received: from gusto.metanet.ch ([80.74.154.155]:35996 "EHLO gusto.metanet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241292AbhDNIbH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 04:31:07 -0400
Received: from localhost (localhost [127.0.0.1]) by gusto.metanet.ch (Postfix) with ESMTPSA id B348F4F00F84;
        Wed, 14 Apr 2021 10:30:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabwu.ch; s=default;
        t=1618389036; bh=oEVNdPkkQwnLJdVv9fNzzc3myubYvDYlgylBupKNfck=;
        h=From:To:Subject;
        b=EoPGRlHQKIdnJO6F80ZT0z/KMyX1YYW7GdPaYdpZWGiCtqkvWHMCJuxPsKxnWdLxo
         QSUXymICnIdY7dI7K+w0/8ijvX6LFHtPZBsnXltlRhingJC4IvyQMIpfazM8ZstjSg
         C/4CdzjL0V7qSQV2ILngCTpE271SyGMvUEYLWxE0=
Authentication-Results: gusto.metanet.ch;
        spf=pass (sender IP is 2001:67c:10ec:574f:8000::124) smtp.mailfrom=me@fabwu.ch smtp.helo=localhost
Received-SPF: pass (gusto.metanet.ch: connection is authenticated)
From:   =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
To:     linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
Subject: [PATCH v3 0/2] ipu3-cio2: Parse sensor orientation and rotation
Date:   Wed, 14 Apr 2021 10:30:20 +0200
Message-Id: <20210414083022.25453-1-me@fabwu.ch>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413063435.18111-1-me@fabwu.ch>
References: <20210413063435.18111-1-me@fabwu.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This set exposes the orientation and rotation of a camera sensor
attached to ipu3-cio2 as fwnodes properties. Individual drivers can use
v4l2_fwnode_device_parse() to pick up these properties and expose them
as v4l2 controls using v4l2_ctrl_new_fwnode_properties().

Changes in v2:
  - Move ACPI PLD constants to ACPI headers
  - Fix dev_properties size

Changes in v3:
  - Split patch into patch for ipu3 and patch for ACPICA

Fabian Wüthrich (2):
  ACPI: Add _PLD panel positions
  ipu3-cio2: Parse sensor orientation and rotation

 drivers/media/pci/intel/ipu3/cio2-bridge.c | 60 ++++++++++++++++++++--
 drivers/media/pci/intel/ipu3/cio2-bridge.h |  9 +++-
 include/acpi/acbuffer.h                    |  9 ++++
 3 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.31.1

