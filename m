From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v5 0/5] ACPI based PCI support for arm64
Date: Mon, 4 Jan 2016 14:34:02 +0800
Message-ID: <568A125A.9090608@linaro.org>
References: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:32808 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcADGej (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jan 2016 01:34:39 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so161306685pfb.0
        for <linux-acpi@vger.kernel.org>; Sun, 03 Jan 2016 22:34:39 -0800 (PST)
In-Reply-To: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jayachandran C <jchandra@broadcom.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Tomasz Nowicki <tn@semihalf.com>

Hi JC,

On 2016/1/4 13:13, Jayachandran C wrote:
> This patchset provides a generic ACPI based PCI host controller
> implementation and uses it on arm64.
>
> The first patch moves the common code to handle MCFG ACPI table from
> arch/x86 to drivers/acpi/pci_mcfg.c. The last patch in the patchset
> provides the generic implementation of an ACPI based PCI host
> controller with a new file drivers/acpi/pci_host_acpi.c. The other
> patches are to fix up arm64 and ACPI code to work with these two
> patches.
>
> The pci host controller implementation keeps a reference to
> pci_mmcfg_region entry so that config space access is done with a
> simple mapping and generic PCI config read/write. There is also an
> implementation of raw_pci_read/raw_pci_write provided by walking the
> pci_mmcfg_list
>
> The patchset is against 4.4-rc6, but it can be applied to pci/next
> with a very minor fixup.  This is tested with arm64 QEMU and OVMF
> and on x86 with qemu.

Are there any specific problems that Tomasz didn't address in this
patch set?

https://lkml.org/lkml/2015/12/16/246

As Lorenzo pointed out, that patch set was going several rounds and
addressed lots of comments, why not comment on it and push it forward
together?

Thanks
Hanjun
