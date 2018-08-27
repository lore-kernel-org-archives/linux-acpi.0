From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH] mailbox: PCC: handle parse error
Date: Mon, 27 Aug 2018 14:55:41 -0600
Message-ID: <e9d05632-dae6-b904-fe62-d617b3dfe3fd@redhat.com>
References: <1535397548-69588-1-git-send-email-darcari@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535397548-69588-1-git-send-email-darcari@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 08/27/2018 01:19 PM, David Arcari wrote:
> acpi_pcc_probe calls acpi_table_parse_entries_array but fails to check
> for an error return.  This in turn can result in calling kcalloc with
> a negative count as well as emitting the following misleading erorr
> message:
> 
> [    2.642015] Could not allocate space for PCC mbox channels
> 
> Fixes: 8f8027c5f935 ("mailbox: PCC: erroneous error message when parsing ACPI PCCT")
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Al Stone <ahs3@redhat.com>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> ---
>  drivers/mailbox/pcc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 311e91b..256f18b 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -461,8 +461,11 @@ static int __init acpi_pcc_probe(void)
>  	count = acpi_table_parse_entries_array(ACPI_SIG_PCCT,
>  			sizeof(struct acpi_table_pcct), proc,
>  			ACPI_PCCT_TYPE_RESERVED, MAX_PCC_SUBSPACES);
> -	if (count == 0 || count > MAX_PCC_SUBSPACES) {
> -		pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
> +	if (count <= 0 || count > MAX_PCC_SUBSPACES) {
> +		if (count < 0)
> +			pr_warn("Error parsing PCC subspaces from PCCT\n");
> +		else
> +			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
>  		return -EINVAL;
>  	}
>  
> 

Thanks, David.  Nice catch.

Reviewed-by: Al Stone <ahs3@redhat.com>

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
