From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Sun, 8 Jan 2017 00:30:27 +0100
Message-ID: <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64462 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755506AbdAGXab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 7 Jan 2017 18:30:31 -0500
In-Reply-To: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 1/7/2017 9:42 PM, Borislav Petkov wrote:
> Hi,
>
> I'm bisecting a boot freeze with 4.10-rc2 on a laptop and the commit in
> $Subject is introducing a breakage, see attached splat. Unfortunately,
> it is not complete as I don't have any other means of logging dmesg on a
> laptop.
>
> A temporary workaround is to boot with "intremap=off".
>
> Unfortunately, I cannot revert
>
>    174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
>
> as it doesn't revert cleanly anymore. From looking at the callstack,
> though, it looks like AMD IOMMU is calling acpi_put_table() and patch in
> $Subject touches it so I'm guessing the AMD IOMMU needs to be updated to
> the new way of parsing the IRQ remapping tables or whatever is going on
> there - I'm just guessing.

Hi,

Please check if this helps:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=696c7f8e0373026e8bfb29b2d9ff2d0a92059d4d

Thanks,
Rafael


> Thanks.
>

