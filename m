Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D49372EE6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641894; cv=none; b=JBpD7fG+zzrxx8CXARjKmvAhf302aesF06V+g2ltzEhkRdUt9rKjdzUyvF7jtz8EsyxdyZEj3weywlaQhNrIR8a+Xe939ASO9NKF1RZ9i1oGdGUsKt1PG73mJ+dCI/QXsGCBjtulkDz7/6/gD35o7u4hqa2IXgFGkzU+B5BnZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641894; c=relaxed/simple;
	bh=b1B65oJ/ZWqDS2bgL0HfdNFej5xrMAH7/6hDcAWbU74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ6YbtfN0iuEele4N4LId3a6jpM42mPWQJUmXKwGjDxRMEAsGm/XU/sEw5QGzgo0+RwZVzOzH/vpAA/Nq6uk2vDjrM45fs3540HEALLqkFEKf+PIjZDEJG9A3JrXjFQvxIh2guBd/QCozPNWHmPMIIoXfMAVcC/7reEBUw7U0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFQwsgmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFQwsgmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8C51F00A3D
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784641893;
	bh=fpdvqwngv55Qs9fD3eLyUcnsSmFCe0SmYu7wQqFi9ZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KFQwsgmJxRinh3SJD1O6Snasju3JJEmWQ50fKoEuHsmNmvdX7aKg01A9YnFHXa/oN
	 QM+XZRGXpnNqVI0Ti3ut5elYFpHBDdEz9QXxzDsJzppmM+dppcYAU/PrZrTTRi9qf+
	 75wY9aUZPPd5QgTtyptFmhoHihvG4LUcuw3aBbMghSR1vVXrT8wz6YKCLBY2zzMj+Y
	 1nVSxICqAch2fdIiGPQSal+njHjmAjULM16lSVojleIhzDHyAutZ8o/hvkY6Vs8VDh
	 stTuYcQbvENC1N1AQYLIcVohyOwQwqG+bZ6j/rC7lkOCSilJV6+G9tWlmmvaj/JoNO
	 mhba+eCuHmGUA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c94d4fdb9so69905301fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 06:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqiPIYmIbeM+cz5xgm3y0Ul5eTDH8lm1nQ20jtdDxjma5lH6uHo5pI1e3QWgk9eIM/mr+1d7yyWCTvN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuj7BDpLtEVL2FQzaHsAWINxK0wcPNndzR5sNJoQPAZwRV5jE6
	V2XfY36MXOZVbkmKfY8Tfgpu1+unYeduqMRc5xGbEwGN6MYDBLO5m8ZC+J25cddRsT8fv+C+H19
	jT8b6YdRnHBarqEn/kSA7IvIGQPWP1a4=
X-Received: by 2002:a2e:b8c7:0:b0:394:8fc:8c3d with SMTP id
 38308e7fff4ca-39eb273c8e4mr31695141fa.4.1784641891369; Tue, 21 Jul 2026
 06:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715012556.12043-1-zhuling2709@phytium.com.cn>
