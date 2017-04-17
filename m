From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] acpica: trivial changes on comments
Date: Mon, 17 Apr 2017 10:58:30 +0800
Message-ID: <58F42F56.2070809@cn.fujitsu.com>
References: <1492397781-18584-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:3405 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932274AbdDQC6M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Apr 2017 22:58:12 -0400
In-Reply-To: <1492397781-18584-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org

Re-to: linux-acpi@vger.kernel.org

On 04/17/2017 10:56 AM, Cao jin wrote:
> Remove superfluous word; unify comments and function prototype.
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/acpi/acpica/tbfadt.c  | 2 +-
>  drivers/acpi/acpica/tbutils.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
> index 51860bf..ba5fcbe 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -449,7 +449,7 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
>   * The 64-bit X fields are optional extensions to the original 32-bit FADT
>   * V1.0 fields. Even if they are present in the FADT, they are optional and
>   * are unused if the BIOS sets them to zero. Therefore, we must copy/expand
> - * 32-bit V1.0 fields to the 64-bit X fields if the the 64-bit X field is
> + * 32-bit V1.0 fields to the 64-bit X fields if the 64-bit X field is
>   * originally zero.
>   *
>   * For ACPI 1.0 FADTs (that contain no 64-bit addresses), all 32-bit address
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 5a968a7..e05555c 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -141,7 +141,7 @@ void acpi_tb_check_dsdt_header(void)
>   *
>   * FUNCTION:    acpi_tb_copy_dsdt
>   *
> - * PARAMETERS:  table_desc          - Installed table to copy
> + * PARAMETERS:  table_index         - Index of installed table to copy
>   *
>   * RETURN:      None
>   *
> @@ -239,7 +239,7 @@ acpi_tb_get_root_table_entry(u8 *table_entry, u32 table_entry_size)
>   *
>   * FUNCTION:    acpi_tb_parse_root_table
>   *
> - * PARAMETERS:  rsdp                    - Pointer to the RSDP
> + * PARAMETERS:  rsdp_address            - Pointer to the RSDP
>   *
>   * RETURN:      Status
>   *
> 

-- 
Sincerely,
Cao jin


