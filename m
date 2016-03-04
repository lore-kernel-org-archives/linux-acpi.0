From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v5 0/3] "gpio: designware: add gpio-signaled acpi event support for power button"
Date: Fri, 4 Mar 2016 15:44:31 +0800
Message-ID: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:8679 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbcCDHjD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Mar 2016 02:39:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, qiujiang <qiujiang@huawei.com>

This patchset adds gpio-signaled acpi events support for power button on hisilicon
D02 board.

The three patches respectively:
        - convert device node to fwnode
		- add acpi binding
        - add gpio-signaled acpi event support

   This patchset is based on
   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
   branch "devel"

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
  gpio: designware: convert device node to fwnode
  gpio: designware: add acpi binding
  gpio: designware: add gpio-signaled acpi event support

 drivers/gpio/gpio-dwapb.c                | 69 ++++++++++++++++++++------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 3 files changed, 46 insertions(+), 27 deletions(-)

-- 
1.9.1

