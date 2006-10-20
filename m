From: fseidel@suse.de
Subject: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Fri, 20 Oct 2006 11:25:47 +0200
Message-ID: <20061020092547.519734000@neutrino.suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40661 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751483AbWJTJ3D (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Oct 2006 05:29:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Thomas Renninger <trenn@suse.de>

Currently acpi_bus_register_driver only reports an error
(-ENODEV) if acpi_disabled is true,
but many acpi drivers also depend on a negative error
value if no driver could be attached to a device
(as e.g. driver/acpi/asus_acpi.c).
This patch adds this again (without changing return type
of acpi_driver_attach for this).

Len, can this be applied, please?

Thanks,
Frank
--
