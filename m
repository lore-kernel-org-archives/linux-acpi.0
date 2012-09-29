From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 3/8] PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
Date: Fri, 28 Sep 2012 21:04:16 -0700
Message-ID: <CAE9FiQWv9V7gV1SPcTGGhnCGMow2xT42MXvFh1s6T6S23xTgkQ@mail.gmail.com>
References: <1348733519-24684-1-git-send-email-yinghai@kernel.org>
	<1348733519-24684-4-git-send-email-yinghai@kernel.org>
	<CAErSpo63QeF-Wd8nW-K_Qfp5rjMd0mhWADGW-fZiw4Up5-0ezA@mail.gmail.com>
	<CAE9FiQXDw+D8FeMiojmcX0k_g939zkRM3XmJP08yJJG6o7_Cyg@mail.gmail.com>
	<CAE9FiQXWxgBQDPisGdVKb_r3hy6pA7LpamV-jW5OX0SqDyrCCw@mail.gmail.com>
	<CAErSpo4soM=HigBX3CxbGOGRtjr=4VgXneDXakaCHSufsOoH4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4soM=HigBX3CxbGOGRtjr=4VgXneDXakaCHSufsOoH4Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Sep 28, 2012 at 8:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Is it important that pci_assign_unassigned_bus_resources() be run
> before the driver->add() methods?  Why?

for ioapic controller that may need kernel to assign base bar.

>
> Do you have a pointer to this ioapic driver?  I don't think it's in
> the tree yet.  I know about drivers/pci/ioapic.c, but it doesn't use
> acpi_pci_register_driver().

it is in my for-x86-irq branch.

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-x86-irq

http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=commitdiff;h=c186df98f84336422088740ef8cedc1313ca2485
