From: Majun <majun258@huawei.com>
Subject: [RFC PATCH 0/3] Add a new flag for ITS device to control indirect route
Date: Thu, 1 Dec 2016 15:45:57 +0800
Message-ID: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com, majun258@huawei.com
List-Id: linux-acpi@vger.kernel.org

From: MaJun <majun258@huawei.com>

For current ITS driver, two level table (indirect route) is enabled when the memory used
for LPI route table over the limit(64KB * 2) size. But this function impact the 
performance of LPI interrupt actually because need more time to look up the table.

Although this function can save the memory needed, we'd better let the user
to decide enable or disable this function.

MaJun (3):
  Binding: Add a new property string in ITS node to control the two-level route function
  irqchip/gicv3-its:irqchip/gicv3-its: add a new flag to control indirect route in DT mode
  irqchip/gicv3-its:irqchip/gicv3-its: Add a new flag to control indirect route function in ACPI mode.

 .../bindings/interrupt-controller/arm,gic-v3.txt      |  3 +++
 drivers/irqchip/irq-gic-v3-its.c                      | 19 ++++++++++++++-----
 include/acpi/actbl1.h                                 |  3 ++-
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
1.7.12.4
