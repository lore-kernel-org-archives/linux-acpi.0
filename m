From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: ACPI "_PDC" - acpi_processor_set_pdc()- execution regression - Linux-3.x
Date: Wed, 7 Dec 2011 22:01:24 -0700
Message-ID: <CAErSpo7Dcxn7tsecDUXe6AQeRAchsU9tQjL7=-WPpPmDj2OUfw@mail.gmail.com>
References: <1323297487.4edfeacfc49ff@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33108 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1LHFBq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2011 00:01:46 -0500
Received: by wgbdr13 with SMTP id dr13so2679267wgb.1
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2011 21:01:45 -0800 (PST)
In-Reply-To: <1323297487.4edfeacfc49ff@imp.free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wallak@free.fr
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>

[+cc linux-acpi and Lin Ming]

On Wed, Dec 7, 2011 at 3:38 PM,  <wallak@free.fr> wrote:
> We have a regression on the ACPI stack of the last linux kernel line =
3.x (3.1.4,
> 3.2-rc4...). The ACPI "_PDC" chunk is not executed on some computers =
(e.g. Dell
> X300; the function acpi_processor_set_pdc() is not called). This issu=
e yield to
> an uninitialized state of some ACPI variables.
>
> A patch is available below. This patch come back to the previous linu=
x behavior,
> and works fine.
>
> Best Regards,
> Wallak.
>
> --- linux-3.1.4-mdf/drivers/acpi/processor_core.c.orig =A02011-12-07
> 23:12:57.000000000 +0100
> +++ linux-3.1.4-mdf/drivers/acpi/processor_core.c =A0 =A0 =A0 2011-12=
-07
> 23:13:39.000000000 +0100
> @@ -223,8 +223,8 @@
> =A0 =A0 =A0 =A0type =3D (acpi_type =3D=3D ACPI_TYPE_DEVICE) ? 1 : 0;
> =A0 =A0 =A0 =A0cpuid =3D acpi_get_cpuid(handle, type, acpi_id);
>
> - =A0 =A0 =A0 if (cpuid =3D=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> + =A0 =A0 =A0 if ((cpuid =3D=3D -1) && (num_possible_cpus() > 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
>
> =A0 =A0 =A0 =A0return true;
> =A0}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
