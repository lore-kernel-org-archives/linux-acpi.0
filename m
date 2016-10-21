From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/apei: Fix in-correct return value
Date: Fri, 21 Oct 2016 23:28:29 +0200
Message-ID: <1979931.ATDSke4qB1@vostro.rjw.lan>
References: <20161018160719.31252-1-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59771 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S933253AbcJUVVb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 17:21:31 -0400
In-Reply-To: <20161018160719.31252-1-punit.agrawal@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, bp@suse.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, tbaicar@codeaurora.org, Len Brown <lenb@kernel.org>

On Tuesday, October 18, 2016 05:07:19 PM Punit Agrawal wrote:
> Although ghes_proc tests for error while reading the error status, it
> always return success (0). Fix this by propagating the return value.
> 
> Fixes: d334a49113a4a33 ("ACPI, APEI, Generic Hardware Error Source memory error support")
> Signed-of-by: Punit Agrawal <punit.agrawa.@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f0a029e..0d099a2 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -662,7 +662,7 @@ static int ghes_proc(struct ghes *ghes)
>  	ghes_do_proc(ghes, ghes->estatus);
>  out:
>  	ghes_clear_estatus(ghes);
> -	return 0;
> +	return rc;
>  }
>  
>  static void ghes_add_timer(struct ghes *ghes)
> 

Boris, all fine here?

Thanks,
Rafael

