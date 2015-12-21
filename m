From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 0/3] Add AMBA bus probing support to ACPI
Date: Mon, 21 Dec 2015 17:49:54 +0300
Message-ID: <1450709399-7246-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36064 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbLUOvy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2015 09:51:54 -0500
Received: by mail-lf0-f46.google.com with SMTP id z124so107617165lfa.3
        for <linux-acpi@vger.kernel.org>; Mon, 21 Dec 2015 06:51:53 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>

As discussed when Shannon Zhao sent a patch to add platform_device support
to pl061 driver. Russel and other maintainers prefered that ACPI learned
how to create AMBA devices rather than converting/adding platform_device
support to AMBA drivers.

http://comments.gmane.org/gmane.linux.ports.arm.kernel/431364

1) Adds basic AMBA device probing support to ACPI, it uses a whitelist of
device IDs as the number of AMBA devices is limited. Currently the two ids
present are those used in QEMU for arm64.

2) Adds the plumbing into ACPI probe sequence.

3) From ACPI pl011 is only defined (SBSA document) to be in SBSA mode which has
reduced functionality. There may be a better method to do this that I have
overlooked.

v2:
- A new ACPI scan handler for AMBA devices has been implemented
- The order of `if` branches in amba-pl011.c has been changed
- A couple of `static`s have been added
- The compilation of the acpi_amba.c unit has made conditional
- A comment on SBSA UART has been added

v1:
https://lkml.kernel.org/g/1443609530-21524-1-git-send-email-graeme.gregory@linaro.org

Graeme Gregory (3):
  ACPI: amba bus probing support
  ACPI: scan add in amba probing
  serial: amba-pl011: add ACPI support to AMBA probe

 drivers/acpi/Makefile           |   1 +
 drivers/acpi/acpi_amba.c        | 149 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/internal.h         |   5 ++
 drivers/acpi/scan.c             |   1 +
 drivers/tty/serial/amba-pl011.c |  37 +++++++---
 5 files changed, 182 insertions(+), 11 deletions(-)
 create mode 100644 drivers/acpi/acpi_amba.c

-- 
2.6.4

