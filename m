From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI / PM: Fixes and simplifications
Date: Fri, 2 Jul 2010 00:10:13 +0200
Message-ID: <201007020010.13755.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42777 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932637Ab0GAWQ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Jul 2010 18:16:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org

Hi,

The following patches fix a few bugs in the ACPI platform suspend/hibernate
code and simplify it quite a bit.

[1/5] - Fixes a theoretical issue in acpi_suspend_begin() related to the NVS saving.

[2/5] - Moves acpi_enable_wakeup_device() to acpi_sleep_prepare(), so that it
        can be merged with acpi_enable_wakeup_device_prep().

[3/5] - Merges acpi_enable_wakeup_device() and acpi_enable_wakeup_device_prep()
        and drops some unnecessary code.

[4/5] - Gets rid of some code duplication in drivers/acpi/sleep.c.

[5/5] - Drops an unnecessary routine from drivers/acpi/sleep.c.

Please apply.

Rafael

