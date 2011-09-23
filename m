From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI / PM: Blacklist Vaio VGN-FW520F machine known to require acpi_sleep=nonvs
Date: Sat, 24 Sep 2011 00:05:44 +0200
Message-ID: <201109240005.44987.rjw@sisk.pl>
References: <CAKu+J91Apx2YWfYC=u=kZ_dD9jSvtHvPg1UgxUPiJeBchh-YRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52548 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab1IWWDe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Sep 2011 18:03:34 -0400
In-Reply-To: <CAKu+J91Apx2YWfYC=u=kZ_dD9jSvtHvPg1UgxUPiJeBchh-YRQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Len Brown (Intel)" <len.brown@intel.com>
Cc: Bogdan Radulescu <bogdan@nimblex.net>, lenb@kernel.org, linux-acpi@vger.kernel.org

Hi Len,

I sent one blacklist entry like this too some time ago with no response from
you.

Would you mind if I took those things into the linux-pm tree?

Rafael


On Thursday, September 22, 2011, Bogdan Radulescu wrote:
> Sony Vaio VGN-FW520F does not resume correctly without
> acpi_sleep=nonvs, so add it to the ACPI sleep blacklist.
> References: https://bugzilla.kernel.org/show_bug.cgi?id=16396#c86
> 
> Signed-off-by: Bogdan Radulescu <bogdan@nimblex.net>
> 
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

