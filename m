From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [RFC 0/2] ACPI: Add irq_type to gpio interrupt
Date: Sun, 15 Nov 2015 11:15:39 +0100
Message-ID: <1447582541-5630-1-git-send-email-christophe-h.ricard@st.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34357 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbKOKPq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2015 05:15:46 -0500
Received: by wmvv187 with SMTP id v187so137141850wmv.1
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2015 02:15:45 -0800 (PST)
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

Christophe Ricard (2):
  acpi: Rename acpi_gsi_get_irq_type to acpi_get_irq_type and export
    symbol
  ACPI / gpio: Add irq_type when a gpio is used as an interrupt

 drivers/acpi/gsi.c          | 21 +--------------------
 drivers/acpi/utils.c        | 21 +++++++++++++++++++++
 drivers/gpio/gpiolib-acpi.c |  5 ++++-
 include/linux/acpi.h        |  2 ++
 4 files changed, 28 insertions(+), 21 deletions(-)

-- 
2.1.4

