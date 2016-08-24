From: Duc Dang <dhdang@apm.com>
Subject: Defining polarity and trigger mode for static interrupts in _PRT
Date: Wed, 24 Aug 2016 04:06:13 -0700
Message-ID: <CADaLNDm-HmnOsrntDC8zz28bwiQZVv36LG-iMDATqzavY7cXVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34647 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbcHXLHB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2016 07:07:01 -0400
Received: by mail-ua0-f172.google.com with SMTP id k90so21690767uak.1
        for <linux-acpi@vger.kernel.org>; Wed, 24 Aug 2016 04:06:44 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rafael Wysocki <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, patches <patches@apm.com>

[Resend in plain text mode]

Hi Lorenzo, Rafael,

ACPI 6.1 spec does not specify how to set interrupt polarity and
trigger mode in _PRT when the interrupts are static (hardwired to
specific interrupt inputs in interrupt controller). In current
acpi_pci_irq_enable (drivers/acpi/pci_irq.c) implementation, by
default the trigger mode is set to LEVEL_SENSITIVE, polarity is set to
ACTIVE_LOW. This default setting won't work for ARM64 GICv2, GICv2m,
GICv3 controllers and will cause failures in PCIe AER, PME services
(on X-Gene platforms).

Is there any way to specify polarity and trigger mode for static
interrupts in _PRT? If not, can we introduce a _weak_ hook to specify
default polarity and trigger mode for for ARM64 PCIe INTx in
drivers/acpi/pci_irq.c?

Regards,
Duc Dang.
