From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v6 0/2] gpio: dwapb: add gpio-signaled acpi event support for power button
Date: Sat, 26 Mar 2016 10:31:34 +0800
Message-ID: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, delicious.quinoa@gmail.com, jamie@jamieiles.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, qiujiang <qiujiang@huawei.com>
List-Id: linux-acpi@vger.kernel.org

This patchset adds gpio-signaled acpi events support for power button on hisilicon
D02 board.

The two patches respectively:
        - convert device node to fwnode
        - add gpio-signaled acpi event support

   This patchset is based on
   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
   branch "devel"

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

qiujiang (2):
  gpio: dwapb: convert device node to fwnode
  gpio: dwapb: add gpio-signaled acpi event support

 drivers/gpio/gpio-dwapb.c                | 69 ++++++++++++++++++++------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 3 files changed, 46 insertions(+), 27 deletions(-)

-- 
1.9.1

