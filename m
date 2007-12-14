From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2/8] git-acpi build fix
Date: Fri, 14 Dec 2007 01:24:32 +0100
Message-ID: <200712140124.33319.rjw@sisk.pl>
References: <200712132353.lBDNrXRG024821@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:36707 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934805AbXLNAFe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Dec 2007 19:05:34 -0500
In-Reply-To: <200712132353.lBDNrXRG024821@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Friday, 14 of December 2007, akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> ia64 allmodconfig:
> 
> kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)

I've already sent a better fix for that, thanks.


> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  kernel/power/main.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff -puN kernel/power/main.c~git-acpi-build-fix kernel/power/main.c
> --- a/kernel/power/main.c~git-acpi-build-fix
> +++ a/kernel/power/main.c
> @@ -489,9 +489,6 @@ static struct attribute * g[] = {
>  #ifdef CONFIG_PM_TRACE
>  	&pm_trace_attr.attr,
>  #endif
> -#ifdef CONFIG_PM_DEBUG
> -	&pm_test_attr.attr,
> -#endif
>  	NULL,
>  };
>  
> _
