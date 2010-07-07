From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 0/4] ACPI: Avoid executing _PRW twice for all devices
Date: Thu, 8 Jul 2010 00:41:38 +0200
Message-ID: <201007080041.38627.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32914 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350Ab0GGWrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Jul 2010 18:47:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Lin Ming <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

Hi,

The following patches have already been sent once and (except for [1/4]) they
have been in your test branch for some time, but they stopped applying after
the previous ACPICA changes were merged.  So, here they go again,
rebased on top of your test branch.

[1/4] - Fixes a test supposed to check if a GPE has a method or handler.

[2/4] - Drops the code walikng the namespace in search of _PRW and adds
        acpi_gpe_can_wake() so that the host OS can disable wakeup GPEs
        previously enabled unconditionally by the ACPICA initialization code.
        This basically reproduces the current behavior except that the GPEs
        are temporarily enabled befor
        acpi_bus_extract_wakeup_device_power_package()
        runs for all devices with _PRW referring to them.

[3/4] - Simplifies code in acpi_ev_initialize_gpe_block(), which only is a
        cosmetic thing, but worth doing IMO.

[4/4] - Changes acpi_gpe_wakeup() to return error code for the GPEs whose
        ACPI_GPE_CAN_WAKE flags are not set.

Please apply.

Rafael

