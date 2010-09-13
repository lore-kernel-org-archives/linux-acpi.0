From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: sleep: init_set_sci_en_on_resume for Dell Studio 155x
Date: Mon, 13 Sep 2010 19:34:15 +0200
Message-ID: <201009131934.16027.rjw@sisk.pl>
References: <1272498183-6094-1-git-send-email-kamal@canonical.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50959 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab0IMRfZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Sep 2010 13:35:25 -0400
In-Reply-To: <1272498183-6094-1-git-send-email-kamal@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Zhang Rui <rui.zhang@intel.com>

On Thursday, April 29, 2010, Kamal Mostafa wrote:
> Add Dell Studio models (1558, 1557, 1555) to the 'set_sci_en_on_resume'
> list to fix hang on resume.
> 
> BugLink: http://bugs.launchpad.net/bugs/553498

This check was removed by commit b6dacf63e9fb2e7a1369843d6cef332f76fca6a3
(ACPI: Unconditionally set SCI_EN on resume), so the patch shouldn't be
necessary.

Thanks,
Rafael


> Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> Acked-by: Alex Chiang <achiang@canonical.com>
> Cc: stable@kernel.org
> ---
>  drivers/acpi/sleep.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index f74834a..d907c8a 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -458,6 +458,30 @@ static struct dmi_system_id __initdata acpisleep_dmi_table[] = {
>  		DMI_MATCH(DMI_BOARD_NAME, "CF51-2L"),
>  		},
>  	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Dell Studio 1558",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1558"),
> +		},
> +	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Dell Studio 1557",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1557"),
> +		},
> +	},
> +	{
> +	.callback = init_set_sci_en_on_resume,
> +	.ident = "Dell Studio 1555",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1555"),
> +		},
> +	},
>  	{},
>  };
>  #endif /* CONFIG_SUSPEND */
> 

