From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/2] minor cleanups for IORT patch set
Date: Wed, 14 Sep 2016 21:49:52 +0800
Message-ID: <1473860994-3996-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:38532 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755879AbcINNvw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Sep 2016 09:51:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

Minor cleanup for IORT patches and no functional change,
based on Marc's irq/irqchip-4.9 branch

Hanjun Guo (2):
  ACPI: IORT: minor cleanup for iort_match_node_callback()
  irqchip: gic-v3-its: keep the head file include in alphabetic order

 drivers/acpi/arm64/iort.c        | 10 +++-------
 drivers/irqchip/irq-gic-v3-its.c |  3 +--
 2 files changed, 4 insertions(+), 9 deletions(-)

-- 
1.7.12.4

