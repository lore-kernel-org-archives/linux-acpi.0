Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50651624C0
	for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774369394; cv=none; b=MoioohhowljT0DK+g/OuEs74/3Q6CxDMYg0BE0TVjjivoXWJWMMJoQw+VXTA1LpDEa2uNfZQ5Yj3X4KBiKqjH49IV65m9ywKsUxvsAAID/7Ug3k85jiO+1UNQBU9nsJPiyuKHDfqwh5s1f7Vm99cSUYk2VdwK+UruSXoq/DzFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774369394; c=relaxed/simple;
	bh=BIc3wHAs8s2sPATriFf+fq+uKIS7NsyRMXlyBl5vVsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNKDUmj/EUwDCaZwwANy0c2fyLiwOeoGOL0ljex8W15841zrEeywz1szigKifCfApEprJ5anA/Cu5570KFou87po2v3OkaTNKhQNpJQwOPyOKCaaIfrv4lG7WkGTcYDs97iKGT9pnN+iU/4YU2aDR0z2VtEtKNK68ahZoJnXqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70c112cb61so914750a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774369392; x=1774974192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmRf0clXa/z48rdOhDwIqsCZTl6MAr1IPl0XdGWzmtg=;
        b=opNxH+8/kfVazF0b+YhbpGJD5zy86JGEEnPSWAJWy2/ZIS1Dz5WBrr2J+Aq/+e2uhE
         KzKH3XLcDNoIct3WYiUYB8jjeOktx4FaMWMVqMT2PvsyGNFYKOlW/GsyuP+b5Z7f44F3
         rQ4QagUpIagRWycYk0xeuPmcuuAdSa78KRUc2D4q0koD+vxZGJYxsRdNnHyNrOzECOEz
         EpR6Kv5s+i4c5lTk46q3Eyef7mYYpQKFBoC//thIGW7uKmYRM7VesHBQ1J77Qm41cJl0
         gTRZZAKVlctXH+ke8u19mTuOfnXJfKa6tmrJhS0uumf4+cldEs/mCQ7XebldfUjObTdE
         i3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWbsRd/LK0BIpa4qlDY6GuNszRgSV7rrTj6EG9h7cxw3UmGHp5QwOrdbNY0ZQMq9M3QjzaN9K/R3ght@vger.kernel.org
X-Gm-Message-State: AOJu0YwazBvMlBLJKFf5ZjfPK/lsv+TYVG671DvwJ6+LS/bPdpqgCcdb
	TjHjKa0XOCYl/VHxfvsQpM4X/AV+Bsw2wOQj7y8acjKpIr2g6Ql98Bd8rIOi1Z72eeM=
X-Gm-Gg: ATEYQzzuKGHRsiHvYcBXvQavKkYv8SeDTwd6GHTW0WGnHHVw9SNoRLsllORyNeGW4fO
	atnFxVsu10tAbFh0qx/7GxcbDfMsbb77l/6g7twttJukBEFU6SwG3XXriHoMu+AGzcIXVTPjJN8
	fgjPfkqUE5m/EmrvgJiFglad1pu67M3F6pzJL+EPhI1bIQg3RTZraVkg0/6xLYY1VwwSAWWsMq7
	znYKY7Mj4F2vC2LjDgQgG11FccUprz6oBnWoxdNSSlEM88zuvyT31ZdXoDKBuvmRdYqfwcgMZcK
	ZA4QOur7Zt8Ell0BI3bh28rPNezLyki4RMrNOtabKo/ESX5aKv3xHk1BjAt3blLFFRPzHvpH2RI
	NzTOVl9FdQ7rUir2cGbl9tqmqsPhrJuzykTFNcJ7DB/bQexq/zhsYuNv5B4GoBHkS2IvprujZCK
	JITSoH3OznVC/ZrF2DqQVJigfkp6yBYhlUHhXZZtuj2sz++R4Vo2nBRXsTkafb3AQ=
X-Received: by 2002:a17:902:d50c:b0:2b0:51f6:d46e with SMTP id d9443c01a7336-2b0b09cf4edmr2904755ad.15.1774369391722;
        Tue, 24 Mar 2026 09:23:11 -0700 (PDT)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com. [74.125.82.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516eacsm187947265ad.15.2026.03.24.09.23.11
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:23:11 -0700 (PDT)
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2545859eec.1
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2026 09:23:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWR9vsJeU3cosFq5n54aP7Yvgui0kPxbTeWyZpIQ1rXD4feFs5MA/RqyENKl6o6Coob4LhYXpa6fvMY@vger.kernel.org
X-Received: by 2002:a05:6102:5801:b0:603:270c:9ece with SMTP id
 ada2fe7eead31-60386ebc7d7mr249544137.11.1774368990997; Tue, 24 Mar 2026
 09:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com> <20260309-gpio-hog-fwnode-v2-2-4e61f3dbf06a@oss.qualcomm.com>
In-Reply-To: <20260309-gpio-hog-fwnode-v2-2-4e61f3dbf06a@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2026 17:16:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6RuZXAozrF5m625ZepJTVVr4pcyKczSk12MedWvoejw@mail.gmail.com>
X-Gm-Features: AQROBzCujwdtX4JkcLDjVnd6LogBn_okx21mGqzFRhZGg9NW5EWThevgncjlCbw
Message-ID: <CAMuHMdX6RuZXAozrF5m625ZepJTVVr4pcyKczSk12MedWvoejw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] gpio: move hogs into GPIO core
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bartosz,

