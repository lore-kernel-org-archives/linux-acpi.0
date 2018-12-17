From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Date: Mon, 17 Dec 2018 09:17:21 +0000
Message-ID: <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Rafael,
  I think "override" is more accurate. I just follow the existing
description of "ACPI_TABLE_UPGRADE" in drivers/acpi/Kconfig.
  Should I change all upgrade/UPGRADE to "override/OVERRIDE" in this patch?

Thanks.
Shunyong.

On 2018/12/17 17:03, Rafael J. Wysocki wrote:
> On Mon, Dec 17, 2018 at 3:40 AM Shunyong Yang
> <shunyong.yang@hxt-semitech.com> wrote:
>>
>> In some scenario, we need to build initrd with kernel in a single image.
>> This can simplify system deployment process by downloading the whole system
>> once, such as in IC verification.
>>
>> This patch adds support to upgrade ACPI tables from built-in initrd.
> 
> What do you mean by "upgrade"?
> 
>>
>> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
>> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
>> ---
>>  drivers/acpi/Kconfig   |  9 +++++++++
>>  drivers/acpi/tables.c  | 12 ++++++++++--
>>  include/linux/initrd.h |  3 +++
>>  3 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 7cea769c37df..30976496fe77 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -357,6 +357,15 @@ config ACPI_TABLE_UPGRADE
>>           initrd, therefore it's safe to say Y.
>>           See Documentation/acpi/initrd_table_override.txt for details
>>
>> +config ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD
>> +       bool "Upgrade ACPI tables from built-in initrd"
>> +       depends on ACPI_TABLE_UPGRADE
>> +       depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
>> +       def_bool n
>> +       help
>> +         This option provides functionality to upgrade arbitrary ACPI tables
>> +         from built-in uncompressed initrd.
>> +
>>  config ACPI_DEBUG
>>         bool "Debug Statements"
>>         help
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 61203eebf3a1..88e3a34443da 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>>
>>  void __init acpi_table_upgrade(void)
>>  {
>> -       void *data = (void *)initrd_start;
>> -       size_t size = initrd_end - initrd_start;
>> +       void *data;
>> +       size_t size;
>>         int sig, no, table_nr = 0, total_offset = 0;
>>         long offset = 0;
>>         struct acpi_table_header *table;
>>         char cpio_path[32] = "kernel/firmware/acpi/";
>>         struct cpio_data file;
>>
>> +       if (IS_ENABLED(CONFIG_ACPI_TABLE_UPGRADE_VIA_BUILTIN_INITRD)) {
>> +               data = __initramfs_start;
>> +               size = __initramfs_size;
>> +       } else {
>> +               data = (void *)initrd_start;
>> +               size = initrd_end - initrd_start;
>> +       }
>> +
>>         if (data == NULL || size == 0)
>>                 return;
>>
>> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
>> index 84b423044088..02d94aae54c7 100644
>> --- a/include/linux/initrd.h
>> +++ b/include/linux/initrd.h
>> @@ -22,3 +22,6 @@
>>  extern void free_initrd_mem(unsigned long, unsigned long);
>>
>>  extern unsigned int real_root_dev;
>> +
>> +extern char __initramfs_start[];
>> +extern unsigned long __initramfs_size;
>> --
>> 1.8.3.1
>>
> 
