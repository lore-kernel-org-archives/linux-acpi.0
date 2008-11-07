From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 3/3] acpi: use macro to replace hard number
Date: Thu, 06 Nov 2008 21:51:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811062151060.3106@localhost.localdomain>
References: <200810292113.m9TLDMY1016626@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:59278 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbYKGCvP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 21:51:15 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9X002OGZXDRGT1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 20:51:15 -0600 (CST)
In-reply-to: <200810292113.m9TLDMY1016626@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, yinghai@kernel.org

applied.

thanks,
-lenl

On Wed, 29 Oct 2008, akpm@linux-foundation.org wrote:

> From: Yinghai Lu <yinghai@kernel.org>
> 
> Impact: cleanup
> 
> Use MACRO for rev 3 fadt id instead of 3 directly.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/tables/tbfadt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/acpi/tables/tbfadt.c~acpi-use-macro-to-replace-hard-number drivers/acpi/tables/tbfadt.c
> --- a/drivers/acpi/tables/tbfadt.c~acpi-use-macro-to-replace-hard-number
> +++ a/drivers/acpi/tables/tbfadt.c
> @@ -304,7 +304,7 @@ static void acpi_tb_convert_fadt(void)
>  	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
>  	 * offset 45, 55, 95, and the word located at offset 109, 110.
>  	 */
> -	if (acpi_gbl_FADT.header.revision < 3) {
> +	if (acpi_gbl_FADT.header.revision < FADT2_REVISION_ID) {
>  		acpi_gbl_FADT.preferred_profile = 0;
>  		acpi_gbl_FADT.pstate_control = 0;
>  		acpi_gbl_FADT.cst_control = 0;
> _
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
