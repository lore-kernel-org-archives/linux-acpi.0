From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI: blacklist win8 OSI for Dell Inspiron 7737
Date: Thu, 08 May 2014 01:44:23 +0200
Message-ID: <6691960.kgVlUdZ4Ty@vostro.rjw.lan>
References: <1399430844-7006-1-git-send-email-yidi.lin@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63769 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751658AbaEGX1n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 May 2014 19:27:43 -0400
In-Reply-To: <1399430844-7006-1-git-send-email-yidi.lin@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Edward Lin <yidi.lin@canonical.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, yk@canonical.com

On Wednesday, May 07, 2014 10:47:24 AM Edward Lin wrote:
> With win8 capabiltiy, the machine will boot itself immediately after shutdown command has executed.
> Work around this issue by disabling win8 capcability.
> This workaround also makes wireless hotkey work.
> 
> ChangeLog (v1 -> v2):
>  - fix typos in commit message
> 
> Signed-off-by: Edward Lin <yidi.lin@canonical.com>

Queued up for 3.15 and -stable, thanks!

> ---
>  drivers/acpi/blacklist.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index afec452..4fc6cf5 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -314,6 +314,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
>  		     DMI_MATCH(DMI_PRODUCT_VERSION, "2349D15"),
>  		},
>  	},
> +	{
> +	.callback = dmi_disable_osi_win8,
> +	.ident = "Dell Inspiron 7737",
> +	.matches = {
> +		    DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		    DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7737"),
> +		},
> +	},
>  
>  	/*
>  	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
