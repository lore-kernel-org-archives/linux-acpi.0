From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI / APEI: remove redundant variables len and node_len
Date: Tue, 28 Nov 2017 11:51:10 +0100
Message-ID: <20171128105110.hrfe6nh7hzmo5p4f@pd.tnic>
References: <20171015212454.16012-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171015212454.16012-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 15, 2017 at 10:24:54PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variables len and node_len are redundant and can be removed. Cleans
> up clang warning: node_len = GHES_ESTATUS_NODE_LEN(len);
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/apei/ghes.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3c3a37b8503b..f2e1049232c0 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -923,7 +923,6 @@ static void ghes_print_queued_estatus(void)
>  	struct ghes_estatus_node *estatus_node;
>  	struct acpi_hest_generic *generic;
>  	struct acpi_hest_generic_status *estatus;
> -	u32 len, node_len;
>  
>  	llnode = llist_del_all(&ghes_estatus_llist);
>  	/*
> @@ -935,8 +934,6 @@ static void ghes_print_queued_estatus(void)
>  		estatus_node = llist_entry(llnode, struct ghes_estatus_node,
>  					   llnode);
>  		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -		len = cper_estatus_len(estatus);
> -		node_len = GHES_ESTATUS_NODE_LEN(len);
>  		generic = estatus_node->generic;
>  		ghes_print_estatus(NULL, generic, estatus);
>  		llnode = llnode->next;
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
