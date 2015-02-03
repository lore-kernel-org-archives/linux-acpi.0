From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 0/6] PCI: MMCONFIG clean up
Date: Tue, 03 Feb 2015 08:42:01 +0100
Message-ID: <54D07BC9.1040506@linaro.org>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org> <20150202204253.GB5176@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35344 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbbBCHmI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Feb 2015 02:42:08 -0500
Received: by mail-wi0-f178.google.com with SMTP id bs8so19840951wib.5
        for <linux-acpi@vger.kernel.org>; Mon, 02 Feb 2015 23:42:07 -0800 (PST)
In-Reply-To: <20150202204253.GB5176@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, wangyijing@huawei.com, arnd@arndb.de, hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org

On 02.02.2015 21:42, Bjorn Helgaas wrote:
> On Wed, Nov 19, 2014 at 05:04:45PM +0100, Tomasz Nowicki wrote:
>> MMCFG ACPI table has no arch dependencies so it can be used across all
>> architectures. Currently MMCONFIG related code resides in arch/x86 directories.
>> This patch set is goint to isolate non-architecure specific code and make
>> it accessible from drivers/pci/ directory.
>>
>> Tomasz Nowicki (6):
>>    x86, acpi, pci: Reorder logic of pci_mmconfig_insert() function
>>    x86, acpi, pci: Move arch-agnostic MMCFG code out of arch/x86/
>>      directory
>>    x86, acpi, pci: Move PCI config space accessors.
>>    x86, acpi, pci: mmconfig_{32,64}.c code refactoring - remove code
>>      duplication.
>>    x86, acpi, pci: mmconfig_64.c becomes default implementation for arch
>>      agnostic low-level direct PCI config space accessors via MMCONFIG.
>>    pci, acpi: Share ACPI PCI config space accessors.
>
> Hi Tomasz,
>
> I'm just checking to make sure we aren't deadlocked here, with me waiting
> for you and you waiting for me.  I gave you some comments about
> abbreviations (MCFG/MMCFG/MMCONFIG/ECAM), weak functions, code placement
> (drivers/acpi vs. drivers/pci), and the mmio_config_*() naming, so I've
> been waiting to continue those discussions.  But maybe you're waiting for
> me, too?
>
> I think this sort of cleanup is a great idea and I hope we can make some
> progress on it.  If it's easier to do it in small pieces, e.g., starting
> out by moving code and renaming things with no functional changes, that
> would be great with me.

Hi Bjorn,

It is not deadlock, it is rather me suffering with lack of time :)

I definitely want to make that cleanup happen and was about to start 
working on it again. Thanks for remanding me, patches/comments should 
come up soon.

Regards,
Tomasz
