From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: blacklist: fix name of ThinkPad Edge E530
Date: Wed, 06 Nov 2013 23:06:50 +0100
Message-ID: <1895603.0MsctzP0MN@vostro.rjw.lan>
References: <1383636042-15440-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62815 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755020Ab3KFVyb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2013 16:54:31 -0500
In-Reply-To: <1383636042-15440-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday, November 05, 2013 01:20:42 AM Felipe Contreras wrote:
> That is the advertised name.
> 
> http://shop.lenovo.com/us/en/laptops/thinkpad/edge-series/e530/
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Applied, thanks!

> ---
>  drivers/acpi/blacklist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index b7fd1ae..fb84837 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -304,7 +304,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  	{
>  	.callback = dmi_disable_osi_win8,
> -	.ident = "Lenovo ThinkPad Edge E530",
> +	.ident = "ThinkPad Edge E530",
>  	.matches = {
>  		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>  		     DMI_MATCH(DMI_PRODUCT_VERSION, "3259A2G"),
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
