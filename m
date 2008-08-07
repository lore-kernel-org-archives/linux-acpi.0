From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 0/3] acpi: semaphore removal -v2
Date: Thu,  7 Aug 2008 07:59:38 -0700
Message-ID: <1218121178-13779-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:62974 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbYHGO7q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Aug 2008 10:59:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <matthew@wil.cx>, Peter Zijlstra <peterz@infradead.org>, Zhao Yakui <yakui.zhao@intel.com>, Dave Chinner <david@fromorbit.com>, Ingo Molnar <mingo@elte.hu>

I did a lot of cleanup .. I added the mutex_lock_timeout function
which I didn't have in the last set of patches.

I also trimmed down the semaphore to completions patch. So ACPI keeps the
name "semaphore" internally, but it can only be initialized with "0"
initial units. It means that ACPI developers can't randomly use the
semaphore as a mutex (which I haven't seen anyway).

Daniel


