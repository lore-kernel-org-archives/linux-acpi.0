From: Colin King <colin.king@canonical.com>
Subject: [PATCH 0/2] ACPI: avoid null pointer dereference error
Date: Mon, 25 Mar 2013 10:50:04 +0000
Message-ID: <1364208606-8446-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45574 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162Ab3CYKuN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Mar 2013 06:50:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix a null pointer deference by acpi_driver_data() if device is
null. 

Colin Ian King (2):
  ACPI / fan: avoid null pointer deference error
  ACPI / processor_thermal: avoid null pointer deference error

 drivers/acpi/fan.c               |    8 ++++++--
 drivers/acpi/processor_thermal.c |   24 ++++++++++++++++++------
 2 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.7.9.5

