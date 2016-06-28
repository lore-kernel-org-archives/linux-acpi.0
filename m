From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 0/3] ACPI / PM: Move _PTS/_WAK invocations out of the noirq stage
Date: Tue, 28 Jun 2016 16:04:21 +0800
Message-ID: <cover.1467100803.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39030 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbcF1IEb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Jun 2016 04:04:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Currently _PTS/_WAK are invoked during noirq stages, while in _PTS/_WAK,
there can be EC transactions. Though the EC driver is able to handle
transactions using polling mode, for the performance reason, it is better
to move _PTS/_WAK out of the noirq stage.

Lv Zheng (3):
  PM: Rename prepare_late/wake suspend_ops callbacks to
    prepare_noirq/finish_noirq
  PM: Add prepare_late/finish_early suspend_ops callbacks
  ACPI / PM: Fix EC polling issue by implementing
    prepare_late/finish_early suspend_ops callbacks

 arch/powerpc/platforms/pseries/suspend.c |    6 ++--
 drivers/acpi/sleep.c                     |    9 +++---
 include/linux/suspend.h                  |   50 +++++++++++++++++++++---------
 kernel/power/suspend.c                   |   18 +++++++----
 4 files changed, 55 insertions(+), 28 deletions(-)

-- 
1.7.10

