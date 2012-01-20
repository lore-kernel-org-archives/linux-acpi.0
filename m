From: Holger Macht <holger@homac.de>
Subject: [PATCHv2 0/7] acpi/libata: Express dependencies for devices on dock
 stations and bays
Date: Fri, 20 Jan 2012 01:18:18 +0100
Message-ID: <20120120001817.GA27706@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42462 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab2ATASW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jan 2012 19:18:22 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, Jeff Garzik <jgarzik@redhat.com>

Patches 2 through 5 are just a refresh of the patches from Matthew
Garrett sent to this list in September 2010 [1]:

Patch 1 is a new patch incorporating the corrections from James
Bottomley. Patch 6, 7 and 8 make the whole patch set actually work on my
test hardware (Thinkpad x60/Thinkpad T60) by fixing minor issues and
compensating changes after the first submission.

All patches now contain the correct Signed-off-by instead of Acked-by
tags.

 [PATCH 1/8] scsi: Add wrapper to access and set scsi_bus_type in struct acpi_bus_type
 [PATCH 2/8] libata: Bind the Linux device tree to the ACPI device tree
 [PATCH 3/8] libata: Migrate ACPI code over to new bindings
 [PATCH 4/8] acpi: Add support for linking docks to the objects they contain
 [PATCH 5/8] libata: Add links between removable devices and docks
 [PATCH 6/8] libata: Generate and pass correct acpi handles
 [PATCH 7/8] acpi: Prevent duplicate hotplug device registration on dock stations
 [PATCH 8/8] libata: Use correct PCI devices

Regards,
 Holger

[1] http://comments.gmane.org/gmane.linux.acpi.devel/47378
