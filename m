From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] buffer array one byte too short in drivers/acpi/system.c
Date: Tue, 11 Mar 2008 03:05:33 -0400
Message-ID: <200803110305.33662.lenb@kernel.org>
References: <1204813853.25336.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34011 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbYCKHFt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 11 Mar 2008 03:05:49 -0400
In-Reply-To: <1204813853.25336.3.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Johann Felix Soden <johfel@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Thursday 06 March 2008, Johann Felix Soden wrote:
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> Since "ff_gbl_lock" has a length of 10 chars and is copied with sprintf to
> char buffer[10], there is a problem because of the closing zero byte. We
> need char buffer[11].

"ff_gbl_lock" is 11 characters, and sprintf adds a null, so
buffer should be 12, yes?

looking at this code, i think i must have been asleep when i wrote it.
the strings such as "ff_gbl_lock" are in kernel data, and then
we copy to a local stack buffer, and then we copy to a heap
buffer -- when we should have just pointed to the data.
oh well, cleanup for .26...

> 
> Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
> ---
>  drivers/acpi/system.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
> index 55cf4c0..037b679 100644
> --- a/drivers/acpi/system.c
> +++ b/drivers/acpi/system.c
> @@ -319,7 +319,7 @@ void acpi_irq_stats_init(void)
>  		goto fail;
>  
>  	for (i = 0; i < num_counters; ++i) {
> -		char buffer[10];
> +		char buffer[11];
>  		char *name;
>  
>  		if (i < num_gpes)


