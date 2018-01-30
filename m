From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Date: Tue, 30 Jan 2018 01:44:32 +0000
Message-ID: <1517276662.2652.12.camel@hxt-semitech.com>
References: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
Content-Language: en-US
Content-ID: <F5732FE6EC49F34AB83E1BE5353D4D01@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
List-Id: linux-acpi@vger.kernel.org

Hi, Rafael

Could you please help to review this patch? This is a small change to
add ACPI_SIG_IORT to table_sigs[]. 
Loading IORT table from initrd is very useful to debug SMMU node/device
probe, MSI allocation, stream id translation and verifying IORT table
from firmware. So, I add this.

Thanks
Shunyong.

On Tue, 2018-01-23 at 16:25 +0800, Yang Shunyong wrote:
> This patch adds ACPI_SIG_IORT to the table, which enables IORT from
> initrd to override which from firmware.
> 
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Cc: yutang2.jiang@hxt-semitech.com
> Cc: yu.zheng@hxt-semitech.com
> ---
> 
> v2: change typo ACPI_SIG_PPTT to ACPI_SIG_IORT in commit message.
> 
> ---
>  drivers/acpi/tables.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 80ce2a7d224b..7bcb66ccccf3 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -456,7 +456,8 @@ static u8 __init acpi_table_checksum(u8 *buffer,
> u32 length)
>  	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
>  	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
>  	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
> -	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
> +	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
> +	NULL };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
