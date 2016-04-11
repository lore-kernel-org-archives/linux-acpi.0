From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI / tables: Move table override mechanisms to tables.c
Date: Mon, 11 Apr 2016 15:31:10 +0200
Message-ID: <CAJZ5v0jV_b7BxPBGRPVPNx47FR+sqYv=ZFCNuZO+MBUK-u2yqA@mail.gmail.com>
References: <cover.1460100857.git.lv.zheng@intel.com>
	<3ef8c14e35fc835260f2f2c62a2227e7b570be24.1460100857.git.lv.zheng@intel.com>
	<1AE640813FDE7649BE1B193DEA596E883BB7E62D@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB7E62D@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 11, 2016 at 4:16 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi, Rafael

Hi,

>> From: Zheng, Lv
>> Subject: [PATCH 1/3] ACPI / tables: Move table override mechanisms to
>> tables.c
>>
>> This patch moves acpi_os_table_override() and
>> acpi_os_physical_table_override() to tables.c.
>>

[cut]

>>  #ifdef CONFIG_ACPI_INITRD_TABLE_OVERRIDE
>> -void acpi_initrd_override(void *data, size_t size);
>> +void early_acpi_table_init(void *data, size_t size);
>>  #else
>> -static inline void acpi_initrd_override(void *data, size_t size)
>> +static inline void early_acpi_table_init(void *data, size_t size)
>>  {
>>  }
>>  #endif
> [Lv Zheng]
> This block was wrong.
> early_acpi_table_init() is no longer dependent on CONFIG_ACPI_INITRD_TABLE_OVERRIDE but dependent on CONFIG_ACPI.

I see.

> Updated v2 patches are sent to the mailing list.

Is this the only difference between v1 and v2?

Thanks,
Rafael
