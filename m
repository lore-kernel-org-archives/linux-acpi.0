From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/3] ACPI/processor: trivial fixes
Date: Tue, 25 Nov 2014 14:48:47 +0000
Message-ID: <1416926930-792-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36591 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751106AbaKYPyj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2014 10:54:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Rafael,

While trying to understand the existing ACPI cpuidle driver, I found
few trivial issues. I am not sure if they were left intentionally or
unnoticed as they might not trigger any issues.

Let me know if these makes sense.

Regards,
Sudeep

Sudeep Holla (3):
  ACPI / processor: remove incorrect comparison of phys_id
  ACPI / processor: remove unused variabled from acpi_processor_power
    structure
  ACPI / cpuidle: avoid assigning signed errno to acpi_status

 drivers/acpi/acpi_processor.c |  3 ---
 drivers/acpi/processor_idle.c | 14 +++++++-------
 include/acpi/processor.h      |  3 ---
 3 files changed, 7 insertions(+), 13 deletions(-)

-- 
1.9.1

