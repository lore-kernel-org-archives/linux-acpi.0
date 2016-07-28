From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/6] Apple device properties
Date: Thu, 28 Jul 2016 02:25:41 +0200
Message-ID: <cover.1469616641.git.lukas__16655.705511994$1469665563$gmane$org@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:52407 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162468AbcG1AZv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jul 2016 20:25:51 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 93696101A7205
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:25:49 +0200 (CEST)
Received: from localhost (4-38-90-81.adsl.cmo.de [81.90.38.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 43C3F6097625
	for <linux-acpi@vger.kernel.org>; Thu, 28 Jul 2016 02:25:48 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-efi@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>, Pierre Moreau <pierre.morrow@free.fr>, reverser@put.as, grub-devel@gnu.org, x86@kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org

Apple EFI drivers supply device properties which are needed to support
Macs optimally.

This series extends the efistub to retrieve the device properties before
ExitBootServices is called (patch [1/6]). They are assigned to devices
in an fs_initcall (patch [5/6]). As a first use case, the Thunderbolt
driver is amended to take advantage of the Device ROM supplied by EFI
(patch [6/6]).

A by-product is a parser for EFI Device Paths which finds the struct
device corresponding to a given path. This is needed to assign
properties to their devices (patch [3/6]).


I've pushed these patches to GitHub where they can be reviewed more
comfortably with green/red highlighting:
https://github.com/l1k/linux/commits/apple_properties_v1


It would be good if one of the resident EFI experts could look over
patch [1/6] to see if I've made any mistakes that might prevent this
from working on 32 bit. It was only tested on 64 bit, I don't know
anyone with an older Mac who could test this.

Specifically, is the following okay:
efi_early->call((unsigned long)sys_table->boottime->locate_protocol, ...)

It would be convenient to have LocateProtocol or LocateHandleBuffer in
struct efi_config so that they can be called with efi_call_early().
Would a patch to add those be entertained? Right now we only offer
LocateHandle and HandleProtocol, which is somewhat cumbersome and
needs more code as the setup_pci() functions show.

Thanks,

Lukas


Lukas Wunner (6):
  efi: Retrieve Apple device properties
  ACPI / bus: Make acpi_get_first_physical_node() public
  efi: Add device path parser
  driver core: Don't leak secondary fwnode on device removal
  efi: Assign Apple device properties
  thunderbolt: Use Device ROM retrieved from EFI

 Documentation/kernel-parameters.txt     |   5 +
 arch/x86/boot/compressed/eboot.c        |  55 ++++++++
 arch/x86/include/uapi/asm/bootparam.h   |   1 +
 drivers/acpi/internal.h                 |   1 -
 drivers/base/core.c                     |   1 +
 drivers/firmware/efi/Kconfig            |  16 +++
 drivers/firmware/efi/Makefile           |   2 +
 drivers/firmware/efi/apple-properties.c | 219 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/dev-path-parser.c  | 186 +++++++++++++++++++++++++++
 drivers/thunderbolt/Kconfig             |   1 +
 drivers/thunderbolt/eeprom.c            |  42 ++++++
 drivers/thunderbolt/switch.c            |   2 +-
 include/linux/acpi.h                    |   7 +
 include/linux/efi.h                     |  38 ++++++
 14 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/efi/apple-properties.c
 create mode 100644 drivers/firmware/efi/dev-path-parser.c

-- 
2.8.1

