From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/11] ACPICA: Tables: Back port acpi_get_table_with_size()
 and early_acpi_os_unmap_memory() from Linux kernel
Date: Thu, 8 Dec 2016 14:18:03 +0100
Message-ID: <CAJZ5v0jYijDj2+UiPp41pHWdpuJvMUFoonViSvaCdBknkrbo2Q@mail.gmail.com>
References: <cover.1480490191.git.lv.zheng@intel.com> <411c4b5987a902e037bf8c969513853dc960cc8a.1480490191.git.lv.zheng@intel.com>
 <CAA9_cmeUNuvfSSVWWiUt3PLG0WDUCw6m8uK4n5Doh3u_OtRDEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33678 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLHNSG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2016 08:18:06 -0500
In-Reply-To: <CAA9_cmeUNuvfSSVWWiUt3PLG0WDUCw6m8uK4n5Doh3u_OtRDEg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Bob Moore <robert.moore@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>

On Thu, Dec 8, 2016 at 2:11 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, Nov 29, 2016 at 11:21 PM, Lv Zheng <lv.zheng@intel.com> wrote:
>> ACPICA commit cac6790954d4d752a083e6122220b8a22febcd07
>>
>> This patch back ports Linux acpi_get_table_with_size() and
>> early_acpi_os_unmap_memory() into ACPICA upstream to reduce divergences.
>>
>> The 2 APIs are used by Linux as table management APIs for long time, it
>> contains a hidden logic that during the early stage, the mapped tables
>> should be unmapped before the early stage ends.
>>
>> During the early stage, tables are handled by the following sequence:
>>  acpi_get_table_with_size();
>>  parse the table
>>  early_acpi_os_unmap_memory();
>> During the late stage, tables are handled by the following sequence:
>>  acpi_get_table();
>>  parse the table
>> Linux uses acpi_gbl_permanent_mmap to distinguish the early stage and the
>> late stage.
>>
>> The reasoning of introducing acpi_get_table_with_size() is: ACPICA will
>> remember the early mapped pointer in acpi_get_table() and Linux isn't able to
>> prevent ACPICA from using the wrong early mapped pointer during the late
>> stage as there is no API provided from ACPICA to be an inverse of
>> acpi_get_table() to forget the early mapped pointer.
>>
>> But how ACPICA can work with the early/late stage requirement? Inside of
>> ACPICA, tables are ensured to be remained in "INSTALLED" state during the
>> early stage, and they are carefully not transitioned to "VALIDATED" state
>> until the late stage. So the same logic is in fact implemented inside of
>> ACPICA in a different way. The gap is only that the feature is not provided
>> to the OSPMs in an accessible external API style.
>>
>> It then is possible to fix the gap by providing an inverse of
>> acpi_get_table() from ACPICA, so that the two Linux sequences can be
>> combined:
>>  acpi_get_table();
>>  parse the table
>>  acpi_put_table();
>> In order to work easier with the current Linux code, acpi_get_table() and
>> acpi_put_table() is implemented in a usage counting based style:
>>  1. When the usage count of the table is increased from 0 to 1, table is
>>     mapped and .Pointer is set with the mapping address (VALIDATED);
>>  2. When the usage count of the table is decreased from 1 to 0, .Pointer
>>     is unset and the mapping address is unmapped (INVALIDATED).
>> So that we can deploy the new APIs to Linux with minimal effort by just
>> invoking acpi_get_table() in acpi_get_table_with_size() and invoking
>> acpi_put_table() in early_acpi_os_unmap_memory(). Lv Zheng.
>>
>> Link: https://github.com/acpica/acpica/commit/cac67909
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>
> This commit in -next (071b39575679 ACPICA: Tables: Back port
> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
> kernel) causes a regression in my nfit/nvdimm test environment. The
> nfit produced by QEMU no longer results in a nvdimm bus being created.
>
> I have not root caused it, but I'm using the following command line
> options to create an nfit in qemu-2.6.  Reverting the commit leads
> compile failures.

Would the build problems go away if you reverted "ACPICA: Tables:
Allow FADT to be customized with virtual address" (linux-next commit
cf334d3174f9) in addition to it?

Thanks,
Rafael
