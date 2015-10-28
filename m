From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/PAD: power_saving_thread() is not freezable
Date: Wed, 28 Oct 2015 04:18:52 +0100
Message-ID: <2245965.qHtce5ZjLr@vostro.rjw.lan>
References: <alpine.LNX.2.00.1510260358500.21100@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53930 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754945AbbJ1Ctz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Oct 2015 22:49:55 -0400
In-Reply-To: <alpine.LNX.2.00.1510260358500.21100@pobox.suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Monday, October 26, 2015 04:02:01 AM Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> power_saving_thread() calls try_to_freeze(), but the thread doesn't mark
> itself freezable through set_freezable(), so the try_to_freeze()
> call is useless.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
>  drivers/acpi/acpi_pad.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index ae307ff..8ea8211 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -148,8 +148,6 @@ static int power_saving_thread(void *data)
>  	while (!kthread_should_stop()) {
>  		unsigned long expire_time;
>  
> -		try_to_freeze();
> -
>  		/* round robin to cpus */
>  		expire_time = last_jiffies + round_robin_time * HZ;
>  		if (time_before(expire_time, jiffies)) {
> 

Applied, thanks!

Rafael

