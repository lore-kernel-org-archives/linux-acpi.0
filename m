From: Len Brown <lenb@kernel.org>
Subject: Re: + git-acpi-arch-x86-kernel-apm_32c-fix-warning.patch added to -mm tree
Date: Thu, 27 Mar 2008 02:09:06 -0400
Message-ID: <200803270209.06421.lenb@kernel.org>
References: <200803190209.m2J29WW4026805@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40360 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399AbYC0GJz (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 02:09:55 -0400
In-Reply-To: <200803190209.m2J29WW4026805@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org, Linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>
Cc: mm-commits@vger.kernel.org

Ah, this was caused by "PM: Remove legacy PM"

folded onto that branch.

this one points out a bug in my build system,
since this warning message didn't make it into
my summary file.

thanks,
-Len

On Tuesday 18 March 2008, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      git-acpi: arch/x86/kernel/apm_32.c: fix warning
> has been added to the -mm tree.  Its filename is
>      git-acpi-arch-x86-kernel-apm_32c-fix-warning.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: git-acpi: arch/x86/kernel/apm_32.c: fix warning
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> arch/x86/kernel/apm_32.c:1215: warning: label 'out' defined but not used
> 
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/x86/kernel/apm_32.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff -puN arch/x86/kernel/apm_32.c~git-acpi-arch-x86-kernel-apm_32c-fix-warning arch/x86/kernel/apm_32.c
> --- a/arch/x86/kernel/apm_32.c~git-acpi-arch-x86-kernel-apm_32c-fix-warning
> +++ a/arch/x86/kernel/apm_32.c
> @@ -1212,7 +1212,6 @@ static int suspend(int vetoable)
>  	local_irq_enable();
>  	device_resume();
>  	queue_event(APM_NORMAL_RESUME, NULL);
> - out:
>  	spin_lock(&user_list_lock);
>  	for (as = user_list; as != NULL; as = as->next) {
>  		as->suspend_wait = 0;
> _
> 
