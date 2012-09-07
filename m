From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/6] cpuidle : per cpu latencies
Date: Fri,  7 Sep 2012 12:19:26 +0200
Message-ID: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46113 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab2IGKTi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 06:19:38 -0400
Received: by bkwj10 with SMTP id j10so1284302bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 03:19:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
        cpuidle: Single/Global registration of idle states

we have a single registration for the cpuidle states which makes
sense. But now two new architectures are coming: tegra3 and big.LITTLE.

These architectures have different cpus with different caracteristics
for power saving. High load => powerfull processors, idle => small processors.

That implies different cpu latencies.

This patchset keeps the current behavior as introduced by Deepthi without
breaking the drivers and add the possibility to specify a per cpu states.

 * Tested on intel core 2 duo T9500
 * Tested on vexpress by Lorenzo Pieralsi
 * Tested on tegra3 by Peter De Schrijver

Daniel Lezcano (6):
  acpi : move the acpi_idle_driver variable declaration
  acpi : move cpuidle_device field out of the acpi_processor_power
    structure
  acpi : remove pointless cpuidle device state_count init
  cpuidle : add a pointer for cpuidle_state in the cpuidle_device
  cpuidle : use per cpuidle device cpu states
  cpuidle : add cpuidle_register_states function

 drivers/acpi/processor_driver.c    |    2 +-
 drivers/acpi/processor_idle.c      |   27 +++++++++++++++-------
 drivers/cpuidle/cpuidle.c          |   42 ++++++++++++++++++++++++++++-------
 drivers/cpuidle/governors/ladder.c |   22 +++++++++---------
 drivers/cpuidle/governors/menu.c   |    8 +++---
 drivers/cpuidle/sysfs.c            |    3 +-
 include/acpi/processor.h           |    3 --
 include/linux/cpuidle.h            |   11 ++++++--
 8 files changed, 76 insertions(+), 42 deletions(-)

-- 
1.7.5.4

