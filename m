From: Rob Lee <rob.lee@linaro.org>
Subject: cpuidle changes and drivers/acpi/processor_idle.c
Date: Tue, 31 Jan 2012 12:55:16 -0600
Message-ID: <CAMXH7KG2XXx2gOp_unpQv1KfO0DZWDWAOajRD-P82LmrkjYf2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62844 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166Ab2AaSzR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jan 2012 13:55:17 -0500
Received: by iacb35 with SMTP id b35so322093iac.19
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jan 2012 10:55:16 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

In the various versions of acpi_idle_enter, I see the following code.

...
	cx->usage++;

	lapic_timer_state_broadcast(pr, cx, 0);
	cx->time += idle_time;
...

But this usage and idle_time and accounted for by the core cpuidle
driver, so is this a small bug and the usage and idle_time accounting
code should be removed?

Also, I see the following:

	/* Tell the scheduler how much we idled: */
	sched_clock_idle_wakeup_event(idle_time_ns);

The sched_clock_idle_wakeup_event does nothing with the idle_time_ns
parameter it is passed.  Perhaps it did at one time.  Is this call
still necessary?

Thanks,
Rob
