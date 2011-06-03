From: Shaohua Li <shaohua.li@intel.com>
Subject: [BUG report] lockdep deadlock warning in shutdown
Date: Fri, 03 Jun 2011 11:24:32 +0800
Message-ID: <1307071472.15392.60.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:12246 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1FCDYr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jun 2011 23:24:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "robert.moore" <robert.moore@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>

running 3.0-rc1, shutting down my system triggers a lockdep deadlock
warning.

The deadlock warning is triggered when executing
acpi_hw_clear_acpi_status, stack trace is something like:
...
__lock_acquire
?acpi_os_acquire_lock
lock_acquire
?acpi_os_acquire_lock
?_raw_spin_lock_irqsave
?acpi_hw_enable_runtime_gpe_block
_raw_spin_lock_irqsave
?acpi_os_acquire_lock
?acpi-hw_write
acpi_os_acquire_lock
acpi_ev_walk_gpe_list
acpi_hw_clear_acpi_status
acpi_enter_sleep_state
...
I wrote it down by hand since this is shutdown, no way to get the log.
also since the screen scrolls fast, I didn't catch another code path the
locks are taken which lockdep prints out.

Thanks,
Shaohua

