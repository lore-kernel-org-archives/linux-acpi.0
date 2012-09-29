From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
Date: Fri, 28 Sep 2012 21:27:55 -0600
Message-ID: <CAErSpo4soM=HigBX3CxbGOGRtjr=4VgXneDXakaCHSufsOoH4Q@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
 <1348733519-24684-4-git-send-email-yinghai@kernel.org> <CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
 <CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com> <CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49190 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab2I2D2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Sep 2012 23:28:16 -0400
Received: by ieak13 with SMTP id k13so8855340iea.19
        for <linux-acpi@vger.kernel.org>; Fri, 28 Sep 2012 20:28:15 -0700 (PDT)
In-Reply-To: <CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Sep 28, 2012 at 7:52 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 28, 2012 at 6:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Sep 28, 2012 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> On Thu, Sep 27, 2012 at 2:11 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>> So could use assign_unassigned_bus_res pci root bus add
>>>
>>> After your series, acpi_pci_root_start() looks like this:
>>>
>>>     pci_assign_unassigned_bus_resources
>>>     list_for_each_entry(driver, &acpi_pci_drivers, node)
>>>         driver->add(root);
>>>     pci_enable_bridges(root->bus);
>>>
>>> so apparently it's important that the driver->add() methods be run
>>> *before* the bridges are enabled.  Why?
>>
>
> During rebase, the changelog get lost.
>
>  pci_enable_bridges
>     ==> pci_enable_device
>         ==> ...
>            ===> pcibios_enable_device
>                ===> pcibios_enable_irq
>
> and one of driver in acpi_pci_drivers, is ioapic drivers and it will
> enable ioapic there.
>
> So we need to enable bridges that later.

Is it important that pci_assign_unassigned_bus_resources() be run
before the driver->add() methods?  Why?

Do you have a pointer to this ioapic driver?  I don't think it's in
the tree yet.  I know about drivers/pci/ioapic.c, but it doesn't use
acpi_pci_register_driver().
