From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 0/3] acpi: acpi: sem out, mutex/completion in
Date: Sat, 19 Jul 2008 11:16:51 -0700
Message-ID: <1216491411-24080-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:29126 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755013AbYGSSRD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Jul 2008 14:17:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, len.brown@intel.com, ak@linux.intel.com

This patch set is not merge ready. I'm just sending out an early release to get
at least some reviews on the approach taken. There is some breakage in timeouts
for the mutex changes. Any lock timeouts are ignored since there isn't a
similar mutex function to replace "down_timeout".

I have been able to boot with these changes, and it seems to be stable
so far. However, I do get lockdep warnings which, I think, are actual
locking problems in ACPI.

Daniel


