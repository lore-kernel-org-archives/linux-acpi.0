From: Holger Macht <holger@homac.de>
Subject: [PATCH 0/7] acpi/libata: Express dependencies for devices on dock
 stations and bays
Date: Tue, 6 Dec 2011 17:37:19 +0100
Message-ID: <20111206163718.GA3629@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

Patches 1 through 5 are just a refresh of the patches from Matthew
Garrett sent to this list in September 2010 [1]:

 [PATCH 1/7] scsi: Export scsi_bus_type
 [PATCH 2/7] libata: Bind the Linux device tree to the ACPI device tree
 [PATCH 3/7] libata: Migrate ACPI code over to new bindings
 [PATCH 4/7] acpi: Add support for linking docks to the objects they contain
 [PATCH 5/7] libata: Add links between removable devices and docks

Patches 6 and 7 make the patches actually work on my test hardware
(Thinkpad x60/Thingpad T60) by fixing some minor issues.

 [PATCH 6/7] libata: Generate and pass correct acpi handles
 [PATCH 7/7] acpi: Prevent duplicate hotplug device registration on dock stations

Regards,
 Holger

[1] http://comments.gmane.org/gmane.linux.acpi.devel/47378
