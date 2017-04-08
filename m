From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] arm64: acpi: Support PCI devices numa_node property in
 ACPI mode
Date: Sat, 8 Apr 2017 13:17:32 -0400
Message-ID: <0dada57f-4215-4ced-482d-88203857e06d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48454 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752544AbdDHRRf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Apr 2017 13:17:35 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/31/1969 7:00 PM, linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sergey Temerkhanov wrote:
>  int pcibus_to_node(struct pci_bus *bus)  {
> -	return dev_to_node(&bus->dev);
> +	struct pci_config_window *cfg = bus->sysdata;
> +	struct acpi_device *adev = NULL;
> +	struct device *dev;
> +
> +	if (!acpi_disabled)
> +		adev = to_acpi_device(cfg->parent);
> +

I see a problem here that NUMA node information is read from the parent device.
PCI bus can have multiple levels of switches and bridges. The NUMA information
is only present on the host bridge.

This code only works if the endpoint is directly connected to the root port. 

You should follow a similar design pattern like pci_dma_configure() where
you go to the host bridge device from any pci device and read the _PXM from
the host bridge.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
