From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [RFC v2 0/2] ACPI: Add irq_type to gpio interrupt
Date: Mon, 16 Nov 2015 08:36:01 +0100
Message-ID: <1447659363-19847-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36148 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbKPHgM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2015 02:36:12 -0500
Received: by wmww144 with SMTP id w144so97769557wmw.1
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2015 23:36:11 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Christophe Ricard <christophe-h.ricard@st.com>

Hi,

ACPI probing method does not retrieve irq_type from a gpio interrupt declare
with GpioInt as it is done with devicetree probing.

Those 2 patches propose a way to retrieve the interrupt polarity/type from a GpioInt
acpi declaration.

Best Regards
Christophe 

v2:
	- Fix build error reported by kbuild robot.

Christophe Ricard (2):
  acpi: Rename acpi_gsi_get_irq_type to acpi_get_irq_type and export
    symbol
  ACPI / gpio: Add irq_type when a gpio is used as an interrupt

 drivers/acpi/gsi.c          | 21 +--------------------
 drivers/acpi/utils.c        | 22 ++++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c |  5 ++++-
 include/linux/acpi.h        |  2 ++
 4 files changed, 29 insertions(+), 21 deletions(-)

-- 
2.5.0

