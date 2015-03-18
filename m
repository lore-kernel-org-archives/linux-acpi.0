From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Disable Vista compatibility for Sony VGN-SR19XN.
Date: Wed, 18 Mar 2015 16:26:36 +0100
Message-ID: <2157149.H3y1JMFiCM@vostro.rjw.lan>
References: <1426498518-9853-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56247 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754880AbbCRPCl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2015 11:02:41 -0400
In-Reply-To: <1426498518-9853-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Monday, March 16, 2015 05:35:18 PM Chen Yu wrote:
> Sony VGN-SR19XN laptop needs to disable windows vista compatibility,
> or else it freezes when plugging/unplugging the VGA connector.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=66771
> 
> Tested-by: Lionel Duriez <lionelduriez@hotmail.com>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Queued up as a fix for 4.0-rc5, thanks!

> ---
>  drivers/acpi/blacklist.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 9b693d5..1d17919 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -215,6 +215,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  	},
>  	{
>  	.callback = dmi_disable_osi_vista,
> +	.ident = "VGN-SR19XN",
> +	.matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "VGN-SR19XN"),
> +		},
> +	},
> +	{
> +	.callback = dmi_disable_osi_vista,
>  	.ident = "Toshiba Satellite L355",
>  	.matches = {
>  		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
