From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpuidle: Rework the handling of the poll state
Date: Wed, 23 Aug 2017 23:18:55 +0200
Message-ID: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56873 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751004AbdHWVba (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Aug 2017 17:31:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

Hi,

On x86 the fist idle state is a polling one, but the way it is set up is far
from straightforward and then it is avoided by governors in rather somewhat
convoluted fashion.

Make this more clear by explicitly flagging that state as "polling" and
checking its flag where it needs to be avoided instead of using
arch-dependent numbering of idle states (patch [1/3]), move the
polling state code from driver.c to a separate C file (patch [2/3]) and
move the initialization of it from the core to the relevant cpuidle drivers -
ACPI and intel_idle (patch [3/3]).

Thanks,
Rafael

