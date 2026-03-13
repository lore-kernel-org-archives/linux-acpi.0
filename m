Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0C3E3149
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773428613; cv=none; b=ZcGvUW9J/GaUD+SvLuZKx6/TlUUu/ZgU4vWADkzUq23v1tEOi5WjxwAb/6pePIlYyBbEIEvpL/vlGtqym2JCiO84gg4F5cRbr6bqR1NjSZBokp30oXGfg67v/bNzAzAWwuAjfkmEqYktN3VHjtfSC1Fb+3B0FgSgujls557qdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773428613; c=relaxed/simple;
	bh=/QDlObBMCi33bcdrgMZJZeNPfToB05dx5aW/uZ9UgQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCB/mowKAxsK71v71DOMQSB1bbduK2he8pknrezoAqOer2xNd7Cr4oqrAnpa2LJ0gV8L1uzEeHhJglGFqgMZZTWehW5+Ber14Fuan3KFEdagBQZAkxgPQD2APP+BMMfPqyIa1EOrmC/U8oCRgF2cI8Ioy9yDRukuV0k2AJ8CnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI5VjS0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI5VjS0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8AEC2BC86
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773428612;
	bh=/QDlObBMCi33bcdrgMZJZeNPfToB05dx5aW/uZ9UgQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hI5VjS0eaCiw7BbfpHnuY/5X6GGPahaF20bHloSmIFQsZk51W54Q9/WxZFwupMdm0
	 Tj5Hc6Ez6cLakAaIvw6ZFbZ5CdMtKgo69bqihIVSPTB7uAIqprGRM4mPVD+vVvddMh
	 uQdnk69IXv2SNVlSOe0faheoVc9m3sdP7uQnAuiEPYKjfk2/kyTLEkkO9ZD8HrFTCs
	 Nw4MI562RzCAnQAMb6BYqOAx2iLiFY34wVV6cb7beZ3wdxF6pfbQsvlZD3iiP3U6hw
	 0AGscZ6F7vsLUh3lhYjX/SRFtkTAN/8u9jwWZZYJrs2u3fj3jRgwE7N3qWe3X70e/1
	 RunIVM/xt14PQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67bb5f989c4so1582746eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 12:03:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYLVVPnPGK4S3zi4sPKB0uEhm62Tuw63OjfbsXiJpVq9fl8pI/
	PxnX73iCoQmCgi0YCyMRei77LodHT1FBG6oNF0cakBKHaO16nVaO5C+xflCiJejFgABDw13puXw
	IdCarLqjfN4n5MiylGvYIabq85YanLSA=
X-Received: by 2002:a05:6820:169e:b0:676:e8d1:bb49 with SMTP id
 006d021491bc7-67bdaa92697mr2941680eaf.69.1773428611830; Fri, 13 Mar 2026
 12:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3611505.QJadu78ljV@rafael.j.wysocki>
In-Reply-To: <3611505.QJadu78ljV@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 20:03:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0imNayXU=9GD_J+7QzSd-nKNprm6mM3Csfznq4iYxjJ+g@mail.gmail.com>
X-Gm-Features: AaiRm51GVcJ_NdiXx0Gm9rAKoNbSrjIhE1SutJUoW5Qj568o-vLPbcT0UI1KfZA
Message-ID: <CAJZ5v0imNayXU=9GD_J+7QzSd-nKNprm6mM3Csfznq4iYxjJ+g@mail.gmail.com>
Subject: Re: [PATCH v1] hpet: Convert ACPI driver to a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>, 
	Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:49=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
>
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the HPET ACPI driver to a platform one.
>
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
>
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1=
]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/char/hpet.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index 60dd09a56f50..d396823e5e64 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -34,6 +34,7 @@
>  #include <linux/io.h>
>  #include <linux/acpi.h>
>  #include <linux/hpet.h>
> +#include <linux/platform_device.h>
>  #include <asm/current.h>
>  #include <asm/irq.h>
>  #include <asm/div64.h>
> @@ -971,8 +972,9 @@ static acpi_status hpet_resources(struct acpi_resourc=
e *res, void *data)
>         return AE_OK;
>  }
>
> -static int hpet_acpi_add(struct acpi_device *device)
> +static int hpet_acpi_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>         acpi_status result;
>         struct hpet_data data;
>
> @@ -1000,12 +1002,12 @@ static const struct acpi_device_id hpet_device_id=
s[] =3D {
>         {"", 0},
>  };
>
> -static struct acpi_driver hpet_acpi_driver =3D {
> -       .name =3D "hpet",
> -       .ids =3D hpet_device_ids,
> -       .ops =3D {
> -               .add =3D hpet_acpi_add,
> -               },
> +static struct platform_driver hpet_acpi_driver =3D {
> +       .probe =3D hpet_acpi_probe,
> +       .driver =3D {
> +               .name =3D "hpet_acpi",
> +               .acpi_match_table =3D hpet_device_ids,
> +       },
>  };
>
>  static struct miscdevice hpet_misc =3D { HPET_MINOR, "hpet", &hpet_fops =
};
> @@ -1020,7 +1022,7 @@ static int __init hpet_init(void)
>
>         sysctl_header =3D register_sysctl("dev/hpet", hpet_table);
>
> -       result =3D acpi_bus_register_driver(&hpet_acpi_driver);
> +       result =3D platform_driver_register(&hpet_acpi_driver);
>         if (result < 0) {
>                 unregister_sysctl_table(sysctl_header);
>                 misc_deregister(&hpet_misc);
> --

If anyone has any objections or  concerns regarding this change,
please let me know.

In the absence of any, I'll queue it up for 7.1.

Thanks!
