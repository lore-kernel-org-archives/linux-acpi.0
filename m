From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / resources: fix memory leak on request_range fail path
Date: Tue, 30 Jun 2015 17:09:03 +0200
Message-ID: <6932093.x3Q0TXN2Zp@vostro.rjw.lan>
References: <1435609020-18695-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65067 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752597AbbF3Oms (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2015 10:42:48 -0400
In-Reply-To: <1435609020-18695-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 29, 2015 09:17:00 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> static analysis from cppcheck detected a memory leak:
>   [drivers/acpi/resource.c:664]: (error) Memory leak: reg
> 
> the error path on a failed request_range call should free
> reg before returning. Bug introduced in the recent commit
> 0f1b414d190724617eb1cdd615592fa8cd9d0b50
> ("ACPI / PNP: Avoid conflicting resource reservations")
> 
> Fixes: 0f1b414d19 ("ACPI / PNP: Avoid conflicting resource reservations")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I have this fix queued up already as:

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=7bc10388ccdd79b3d20463151a1f8e7a590a775b

> ---
>  drivers/acpi/resource.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
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
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
