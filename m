From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/2] arch_timer: acpi: Add workaround for hisilicon-161010101 erratum
Date: Tue, 24 Jan 2017 18:39:49 +0800
Message-ID: <1485254391-51551-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:28108 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdAXKor (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 05:44:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

Introduce a general quirk framework for arch timer erratum in ACPI,
which use the oem information in GTDT table for platform specific
erratums, then add specific handler and data for hisilicon-161010101
erratum.

Hanjun Guo (2):
  arm64: arch_timer: acpi: Introduce a generic aquirk framework for
    erratum
  arch_timer: acpi: add hisi timer erratum data

 drivers/clocksource/arm_arch_timer.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

-- 
1.7.12.4

