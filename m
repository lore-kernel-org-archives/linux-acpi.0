From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v2 0/2] gpio: designware: add gpio-signaled acpi events support
Date: Tue, 23 Feb 2016 15:02:50 +0800
Message-ID: <1456210972-60639-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:21990 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757041AbcBWGw1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Feb 2016 01:52:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

This patchset adds gpio-signaled acpi events support for power button 
on hisilicon D02 board.

The two patches respectively:
        - switch device_node to unified fwnode handle
        - adds gpio-signaled acpi events support for power button

   This patchset is based on
   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
   branch "devel"

Changes v1 -> v2: 
   - rebase to branch "devel" of Linus Walleij's repository
   - split in two patchs as suggested by Andy S
   - add Mika's ACKs

qiujiang (2):
  gpio: designware: switch device node to fwnode
  gpio: designware: add gpio-signaled acpi event for power button

 drivers/gpio/gpio-dwapb.c                | 66 ++++++++++++++++++++------------
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 2 files changed, 42 insertions(+), 26 deletions(-)

-- 
1.9.1

