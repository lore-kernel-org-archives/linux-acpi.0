From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 0/6] removing unused fields in the structure
Date: Fri, 11 Nov 2011 00:57:25 +0100
Message-ID: <1320969451-27218-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:30928 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab1KKAFd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2011 19:05:33 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rob.lee@linaro.org

 This patchset applies on the 'next' branch.

Daniel Lezcano (6):
  cpuidle : move code to prevent forward declaration
  cpuidle : remove unused 'governor_data' field
  acpi : remove 'latency_ticks' in acpi_processor_cx
  acpi : remove 'time' field in acpi_processor_cx
  acpi : remove 'usage' field in acpi_processor_cx
  acpi : remove 'power' field from acpi_processor_cx

 drivers/acpi/processor_idle.c |   11 ----
 drivers/cpuidle/cpuidle.c     |  116 ++++++++++++++++++++---------------------
 include/acpi/processor.h      |    4 --
 include/linux/cpuidle.h       |    1 -
 4 files changed, 57 insertions(+), 75 deletions(-)

-- 
1.7.4.1

