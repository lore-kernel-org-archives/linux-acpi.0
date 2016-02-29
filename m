From: qiujiang <qiujiang@huawei.com>
Subject: [PATCH v4 0/2] gpio: designware: add gpio-signaled acpi event support for power button
Date: Mon, 29 Feb 2016 21:13:14 +0800
Message-ID: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com
Cc: mika.westerberg@linux.intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

This patchset adds gpio-signaled acpi events support for power 
button on hisilicon D02 board.

The two patches respectively:
        - switch device node to fwnode and add acpi binding
        - add gpio-signaled acpi event support

   This patchset  is based on
   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
   branch "devel"

changes v3 -> v4:
   - re-organize this two patchs by Andy's suggestion

changes v2 -> v3:
   - fixed the build error reported by Kbuild test robot

Changes v1 -> v2: 
   - rebase to branch "devel" of Linus Walleij's repository
   - split in two patch as suggested by Andy S
   - add Mika's ACKs

qiujiang (2):
  gpio: designware: switch device node to fwnode and add acpi binding
  gpio: designware: add gpio-signaled acpi event support

 drivers/gpio/gpio-dwapb.c                | 68 ++++++++++++++++++++------------
 drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
 include/linux/platform_data/gpio-dwapb.h |  2 +-
 3 files changed, 45 insertions(+), 27 deletions(-)

-- 
1.9.1
