From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [BUG report] lockdep deadlock warning in shutdown
Date: Fri, 3 Jun 2011 03:42:50 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E3CE60@ORSMSX101.amr.corp.intel.com>
References: <1307071472.15392.60.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18852 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1FCDmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jun 2011 23:42:52 -0400
In-Reply-To: <1307071472.15392.60.camel@sli10-conroe>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

Adding Rafael.


>-----Original Message-----
>From: Li, Shaohua
>Sent: Thursday, June 02, 2011 8:25 PM
>To: Moore, Robert; Lin, Ming M
>Cc: linux acpi
>Subject: [BUG report] lockdep deadlock warning in shutdown
>
>running 3.0-rc1, shutting down my system triggers a lockdep deadlock
>warning.
>
>The deadlock warning is triggered when executing
>acpi_hw_clear_acpi_status, stack trace is something like:
>...
>__lock_acquire
>?acpi_os_acquire_lock
>lock_acquire
>?acpi_os_acquire_lock
>?_raw_spin_lock_irqsave
>?acpi_hw_enable_runtime_gpe_block
>_raw_spin_lock_irqsave
>?acpi_os_acquire_lock
>?acpi-hw_write
>acpi_os_acquire_lock
>acpi_ev_walk_gpe_list
>acpi_hw_clear_acpi_status
>acpi_enter_sleep_state
>...
>I wrote it down by hand since this is shutdown, no way to get the log.
>also since the screen scrolls fast, I didn't catch another code path the
>locks are taken which lockdep prints out.
>
>Thanks,
>Shaohua

