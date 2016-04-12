From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V4 0/7] Introduce ACPI world to ITS irqchip
Date: Tue, 12 Apr 2016 09:39:25 +0200
Message-ID: <570CA62D.6080508@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33882 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbcDLHjs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Apr 2016 03:39:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id l6so175782216wml.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Apr 2016 00:39:47 -0700 (PDT)
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, rjw@rjwysocki.net, Bjorn Helgaas <bhelgaas@google.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org, al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, okaya@codeaurora.org

Hi Marc, Bjorn, Rafael,

Can you please have a look at this series? Thanks in advance.

Tomasz


On 04.04.2016 10:52, Tomasz Nowicki wrote:
> The following git branch contains submitted patches along with
> the useful patches from the test point of view (mainly ACPI ARM64 PCI support).
> https://github.com/semihalf-nowicki-tomasz/linux.git (its-acpi-v4)
>
> Series has been tested on Cavium ThunderX and Qualcomm QDF2xxx server.
>
> v3 -> v4
> - rebased against v4.5
> - add ACPI support for IRQ domain handling on a per-device basis
> - reorder domain setup step
> - improve error handling
> - code style improvements
>
> v2 -> v3
> - rebased on top of 4.4
> - fixes and improvements for redistributor init via GICC structures
> - fixes as per kbuild reports
>
> v1 -> v2
> - rebased on top of 4.4-rc4
> - use pci_msi_domain_get_msi_rid for requester ID to device ID translation
>
> Tomasz Nowicki (7):
>    acpi, pci: Setup MSI domain on a per-devices basis.
>    irqchip, GICv3, ITS: Cleanup for ITS domain initialization.
>    irqchip, GICv3, ITS: Refator ITS DT init code to prepare for ACPI.
>    ARM64, ACPI, PCI: I/O Remapping Table (IORT) initial support.
>    irqchip, gicv3, its: Probe ITS in the ACPI way.
>    its, pci, msi: Factor out code that might be reused for ACPI.
>    acpi, gicv3, its: Use MADT ITS subtable to do PCI/MSI domain
>      initialization.
>
>   drivers/acpi/Kconfig                     |   3 +
>   drivers/acpi/Makefile                    |   1 +
>   drivers/acpi/iort.c                      | 335 +++++++++++++++++++++++++++++++
>   drivers/irqchip/Kconfig                  |   1 +
>   drivers/irqchip/irq-gic-v3-its-pci-msi.c |  87 ++++++--
>   drivers/irqchip/irq-gic-v3-its.c         | 188 ++++++++++++-----
>   drivers/irqchip/irq-gic-v3.c             |   7 +-
>   drivers/pci/msi.c                        |  10 +-
>   drivers/pci/pci-acpi.c                   |  77 +++++++
>   include/linux/iort.h                     |  31 +++
>   include/linux/irqchip/arm-gic-v3.h       |   2 +-
>   include/linux/pci.h                      |  11 +
>   12 files changed, 678 insertions(+), 75 deletions(-)
>   create mode 100644 drivers/acpi/iort.c
>   create mode 100644 include/linux/iort.h
>