On Mon, 9 Mar 2026 at 13:43, Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
> Refactor line hogging code by moving the parts duplicated in
> gpiolib-acpi-core.c and gpiolib-of.c into gpiolib.c, leaving just the
> OF-specific bits in the latter.
>
> This makes fwnode the primary API for setting up hogs and allows to use
> software nodes in addition to ACPI and OF nodes.
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Thanks for your patch, which is now commit d1d564ec4992945d ("gpio:
move hogs into GPIO core") in gpio/gpio/for-next.

This breaks GPIO on the Renesas Marzen (R-Car H1) board:

    -gpio_rcar ffc40000.gpio: driving 32 GPIOs
    +gpiochip_add_data_with_key: GPIOs 512..543 (ffc40000.gpio) failed
to register, -22
    +gpio_rcar ffc40000.gpio: failed to add GPIO controller
    +gpio_rcar ffc40000.gpio: probe with driver gpio_rcar failed with error -22

> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -960,6 +960,98 @@ static void machine_gpiochip_add(struct gpio_chip *gc)
>         }
>  }
>
> +int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *gc_node = dev_fwnode(&gc->gpiodev->dev);
> +       struct fwnode_reference_args gpiospec;
> +       enum gpiod_flags dflags;
> +       struct gpio_desc *desc;
> +       unsigned long lflags;
> +       const char *name;
> +       int ret, argc;
> +       u32 gpios[3]; /* We support up to three-cell bindings. */
> +       u32 cells;
> +
> +       lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> +       dflags = GPIOD_ASIS;
> +       name = NULL;
> +
> +       argc = fwnode_property_count_u32(fwnode, "gpios");
> +       if (argc < 0)
> +               return argc;
> +       if (argc > 3)
> +               return -EINVAL;

The GPIO hog at [1] has a gpios property with two entries:

    gpios = <17 GPIO_ACTIVE_LOW>, <18 GPIO_ACTIVE_LOW>;

hence argc = 4, which is considered invalid.

The check should take into account the actual value of #gpio-cells,
and handle the presence of multiple GPIOs.

"git grep -Ww gpio-hog -- arch/*/boot/dts/ | grep 'gpios\s*=.*>,'" finds
several other places where multiple GPIOs are specified.

> +
> +       ret = fwnode_property_read_u32_array(fwnode, "gpios", gpios, argc);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (is_of_node(fwnode)) {
> +               /*
> +                * OF-nodes need some additional special handling for
> +                * translating of devicetree flags.
> +                */
> +               ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
> +               if (ret)
> +                       return ret;
> +               if (!ret && argc != cells)
> +                       return -EINVAL;
> +
> +               memset(&gpiospec, 0, sizeof(gpiospec));
> +               gpiospec.fwnode = fwnode;
> +               gpiospec.nargs = argc;
> +
> +               for (int i = 0; i < argc; i++)
> +                       gpiospec.args[i] = gpios[i];
> +
> +               ret = of_gpiochip_get_lflags(gc, &gpiospec, &lflags);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               /*
> +                * GPIO_ACTIVE_LOW is currently the only lookup flag
> +                * supported for non-OF firmware nodes.
> +                */
> +               if (gpios[1])
> +                       lflags |= GPIO_ACTIVE_LOW;
> +       }
> +
> +       if (fwnode_property_present(fwnode, "input"))
> +               dflags |= GPIOD_IN;
> +       else if (fwnode_property_present(fwnode, "output-low"))
> +               dflags |= GPIOD_OUT_LOW;
> +       else if (fwnode_property_present(fwnode, "output-high"))
> +               dflags |= GPIOD_OUT_HIGH;
> +       else
> +               return -EINVAL;
> +
> +       fwnode_property_read_string(fwnode, "line-name", &name);
> +
> +       desc = gpiochip_get_desc(gc, gpios[0]);
> +       if (IS_ERR(desc))
> +               return PTR_ERR(desc);
> +
> +       return gpiod_hog(desc, name, lflags, dflags);
> +}

[1] https://elixir.bootlin.com/linux/v6.19.9/source/arch/arm/boot/dts/renesas/r8a7779-marzen.dts#L196

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
