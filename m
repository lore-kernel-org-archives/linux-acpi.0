From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / APEI: use setup_deferrable_timer
Date: Tue, 18 Apr 2017 16:41:55 +0200
Message-ID: <2055010.LqQYKbg0T9@aspire.rjw.lan>
References: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42730 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753098AbdDROsA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Apr 2017 10:48:00 -0400
In-Reply-To: <3afa5498142ef68256023257dad37b9f8352e65e.1489060803.git.geliangtang@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>, Borislav Petkov <bp@suse.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday, March 11, 2017 08:46:55 AM Geliang Tang wrote:
> Use setup_deferrable_timer() instead of init_timer_deferrable() to
> simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Boris, Tony, any concerns?

If not, do you want to route this through the RAS tree?

> ---
>  drivers/acpi/apei/ghes.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b192b42..33ca196 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1005,9 +1005,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>  
>  	switch (generic->notify.type) {
>  	case ACPI_HEST_NOTIFY_POLLED:
> -		ghes->timer.function = ghes_poll_func;
> -		ghes->timer.data = (unsigned long)ghes;
> -		init_timer_deferrable(&ghes->timer);
> +		setup_deferrable_timer(&ghes->timer, ghes_poll_func,
> +				       (unsigned long)ghes);
>  		ghes_add_timer(ghes);
>  		break;
>  	case ACPI_HEST_NOTIFY_EXTERNAL:
> 

