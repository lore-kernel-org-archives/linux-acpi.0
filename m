From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/4] cpuidle - support multiple drivers at a time
Date: Tue, 25 Sep 2012 00:43:50 +0200
Message-ID: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58166 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2IXWn5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Sep 2012 18:43:57 -0400
Received: by wibhr14 with SMTP id hr14so5514933wib.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Sep 2012 15:43:56 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, lorenzo.pieralisi@arm.com, pdeschrijver@nvidia.com, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

The discussion about having different cpus on the system with
different latencies bring us to a first attemp by adding a
pointer in the cpuidle_device to the states array.

But as Rafael suggested, it would make more sense to create a
driver per cpu [1].

This patch adds support for multiple cpuidle drivers.

It creates a per cpu cpuidle driver pointer.

In order to not break the different drivers, the function cpuidle_register_driver
assign for each cpu, the driver.

The multiple driver support is optional and if it is not set, the cpuide driver
core code remains the same (except some code reorganisation).

I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.

Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)

[1] http://www.spinics.net/lists/linux-acpi/msg37921.html

Daniel Lezcano (4):
  cpuidle : move driver's refcount to cpuidle
  cpuidle : move driver checking within the lock section
  cpuidle - prepare the driver core to be multi drivers aware
  cpuidle - support multiple drivers

 drivers/cpuidle/Kconfig   |    9 ++
 drivers/cpuidle/cpuidle.c |   24 ++++--
 drivers/cpuidle/driver.c  |  194 ++++++++++++++++++++++++++++++++++++++-------
 drivers/cpuidle/sysfs.c   |   50 +++++++++---
 include/linux/cpuidle.h   |    9 ++-
 5 files changed, 238 insertions(+), 48 deletions(-)

-- 
1.7.5.4

