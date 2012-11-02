From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
Date: Fri, 02 Nov 2012 01:17:47 +0100
Message-ID: <3954574.77sdfIpds8@vostro.rjw.lan>
References: <20121030040237.GA10472@google.com> <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51514 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab2KBANm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 Nov 2012 20:13:42 -0400
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

Hi,

On Tuesday, October 30, 2012 10:42:37 AM Yinghai Lu wrote:
> Subject: [PATCH resend 0/8] PCI, ACPI, x86: pci root bus hotplug support resources assign and remove path
> 
> 1. add support for assign resource for hot add path.
> 2. stop and remove root bus during acpi root remove.
> 
> 
> could get from
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
> 
> Yinghai Lu (8):
>   PCI: Separate out pci_assign_unassigned_bus_resources()
>   PCI: Move pci_rescan_bus() back to probe.c
>   PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
>   PCI, ACPI: assign unassigned resource for hot add root bus
>   PCI: Add pci_stop/remove_root_bus()
>   PCI, ACPI: Make acpi_pci_root_remove stop/remove pci root bus
>   PCI, ACPI: delete root bus prt during hot remove path
>   PCI, ACPI: remove acpi_root_driver in reserse order
> 
>  drivers/acpi/pci_root.c |   21 ++++++++++++++++++++-
>  drivers/pci/probe.c     |   22 ++++++++++++++++++++++
>  drivers/pci/remove.c    |   36 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/setup-bus.c |   22 +---------------------
>  include/linux/pci.h     |    3 +++
>  5 files changed, 82 insertions(+), 22 deletions(-)

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the ACPI-related patches in this series.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
