From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 0/3] ACPI / PM: Patches missing from linux-acpi-2.6/test
Date: Sat, 11 Dec 2010 23:39:52 +0100
Message-ID: <201012112339.53105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46475 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682Ab0LKWqb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Dec 2010 17:46:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi Len,

The following three patches seem to have been dropped from your 'test' branch.

If that happened by accident, please reapply.  Otherwise, please let me know
what's wrong with the patches so that I can fix them.

[1/3] - Make fujitsu_laptop use acpi_bus_update_power() instead of
        acpi_bus_get_power() which is unsafe.

[2/3] - Drop acpi_bus_get_power() which is unsafe and has no users.

[3/3] - Do not call __acpi_bus_get_power() from acpi_bus_set_power()
        and remove acpi_power_nocheck that is not necessary any more.

Without these patches the power resources handling rework is incomplete and
the code will not work correctly in some situations. 

Thanks,
Rafael

