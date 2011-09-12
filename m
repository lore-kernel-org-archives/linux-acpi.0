From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/5] ACPI processor: Avoid WARN message on processor
 driver removal
Date: Mon, 12 Sep 2011 10:14:42 -0700
Message-ID: <CAErSpo6u5fTJuiXF8vDq0FfwYUsPGLid8xAqEqTPX_7d68J0UA@mail.gmail.com>
References: <1315784551-39118-1-git-send-email-trenn@suse.de> <1315784551-39118-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1123 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1ILRPF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2011 13:15:05 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p8CHF43b030133
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:15:04 -0700
Received: from gwj17 (gwj17.prod.google.com [10.200.10.17])
	by hpaq2.eem.corp.google.com with ESMTP id p8CHESKf007846
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:15:02 -0700
Received: by gwj17 with SMTP id 17so3701250gwj.38
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:15:02 -0700 (PDT)
In-Reply-To: <1315784551-39118-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sun, Sep 11, 2011 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> Only unregister acpi_idle driver if acpi_idle driver got
> registered. On latest Nehalem/Sandybridge this is not the case,
> but the intel_idle driver is used instead.
>
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/processor_driver.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index a4e0f1b..9247e67 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -823,7 +823,8 @@ static int __init acpi_processor_init(void)
> =A0 =A0 =A0 =A0return 0;
>
> =A0out_cpuidle:
> - =A0 =A0 =A0 cpuidle_unregister_driver(&acpi_idle_driver);
> + =A0 =A0 =A0 if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_unregister_driver(&acpi_idle_dr=
iver);

I think this is ugly.  I know we already have a similar check for
acpi_idle_driver in acpi_processor_add(), and I think that's ugly, too
:)

The standard register/unregister_driver() model does not require
looking at what's currently registered, and I don't think this should
be any different.

I don't know the mechanism for choosing either acpi_idle_driver or
intel_idle_driver, but I think you can accomplish what you want here
by just adding a static "acpi_idle_registered" variable to remember
whether the cpuidle_register_driver() was successful, and only do the
unregister if it was.

>
> =A0 =A0 =A0 =A0return result;
> =A0}
> @@ -841,7 +842,8 @@ static void __exit acpi_processor_exit(void)
>
> =A0 =A0 =A0 =A0acpi_bus_unregister_driver(&acpi_processor_driver);
>
> - =A0 =A0 =A0 cpuidle_unregister_driver(&acpi_idle_driver);
> + =A0 =A0 =A0 if (cpuidle_get_driver() =3D=3D &acpi_idle_driver)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_unregister_driver(&acpi_idle_dr=
iver);
>
> =A0 =A0 =A0 =A0return;
> =A0}
> --
> 1.7.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
