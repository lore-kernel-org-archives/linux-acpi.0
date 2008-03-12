From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] buffer array one byte too short in drivers/acpi/system.c
Date: Wed, 12 Mar 2008 18:23:24 -0400
Message-ID: <200803121823.24755.lenb@kernel.org>
References: <1204813853.25336.3.camel@localhost> <200803110305.33662.lenb@kernel.org> <1205250266.6930.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51944 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbYCLWXj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 18:23:39 -0400
In-Reply-To: <1205250266.6930.15.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johann Felix Soden <johfel@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Tuesday 11 March 2008, Johann Felix Soden wrote:
> On Tuesday 11 March 2008, Len Brown wrote:
> > On Thursday 06 March 2008, Johann Felix Soden wrote:
> > > From: Johann Felix Soden <johfel@users.sourceforge.net>
> > > 
> > > Since "ff_gbl_lock" has a length of 10 chars and is copied with sprintf to
> > > char buffer[10], there is a problem because of the closing zero byte. We
> > > need char buffer[11].
> > 
> > "ff_gbl_lock" is 11 characters, and sprintf adds a null, so
> > buffer should be 12, yes?
> 
> I have noticed my miscounting and have sent a new patch to you, Len
> Brown, some days ago. If it is needed anymore, below is the corrected
> patch again.
> 
> ---
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> Since "ff_gbl_lock" has a length of 11 chars and is copied with sprintf
> to char buffer[10], there is a problem. We need char buffer[12] because
> of the closing zero byte.
> 
> Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
> ---
>  drivers/acpi/system.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
> index 55cf4c0..4749f37 100644
> --- a/drivers/acpi/system.c
> +++ b/drivers/acpi/system.c
> @@ -319,7 +319,7 @@ void acpi_irq_stats_init(void)
>                 goto fail;
>  
>         for (i = 0; i < num_counters; ++i) {
> -               char buffer[10];
> +               char buffer[12];
>                 char *name;
>  
>                 if (i < num_gpes)

thanks for re-sending, i fixed the whitespace damage and checked it in.

BTW. the reason i didn't see your private re-send to my intel.com account
is b/c my intel.com mailbox is not the ideal place to send patches.
per http://www.lesswatts.org/projects/acpi/submitting-patches.php
I see patches send to the list, and patches sent to my kernel.org account.

thanks,
-Len

