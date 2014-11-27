From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 0/3] cleanups for converting apic_id to phys_id to make it arch agnostic
Date: Thu, 27 Nov 2014 13:07:30 +0800
Message-ID: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47004 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbaK0FIA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Nov 2014 00:08:00 -0500
Received: by mail-pa0-f47.google.com with SMTP id kq14so4257939pab.6
        for <linux-acpi@vger.kernel.org>; Wed, 26 Nov 2014 21:07:59 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Tony Luck <tony.luck@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.com>

Some cleanups to convert apic_id to phys_id to accommodate
ACPI 5.0+.

updates since v1:
 - rebase on top of linux-next git repo to slove the conflicts
   with IOAPIC hotplug patch
 - modify patch 2 to update the comments and print message using
   arch independent words instead of APIC

Hanjun Guo (3):
  ACPI / processor: Update the comments in processor.h
  ACPI / processor: Convert apic_id to phys_id to make it arch agnostic
  ACPI / processor: Rename acpi_(un)map_lsapic() to acpi_(un)map_cpu()

 arch/ia64/kernel/acpi.c       |  9 ++++---
 arch/x86/kernel/acpi/boot.c   |  9 ++++---
 drivers/acpi/acpi_processor.c | 25 ++++++++++---------
 drivers/acpi/processor_core.c | 56 +++++++++++++++++++++----------------------
 include/acpi/processor.h      | 12 ++++++----
 include/linux/acpi.h          |  4 ++--
 6 files changed, 59 insertions(+), 56 deletions(-)

-- 
1.9.1

