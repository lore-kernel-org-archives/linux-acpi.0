From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / blacklist: add _REV quirks for Dell Precision 5520 and 3520
Date: Thu, 24 Nov 2016 02:24:30 +0100
Message-ID: <2029425.jvXE7HsEk1@vostro.rjw.lan>
References: <1477680844-13965-1-git-send-email-alex.hung@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48958 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934630AbcKXBQo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:16:44 -0500
In-Reply-To: <1477680844-13965-1-git-send-email-alex.hung@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Hung <alex.hung@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Friday, October 28, 2016 11:54:04 AM Alex Hung wrote:
> Precision 5520 and 3520 either hang at login and during suspend or reboot.
> This may be related to https://bugzilla.kernel.org/show_bug.cgi?id=156341
> but adding them to acpi_rev_dmi_table is able to workound it now.
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/acpi/blacklist.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index bdc67ba..4f87fd7 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -160,6 +160,22 @@ static struct dmi_system_id acpi_rev_dmi_table[] __initdata = {
>  		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
>  		},
>  	},
> +	{
> +	 .callback = dmi_enable_rev_override,
> +	 .ident = "DELL Precision 5520",
> +	 .matches = {
> +		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		      DMI_MATCH(DMI_PRODUCT_NAME, "Precision 5520"),
> +		},
> +	},
> +	{
> +	 .callback = dmi_enable_rev_override,
> +	 .ident = "DELL Precision 3520",
> +	 .matches = {
> +		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		      DMI_MATCH(DMI_PRODUCT_NAME, "Precision 3520"),
> +		},
> +	},
>  #endif
>  	{}
>  };
> 

Applied.

Thanks,
Rafael

