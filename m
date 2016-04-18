From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V6 11/13] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
Date: Mon, 18 Apr 2016 14:21:57 +0200
Message-ID: <5714D165.4020606@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-12-git-send-email-tn@semihalf.com>
 <5714C6F6.8050600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36317 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbcDRMWV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Apr 2016 08:22:21 -0400
Received: by mail-wm0-f46.google.com with SMTP id v188so116778953wme.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Apr 2016 05:22:20 -0700 (PDT)
In-Reply-To: <5714C6F6.8050600@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "liudongdong (C)" <liudongdong3@huawei.com>, helgaas@kernel.org, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jiang.liu@linux.intel.com, jchandra@broadcom.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Linuxarm <linuxarm@huawei.com>

On 18.04.2016 13:37, liudongdong (C) wrote:
> Hi Tomasz
>
> I merged my patchset to branch topci-acpi-v6.
> The patchset is used for Hisilicon DO2 PCIe ACPI support.
> I found some compile errors. The log as below.
> drivers/pci/host/pcie-hisi-acpi.c: In function 'hisi_pcie_init':
> drivers/pci/host/pcie-hisi-acpi.c:130:6: error: 'struct acpi_pci_root'
> has no member named 'sysdata'
>    root->sysdata = reg_base;
>
> In your PATCH V5, add "sysdata" for strcut acpi_pci_root, but PATCH V6
> has not add it.
> In my patch, I used root->sysdata which will be available along
> read/write accessor.
> I want to know the reason this v6 patchset does not add "sysdata". I
> need this.

We are handling this different way. You can now use "struct 
pci_config_window" -> priv, see pci-thunder-pem.c driver.

Tomasz
