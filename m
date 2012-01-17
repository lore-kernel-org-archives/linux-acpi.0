From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/5] ACPI processor: Do not export acpi_idle_driver in
 processor.h
Date: Tue, 17 Jan 2012 06:25:08 -0500
Message-ID: <4F155A94.3070403@kernel.org>
References: <1321569421-46220-1-git-send-email-trenn@suse.de> <1321569421-46220-2-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62432 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab2AQLZL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 06:25:11 -0500
Received: by qcsf13 with SMTP id f13so2010276qcs.19
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jan 2012 03:25:10 -0800 (PST)
In-Reply-To: <1321569421-46220-2-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org

On 11/17/2011 05:36 PM, Thomas Renninger wrote:

> Instead move its declaration from processor_idle.c to processor_drive=
r.c
> and declare it static as it's the only file using this struct.
>=20
> Cleanup only, no functional change.
>=20
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/processor_driver.c |    5 +++++
>  drivers/acpi/processor_idle.c   |    5 -----
>  include/acpi/processor.h        |    1 -
>  3 files changed, 5 insertions(+), 6 deletions(-)
>=20


drivers/acpi/processor_idle.c: In function =91acpi_processor_setup_cpui=
dle_states=92:
drivers/acpi/processor_idle.c:1032:32: error: =91acpi_idle_driver=92 un=
declared (first use in this function)
drivers/acpi/processor_idle.c:1032:32: note: each undeclared identifier=
 is reported only once for each function it appears in
drivers/acpi/processor_idle.c: In function =91acpi_processor_cst_has_ch=
anged=92:
drivers/acpi/processor_idle.c:1158:29: error: =91acpi_idle_driver=92 un=
declared (first use in this function)
drivers/acpi/processor_idle.c: In function =91acpi_processor_power_init=
=92:
drivers/acpi/processor_idle.c:1239:38: error: =91acpi_idle_driver=92 un=
declared (first use in this function)
drivers/acpi/processor_idle.c: In function =91acpi_processor_power_exit=
=92:
drivers/acpi/processor_idle.c:1270:31: error: =91acpi_idle_driver=92 un=
declared (first use in this function)

eh?


> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index a4e0f1b..3a4fc0c 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -106,6 +106,11 @@ static struct acpi_driver acpi_processor_driver =
=3D {
>  		},
>  };
> =20
> +static struct cpuidle_driver acpi_idle_driver =3D {
> +	.name =3D		"acpi_idle",
> +	.owner =3D	THIS_MODULE,
> +};
> +
>  #define INSTALL_NOTIFY_HANDLER		1
>  #define UNINSTALL_NOTIFY_HANDLER	2
> =20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> index 9b88f98..7fed4f3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -968,11 +968,6 @@ static int acpi_idle_enter_bm(struct cpuidle_dev=
ice *dev,
>  	return idle_time;
>  }
> =20
> -struct cpuidle_driver acpi_idle_driver =3D {
> -	.name =3D		"acpi_idle",
> -	.owner =3D	THIS_MODULE,
> -};
> -
>  /**
>   * acpi_processor_setup_cpuidle - prepares and configures CPUIDLE
>   * @pr: the ACPI processor
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 67055f1..5b27bc3 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -333,7 +333,6 @@ int acpi_processor_power_exit(struct acpi_process=
or *pr,
>  			      struct acpi_device *device);
>  int acpi_processor_suspend(struct acpi_device * device, pm_message_t=
 state);
>  int acpi_processor_resume(struct acpi_device * device);
> -extern struct cpuidle_driver acpi_idle_driver;
> =20
>  /* in processor_thermal.c */
>  int acpi_processor_get_limit_info(struct acpi_processor *pr);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
