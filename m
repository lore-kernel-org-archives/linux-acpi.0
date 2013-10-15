From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 0/3] ACPI/Power: Fix infinite loop of runtime resume and suspend caused by turning on power resource
Date: Tue, 15 Oct 2013 23:04:50 +0800
Message-ID: <1381849493-7977-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:15439 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932347Ab3JOPGa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Oct 2013 11:06:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@rjwysocki.net
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Currently, clearing usb port(empty port) PM Qos NO_POWER_OFF flag twice will lead
the usb port to fall into the infinite loop of runtime pm resume and
suspend. This is caused by pm_request_resume() in the acpi_power_resume_dependent().
Detail is in the following link.
http://marc.info/?l=linux-acpi&m=138182749202885&w=2

This patchset is to fix the issue. Patch 1~2 adds new state_lock
to mutex power resource's _ON, _OFF and _STA instead of resource_lock
in order to avoid dead lock when call acpi_power_get_inferred_state()
under resource_lock. Prepare for Patch 3.

Patch 3 is to make pm_request_resume() in the acpi_power_resume_dependent()
able to run just after turning on power and check the right physical device
runtime pm status. 

Lan Tianyu (3):
  ACPI/Power: Add state_lock to mutex power resource's _ON, _OFF and
    _STA
  ACPI/POWER: Rework acpi_power_get_state()
  ACPI/POWER: Call acpi_power_resume_dependent() directly in the
    acpi_power_on_unlocked()

 drivers/acpi/power.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

-- 
1.8.2.1

