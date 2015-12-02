From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI / extlog: don't dereference extlog_l1_addr if it is
 null
Date: Wed, 2 Dec 2015 13:12:20 +0100
Message-ID: <20151202121220.GA3910@pd.tnic>
References: <1449057508-10172-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45332 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544AbbLBMMY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Dec 2015 07:12:24 -0500
Content-Disposition: inline
In-Reply-To: <1449057508-10172-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>, Tony Luck <tony.luck@intel.com>

CCing authors too.

On Wed, Dec 02, 2015 at 11:58:28AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a check to see if extlog_l1_addr is null before calling
> acpi_os_unmap_iomem, however, before that call there is a
> dereference on this that could trip an oops.  Move the
> extlog_l1_addr dereference so it occurs only if it is not null.
> 
> Found by static analysis by smatch.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/acpi_extlog.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index b3842ff..183b7b2 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -309,9 +309,10 @@ static void __exit extlog_exit(void)
>  {
>  	set_edac_report_status(old_edac_report_status);
>  	mce_unregister_decode_chain(&extlog_mce_dec);
> -	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
> -	if (extlog_l1_addr)
> +	if (extlog_l1_addr) {
> +		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>  		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
> +	}
>  	if (elog_addr)
>  		acpi_os_unmap_iomem(elog_addr, elog_size);
>  	release_mem_region(elog_base, elog_size);
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
