From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V9 00/11] Support for ARM64 ACPI based PCI host controller
Date: Sat, 11 Jun 2016 11:51:32 +0200
Message-ID: <575BDF24.9030201@semihalf.com>
References: <1465588519-11334-1-git-send-email-tn@semihalf.com>
 <20160610234107.GC7671@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34527 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbcFKJvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Jun 2016 05:51:42 -0400
Received: by mail-lf0-f48.google.com with SMTP id j7so35302331lfg.1
        for <linux-acpi@vger.kernel.org>; Sat, 11 Jun 2016 02:51:41 -0700 (PDT)
In-Reply-To: <20160610234107.GC7671@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org, jchandra@broadcom.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com, jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org

On 11.06.2016 01:41, Bjorn Helgaas wrote:
> On Fri, Jun 10, 2016 at 09:55:08PM +0200, Tomasz Nowicki wrote:
>>  From the functionality point of view this series may be split into the
>> following logic parts:
>> 1. Export ECAM API and add parent device to pci_config_window
>> 2. Add IO resources handling to PCI core code
>> 3. New MCFG driver
>> 4. Cleanups and support for generic domain assignment based on ACPI
>> 5. Implement ARM64 ACPI based PCI host controller driver under arch/arm64/
>
> This is beautiful!  It really turned out well.
>
> I applied all these to pci/arm64-acpi for v4.8.
>

Thanks Bjorn! This is great news.

Tomasz

