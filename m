From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/4] SATA device runtime power off
Date: Thu, 30 Aug 2012 14:40:14 +0800
Message-ID: <1346308818-27039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:54967 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751858Ab2H3Glq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Aug 2012 02:41:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>

Add support for hard disk runtime power off and differentiate
system pm with runtime pm messages.

The patch "libata: pm: differentiate system and runtime pm for ata port"
is the same as the previously seperated sent one:
http://marc.info/?l=linux-ide&m=134614386932721&w=2
I included it into this patch set because patch "libata: acpi: respect
may_power_off flag" is based on top of it.

The patch "scsi: pm: add may_power_off flag" also appears in another
patchset intended for scsi subsystem, they are identical.

Aaron Lu (4):
  libata: pm: differentiate system and runtime pm for ata port
  libata: acpi: set can_power_off for both ODD and HD
  scsi: pm: add may_power_off flag
  libata: acpi: respect may_power_off flag

 drivers/ata/libata-acpi.c  | 112 +++++++++++++++++++++++++++++++--------------
 drivers/ata/libata-core.c  |  22 ++++++---
 drivers/ata/libata-eh.c    |   9 ++--
 include/scsi/scsi_device.h |   1 +
 4 files changed, 99 insertions(+), 45 deletions(-)

-- 
1.7.11.5

