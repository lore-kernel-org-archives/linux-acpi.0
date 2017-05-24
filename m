From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] acpi: fix acpi_get_table() leak / acpi-sysfs denial of service
Date: Wed, 24 May 2017 12:01:20 -0700
Message-ID: <CAPcyv4gpz_Msbevk1MEsfbO4nXySaRNSc7LC=D7NL-AdEdM0=g@mail.gmail.com>
References: <149315024459.9151.4555045488194999231.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0h4hOeRfBgK=ARbw8dmML56v0xnvPjsY9wZ0fv7EXCeQw@mail.gmail.com> <CAPcyv4i_mRLSxm7YAnk_p8PhP=kyhT1aZZcrG-zZxXXWhGQuew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35657 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754524AbdEXTBW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 May 2017 15:01:22 -0400
Received: by mail-oi0-f49.google.com with SMTP id l18so253782904oig.2
        for <linux-acpi@vger.kernel.org>; Wed, 24 May 2017 12:01:22 -0700 (PDT)
In-Reply-To: <CAPcyv4i_mRLSxm7YAnk_p8PhP=kyhT1aZZcrG-zZxXXWhGQuew@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Anush Seetharaman <anush.seetharaman@intel.com>, Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>, Ryon Jensen <ryon.jensen@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristin Jacque <kristin.jacque@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Wed, Apr 26, 2017 at 3:37 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Wed, Apr 26, 2017 at 3:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Tue, Apr 25, 2017 at 9:58 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>>> Reading an ACPI table through the /sys/firmware/acpi/tables interface
>>> more than 65,536 times leads to the following log message:
>>>
>>>  ACPI Error: Table ffff88033595eaa8, Validation count is zero after increment
>>>   (20170119/tbutils-423)
>>>
>>> ...and the table being unavailable until the next reboot. Add the
>>> missing acpi_put_table() so the table ->validation_count is decremented
>>> after each read.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Zhang Rui <rui.zhang@intel.com>
>>> Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
>>> Cc: Kristin Jacque <kristin.jacque@intel.com>
>>> Cc: Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>
>>> Cc: Ryon Jensen <ryon.jensen@intel.com>
>>> Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
>>> Fixes: 1c8fce27e275 ("ACPI: introduce drivers/acpi/sysfs.c")
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> I'm going to apply this, but your Fixes tag is not correct.
>>
>> validation_count was added to struct acpi_table_desc by commit
>>
>> commit 174cc7187e6f088942c8e74daa7baff7b44b33c9
>> Author: Lv Zheng <lv.zheng@intel.com>
>> Date:   Wed Dec 14 15:04:25 2016 +0800
>>
>>     ACPICA: Tables: Back port acpi_get_table_with_size() and
>> early_acpi_os_unmap_memory()
>> from Linux kernel
>>
>> from the 4.10 time frame, so IMO it should be
>>
>> Fixes: 174cc7187e6f (ACPICA: Tables: Back port
>> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
>> kernel)
>>
>
> Ah, thanks for the catch, I missed that detail and was wrong to argue
> it was a 7 year old bug. Apologies Lv!

Hi Rafael, I don't see this in latest Linus master or queued in your
bleeding-edge branch.
