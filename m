From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] acpi: intel-pmic: add support for REGS OpRegion
Date: Wed, 22 Jun 2016 17:55:38 +0300
Message-ID: <1466607340-88687-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3590 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbcFVO4P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Jun 2016 10:56:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Bin Gao <bin.gao@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rafael,

There is a custom operation region for the WhiskeyCove PMIC device named REGS
used at least on some of the Broxton based platform which is missing support at
the moment. At least the USB Type-C PHY depends on this operation region.

Bin Gao had send patches [1] that add support for the Whiskey Cove
PMIC operation region, but that patch does not cover this particular
operation region.


[1] https://lkml.org/lkml/2016/6/13/674


Felipe Balbi (2):
  acpi: pmic: intel: add REGS operation region support
  acpi: pmic: intel: initialize result to 0

 drivers/acpi/pmic/intel_pmic.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

-- 
2.8.1

