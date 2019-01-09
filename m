From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: table override from built-in initrd
Date: Wed, 9 Jan 2019 02:28:00 +0000
Message-ID: <dc56c63fba6c410b9fd35a4ebe11ce07@HXTBJIDCEMVIW02.hxtcorp.net>
References: <1545112965-2692-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Rafael,

Gentle ping for this patch.

Thanks.
Shunyong.

On 2018/12/18 14:02, Yang, Shunyong wrote:
> In some scenario, we need to build initrd with kernel in a single image.
> This can simplify system deployment process by downloading the whole system
> once, such as in IC verification.
> 
> This patch adds support to override ACPI tables from built-in initrd.
> 
> Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> ---
> v2: change "upgrade" to "override" as it's more accurate
> ---
>  Documentation/acpi/initrd_table_override.txt |  4 ++++
>  drivers/acpi/Kconfig                         | 10 ++++++++++
>  drivers/acpi/tables.c                        | 12 ++++++++++--
>  include/linux/initrd.h                       |  3 +++
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/initrd_table_override.txt b/Documentation/acpi/initrd_table_override.txt
> index eb651a6aa285..324d5fb90a22 100644
> --- a/Documentation/acpi/initrd_table_override.txt
> +++ b/Documentation/acpi/initrd_table_override.txt
> @@ -14,6 +14,10 @@ upgrade the ACPI execution environment that is defined by the ACPI tables
>  via upgrading the ACPI tables provided by the BIOS with an instrumented,
>  modified, more recent version one, or installing brand new ACPI tables.
>  
> +When building initrd with kernel in a single image, option
> +ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD should also be true for this
> +purpose.
> +
>  For a full list of ACPI tables that can be upgraded/installed, take a look
>  at the char *table_sigs[MAX_ACPI_SIGNATURE]; definition in
>  drivers/acpi/tables.c.
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7cea769c37df..3b362a1c7685 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -357,6 +357,16 @@ config ACPI_TABLE_UPGRADE
>  	  initrd, therefore it's safe to say Y.
>  	  See Documentation/acpi/initrd_table_override.txt for details
>  
> +config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
> +	bool "Override ACPI tables from built-in initrd"
> +	depends on ACPI_TABLE_UPGRADE
> +	depends on INITRAMFS_SOURCE!="" && INITRAMFS_COMPRESSION=""
> +	def_bool n
> +	help
> +	  This option provides functionality to override arbitrary ACPI tables
> +	  from built-in uncompressed initrd.
> +	  See Documentation/acpi/initrd_table_override.txt for details
> +
>  config ACPI_DEBUG
>  	bool "Debug Statements"
>  	help
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 61203eebf3a1..f6a2c5ebabcd 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -473,14 +473,22 @@ static u8 __init acpi_table_checksum(u8 *buffer, u32 length)
>  
>  void __init acpi_table_upgrade(void)
>  {
> -	void *data = (void *)initrd_start;
> -	size_t size = initrd_end - initrd_start;
> +	void *data;
> +	size_t size;
>  	int sig, no, table_nr = 0, total_offset = 0;
>  	long offset = 0;
>  	struct acpi_table_header *table;
>  	char cpio_path[32] = "kernel/firmware/acpi/";
>  	struct cpio_data file;
>  
> +	if (IS_ENABLED(CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD)) {
> +		data = __initramfs_start;
> +		size = __initramfs_size;
> +	} else {
> +		data = (void *)initrd_start;
> +		size = initrd_end - initrd_start;
> +	}
> +
>  	if (data == NULL || size == 0)
>  		return;
>  
> diff --git a/include/linux/initrd.h b/include/linux/initrd.h
> index 84b423044088..02d94aae54c7 100644
> --- a/include/linux/initrd.h
> +++ b/include/linux/initrd.h
> @@ -22,3 +22,6 @@
>  extern void free_initrd_mem(unsigned long, unsigned long);
>  
>  extern unsigned int real_root_dev;
> +
> +extern char __initramfs_start[];
> +extern unsigned long __initramfs_size;
> 
