From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2] ACPI/APEI: Update einj documentation for
 param1/param2
Date: Thu, 16 May 2013 13:07:05 +0200
Message-ID: <20130516110705.GD31373@pd.tnic>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-3-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56952 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902Ab3EPLHL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 May 2013 07:07:11 -0400
Content-Disposition: inline
In-Reply-To: <1368671347-22415-3-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Gong <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org

On Wed, May 15, 2013 at 10:29:07PM -0400, Chen Gong wrote:
> To ensure EINJ working well when injecting errors via EINJ
> table, add some attentions for param1/param2.
> 
> Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> ---
>  Documentation/acpi/apei/einj.txt |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/acpi/apei/einj.txt
> index e20b6da..80c4ab2 100644
> --- a/Documentation/acpi/apei/einj.txt
> +++ b/Documentation/acpi/apei/einj.txt
> @@ -47,11 +47,15 @@ directory apei/einj. The following files are provided.
>  
>  - param1
>    This file is used to set the first error parameter value. Effect of
> -  parameter depends on error_type specified.
> +  parameter depends on error_type specified. For exmaple, if error
> +  type is memory relatd type, the param1 should be a valid physical
> +  memory address.
>  
>  - param2
>    This file is used to set the second error parameter value. Effect of
> -  parameter depends on error_type specified.
> +  parameter depends on error_type specified. For example, if error
> +  type is memory relatd type, the param2 should be a valid physical
> +  memory address mask, say, 0xfffffffffffff000.
>  
>  - notrigger
>    The EINJ mechanism is a two step process. First inject the error, then

Please run those through the spell checker.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
