From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v9 09/16] PCI, x86: implement pcibios_{add|remove}_bus()
 hooks
Date: Wed, 17 Apr 2013 13:49:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1304171348420.31235@chino.kir.corp.google.com>
References: <1365781470-32379-1-git-send-email-jiang.liu@huawei.com> <1365781470-32379-10-git-send-email-jiang.liu@huawei.com> <alpine.DEB.2.02.1304161324500.30779@chino.kir.corp.google.com>
 <CAErSpo7A3paLJ8u5FxPZpy=9yT_ZkXvEbcHbKLd7iMutdDaBUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33730 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965493Ab3DQUtN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Apr 2013 16:49:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so1104754pad.27
        for <linux-acpi@vger.kernel.org>; Wed, 17 Apr 2013 13:49:13 -0700 (PDT)
In-Reply-To: <CAErSpo7A3paLJ8u5FxPZpy=9yT_ZkXvEbcHbKLd7iMutdDaBUA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>, Yijing Wang <wangyijing@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>

On Tue, 16 Apr 2013, Bjorn Helgaas wrote:

> Thanks for the report!
> 
> I'm pretty sure I fixed this:
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/jiang-subdrivers&id=3b63aaa70e1ccc4b66d60acc78da09700706a703
> 
> The acpi_pci_add_bus()/acpi_pci_remove_bus() stubs for CONFIG_ACPI=n
> were added early in the series (patch 07/16: "PCI/ACPI: Prepare stub
> functions to handle ACPI PCI (hotplug) slots") but were mistakenly
> removed in patch 12/16: "PCI: acpiphp: Do not use ACPI PCI subdriver
> mechanism".
> 
> I updated my "next" branch with the fixed version of patch 12/16, so
> the 20130417 linux-next tree should have the fix.
> 

Confirmed it's fixed, thanks.