In-Reply-To: <20260715012556.12043-1-zhuling2709@phytium.com.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 15:51:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKG_xNjyjEjnQY0yTyNspnPKMiLrtPmYSF_8LnsYQFGQ@mail.gmail.com>
X-Gm-Features: AUfX_mwZUW_B68zOAX9VHpcw7jJvZpzb2mLebq8aQ5bo97jjtstfGmZrW4ZSqoM
Message-ID: <CAJZ5v0jKG_xNjyjEjnQY0yTyNspnPKMiLrtPmYSF_8LnsYQFGQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Avoid _REG disconnect on GPIO IRQ defer
To: Zhu Ling <zhuling2709@phytium.com.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Weiming Shi <bestswngs@gmail.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:26=E2=80=AFAM Zhu Ling <zhuling2709@phytium.com.c=
n> wrote:
>
> EC event delivery uses either a GPE or, on ACPI reduced hardware
> platforms, a GpioInt resource.  The GPE path does not have a provider
> lookup that can defer, but acpi_dev_gpio_irq_get() can return
> -EPROBE_DEFER for the GpioInt path.
>
> ec_install_handlers() currently installs the EC address space handler and
> executes _REG before looking up the GPIO IRQ.  If the GPIO lookup then
> defers, acpi_ec_setup() tears the handlers down again.  Removing the EC
> address space handler causes ACPICA to execute _REG for disconnect, so
> firmware may observe an EC OpRegion connected -> disconnected transition
> during one failed probe attempt.
>
> This is observable when the namespace EC reuses a boot EC that has alread=
y
> installed the EC address space handler.  A deferred namespace EC probe ca=
n
> disconnect the already usable boot EC OpRegion until a later reprobe
> connects it again.  AML that gates EC field accesses on _REG state can
> then return fallback values to other drivers during that window.
>
> Prepare the GPIOInt IRQ before publishing EC OpRegion availability to AML=
.
> This leaves the GPE path unchanged, keeps non-deferred GPIO lookup errors
> non-fatal as before, and still lets the existing acpi_ec_setup() error
> path clean up real handler installation failures.
>
> Fixes: f6484cadbcaf ("ACPI: EC: clean up handlers on probe failure in acp=
i_ec_setup()")
> Signed-off-by: Zhu Ling <zhuling2709@phytium.com.cn>
> ---
>  drivers/acpi/ec.c | 39 +++++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 64ad4cfa6208..26550879f43c 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1510,6 +1510,23 @@ static bool install_gpio_irq_event_handler(struct =
acpi_ec *ec)
>                                     IRQF_SHARED | IRQF_ONESHOT, "ACPI EC"=
, ec) >=3D 0;
>  }
>
> +static int ec_prepare_gpio_irq(struct acpi_ec *ec, struct acpi_device *d=
evice)
> +{
> +       int irq;
> +
> +       if (!device || ec->gpe >=3D 0 || ec->irq >=3D 0)
> +               return 0;
> +
> +       /* ACPI reduced hardware platforms use a GpioInt from _CRS. */
> +       irq =3D acpi_dev_gpio_irq_get(device, 0);
> +       if (irq =3D=3D -EPROBE_DEFER)
> +               return irq;
> +       if (irq >=3D 0)
> +               ec->irq =3D irq;
> +
> +       return 0;
> +}
> +
>  /**
>   * ec_install_handlers - Install service callbacks and register query me=
thods.
>   * @ec: Target EC.
> @@ -1524,7 +1541,6 @@ static bool install_gpio_irq_event_handler(struct a=
cpi_ec *ec)
>   * Return:
>   * -ENODEV if the address space handler cannot be installed, which means
>   *  "unable to handle transactions",
> - * -EPROBE_DEFER if GPIO IRQ acquisition needs to be deferred,
>   * or 0 (success) otherwise.
>   */
>  static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *d=
evice,
> @@ -1557,19 +1573,6 @@ static int ec_install_handlers(struct acpi_ec *ec,=
 struct acpi_device *device,
>         if (!device)
>                 return 0;
>
> -       if (ec->gpe < 0) {
> -               /* ACPI reduced hardware platforms use a GpioInt from _CR=
S. */
> -               int irq =3D acpi_dev_gpio_irq_get(device, 0);
> -               /*
> -                * Bail out right away for deferred probing or complete t=
he
> -                * initialization regardless of any other errors.
> -                */
> -               if (irq =3D=3D -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -               else if (irq >=3D 0)
> -                       ec->irq =3D irq;
> -       }
> -
>         if (!test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
>                 /* Find and register all query methods */
>                 acpi_walk_namespace(ACPI_TYPE_METHOD, ec->handle, 1,
> @@ -1647,6 +1650,14 @@ static int acpi_ec_setup(struct acpi_ec *ec, struc=
t acpi_device *device, bool ca
>  {
>         int ret;
>
> +       /*
> +        * GPIO IRQ lookup can defer.  Do it before publishing the EC
> +        * OpRegion to AML to avoid a spurious _REG(disconnect).
> +        */
> +       ret =3D ec_prepare_gpio_irq(ec, device);
> +       if (ret)
> +               return ret;
> +
>         /* First EC capable of handling transactions */
>         if (!first_ec)
>                 first_ec =3D ec;

Applied as 7.3 material, thanks!
