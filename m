From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI / PM: Blacklist Vaio VGN-FW520F machine known to require acpi_sleep=nonvs
Date: Wed, 5 Oct 2011 22:47:29 +0200
Message-ID: <201110052247.29763.rjw@sisk.pl>
References: <CAKu+J91Apx2YWfYC=u=kZ_dD9jSvtHvPg1UgxUPiJeBchh-YRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:50250 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab1JEUpM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Oct 2011 16:45:12 -0400
In-Reply-To: <CAKu+J91Apx2YWfYC=u=kZ_dD9jSvtHvPg1UgxUPiJeBchh-YRQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bogdan Radulescu <bogdan@nimblex.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Thursday, September 22, 2011, Bogdan Radulescu wrote:
> Sony Vaio VGN-FW520F does not resume correctly without
> acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.
> References: https://bugzilla.kernel.org/show_bug.cgi?id=16396#c86
> 
> Signed-off-by: Bogdan Radulescu <bogdan@nimblex.net>

Applied to linux-pm/linux-next.  I'm going to push this patch for 3.2.

Thanks,
Rafael


> ---
> --- sleep.c.orig        2011-09-21 08:36:08.000000000 +0300
> +++ sleep.c     2011-09-21 08:40:23.000000000 +0300
> @@ -428,6 +428,14 @@ static struct dmi_system_id __initdata a
>                DMI_MATCH(DMI_PRODUCT_NAME, "1000 Series"),
>                },
>        },
> +       {
> +       .callback = init_nvs_nosave,
> +       .ident = "Sony Vaio VGN-FW520F",
> +       .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FW520F"),
> +               },
> +       },
>        {},
>  };
>  #endif /* CONFIG_SUSPEND */
> ---
> 
> 

