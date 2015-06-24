From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [patch] ACPI / resources: free memory on error in add_region_before()
Date: Wed, 24 Jun 2015 23:57:52 +0200
Message-ID: <1965684.FcqIK5OKHD@vostro.rjw.lan>
References: <20150624143015.GD1702@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62247 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750884AbbFXVbo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jun 2015 17:31:44 -0400
In-Reply-To: <20150624143015.GD1702@mwanda>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wednesday, June 24, 2015 05:30:15 PM Dan Carpenter wrote:
> There is a small memory leak on error.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks!

> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index fcb7807..10561ce 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -660,8 +660,10 @@ static int add_region_before(u64 start, u64 end, u8 space_id,
>  		return -ENOMEM;
>  
>  	error = request_range(start, end, space_id, flags, desc);
> -	if (error)
> +	if (error) {
> +		kfree(reg);
>  		return error;
> +	}
>  
>  	reg->start = start;
>  	reg->end = end;

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
