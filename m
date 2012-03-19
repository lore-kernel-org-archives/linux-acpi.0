From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] ACPI, psargs: Fix small mem leaks on error paths
Date: Mon, 19 Mar 2012 23:11:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1203192311280.9012@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1202050210060.30244@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1202050210060.30244@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Ping?

On Sun, 5 Feb 2012, Jesper Juhl wrote:

> As far as I can see, there are two small mem leaks in error paths of
> 'acpi_ps_get_next_field()' where we neglect to free the memory
> previously allocated to 'field'.
> 
> I believe this patch should fix the leaks.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  drivers/acpi/acpica/psargs.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
>  Note: Compile tested only.
> 
> diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
> index 5ac36ab..a683d66 100644
> --- a/drivers/acpi/acpica/psargs.c
> +++ b/drivers/acpi/acpica/psargs.c
> @@ -618,6 +618,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
>  
>  				arg = acpi_ps_alloc_op(AML_INT_BYTELIST_OP);
>  				if (!arg) {
> +					acpi_ps_free_op(field);
>  					return_PTR(NULL);
>  				}
>  
> @@ -662,6 +663,7 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
>  		} else {
>  			arg = acpi_ps_alloc_op(AML_INT_NAMEPATH_OP);
>  			if (!arg) {
> +				acpi_ps_free_op(field);
>  				return_PTR(NULL);
>  			}
>  
> 

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
