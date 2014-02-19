From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] ACPI / platform: Bluetooth and GPS IDs for new Baytrail boards
Date: Wed, 19 Feb 2014 11:10:31 +0200
Message-ID: <1392801033-17251-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10572 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbaBSJKg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Feb 2014 04:10:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


Heikki Krogerus (2):
  ACPI / platform: add ID for GPS module on Lenovo Miix 2
  ACPI / platform: add IDs for Broadcom Bluetooth chip

 drivers/acpi/acpi_platform.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.9.0.rc3

