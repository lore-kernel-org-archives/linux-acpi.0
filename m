From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI / tables: Move table override mechanisms to tables.c
Date: Wed, 13 Apr 2016 06:24:05 +0200
Message-ID: <CAJZ5v0jN6bR8cnh=JUNma83FwVK6vVGGj2opCT3k5O0qtoNUyg@mail.gmail.com>
References: <cover.1460100857.git.lv.zheng@intel.com>
	<3ef8c14e35fc835260f2f2c62a2227e7b570be24.1460100857.git.lv.zheng@intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BB7E62D@SHSMSX101.ccr.corp.intel.com>
	<CAJZ5v0jV_b7BxPBGRPVPNx47FR+sqYv=ZFCNuZO+MBUK-u2yqA@mail.gmail.com>
	<1AE640813FDE7649BE1B193DEA596E883BB7E94A@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35239 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbcDMEYI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Apr 2016 00:24:08 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB7E94A@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Apr 12, 2016 at 1:27 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
>> Rafael J. Wysocki
>> Sent: Monday, April 11, 2016 9:31 PM
>> Subject: Re: [PATCH 1/3] ACPI / tables: Move table override mechanisms to
>> tables.c
>>
>> On Mon, Apr 11, 2016 at 4:16 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
>> > Hi, Rafael
>>
>> Hi,
>>
>> >> From: Zheng, Lv
>> >> Subject: [PATCH 1/3] ACPI / tables: Move table override mechanisms to
>> >> tables.c
>> >>
>> >> This patch moves acpi_os_table_override() and
>> >> acpi_os_physical_table_override() to tables.c.
>> >>
>>
>> [cut]
>>
>> >>  #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
>> >> -void acpi_initrd_override(void *data, size_t size);
>> >> +void early_acpi_table_init(void *data, size_t size);
>> >>  #else
>> >> -static inline void acpi_initrd_override(void *data, size_t size)
>> >> +static inline void early_acpi_table_init(void *data, size_t size)
>> >>  {
>> >>  }
>> >>  #endif
>> > [Lv Zheng]
>> > This block was wrong.
>> > early_acpi_table_init() is no longer dependent on
>> CONFIG_ACPI_INITRD_TABLE_OVERRIDE but dependent on CONFIG_ACPI.
>>
>> I see.
>>
>> > Updated v2 patches are sent to the mailing list.
>>
>> Is this the only difference between v1 and v2?
>
> [Lv Zheng]
> One of the follow-up patches (PATCH 3) in this series is updated accordingly.

OK, thanks.

It generally is good to add that type of information to the patches in
the new version (in an additional section below the sign-off tag).

Thanks,
Rafael
