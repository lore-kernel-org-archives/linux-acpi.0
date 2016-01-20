From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/2] ACPI: introduce a function to find the first
 physical device
Date: Wed, 20 Jan 2016 17:12:18 +0200
Message-ID: <CAHp75VcdtU6izThE+Z2ODnYoXk-uhweXzUtFwSze_jJHw3+38g@mail.gmail.com>
References: <1453300171-25473-1-git-send-email-aleksey.makarov@linaro.org>
	<1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36553 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933215AbcATPMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 10:12:19 -0500
In-Reply-To: <1453300171-25473-2-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Wed, Jan 20, 2016 at 4:29 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> Factor out the code that finds the first physical device
> of a given ACPI device.  It is used in several places.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Hmm=E2=80=A6 Sorry, didn't notice one style issue and there is one is m=
atter
of taste below.

> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -43,7 +43,6 @@ static const struct acpi_device_id forbidden_id_lis=
t[] =3D {

> +       pdevinfo.parent =3D adev->parent ?
> +               acpi_get_first_physical_node(adev->parent) : NULL;

Matter of taste, but I believe if-else looks better here even when
consumes +2 LOC.
Or, does it fit 80? How wide then?

> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -478,24 +478,35 @@ static void acpi_device_remove_notify_handler(s=
truct acpi_device *device)
>                               Device Matching
>     -----------------------------------------------------------------=
--------- */
>
> -static struct acpi_device *acpi_primary_dev_companion(struct acpi_de=
vice *adev,
> -                                                     const struct de=
vice *dev)
> +/**
> + * acpi_device_fix_parent - Get first physical node of an ACPI devic=
e

'node' -> 'device node'
Name of the function is wrong.

> + * @adev: ACPI device in question
> + */
> +struct device *acpi_get_first_physical_node(struct acpi_device *adev=
)
>  {
>         struct mutex *physical_node_lock =3D &adev->physical_node_loc=
k;
> +       struct device *node =3D NULL;
>
>         mutex_lock(physical_node_lock);
> -       if (list_empty(&adev->physical_node_list)) {
> -               adev =3D NULL;
> -       } else {
> -               const struct acpi_device_physical_node *node;
>
> +       if (!list_empty(&adev->physical_node_list))
>                 node =3D list_first_entry(&adev->physical_node_list,
> -                                       struct acpi_device_physical_n=
ode, node);
> -               if (node->dev !=3D dev)
> -                       adev =3D NULL;
> -       }
> +                               struct acpi_device_physical_node, nod=
e)->dev;

I didn't notice this '->dev' thingy. I supposed that the function
returns struct acpi_device_physical_node *, not struct device *.

Currently the name is not aligned with returned value.

> +
>         mutex_unlock(physical_node_lock);
> -       return adev;
> +
> +       return node;
> +}


--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
