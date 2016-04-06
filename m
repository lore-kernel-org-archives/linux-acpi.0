From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v7 0/3] gpio: dwapb: add gpio-signaled acpi event support for power button
Date: Wed, 6 Apr 2016 15:07:57 +0800
Message-ID: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:28941 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbcDFG7A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2016 02:59:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, delicious.quinoa@gmail.com, jamie@jamieiles.com, charles.chenxin@huawei.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, qiujiang <qiujiang@huawei.com>

This patchset adds gpio-signaled acpi events support for power button on hisilicon
D02 board.

The three patches respectively:
        - remove name from dwapb_port_property
	- convert device node to fwnode
        - add gpio-signaled acpi event support

   This patchset is based on
   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
   branch "devel"

Changes v6 -> v7:
   - add patch1 by Alan's suggestion

Changes v5 -> v6:
   - merge patch 2~3 to one patch
   - small fixed from Alan's suggestion
   - fixed subject title reference commit history

Changes v4 -> v5:
   - split into three patchs
   - add Andy's ACKs
   
Changes v3 -> v4:
   - re-organize this two patchs by Andy's suggestion

Changes v2 -> v3:
   - fixed the build error reported by Kbuild test robot

Changes v1 -> v2: 
   - rebase to branch "devel" of Linus Walleij's repository
   - split in two patch as suggested by Andy S
   - add Mika's ACKs

qiujiang (3):
  gpio: dwapb: remove name from dwapb_port_property
  gpio: dwapb: convert device node to fwnode
  gpio: dwapb: add gpio-signaled acpi event support

 drivers/gpio/gpio-dwapb.c                | 76 ++++++++++++++++++--------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  3 +-
 include/linux/platform_data/gpio-dwapb.h |  3 +-
 3 files changed, 46 insertions(+), 36 deletions(-)

-- 
1.9.1

