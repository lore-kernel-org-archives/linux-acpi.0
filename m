Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC03CF206
	for <linux-acpi@vger.kernel.org>; Tue,  9 Jun 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988008; cv=none; b=jnrYbzaN4S/fG8VP/A8mXQklgHzHDEV4qoIvyZALndhAkLsXLSfORMFsI78r0Jstjf4tr+KFgfXcXn3s0eYi3lm61DLECd4ZVmtjKsxZlD78LVHOxzcbp3MB6fl8RsivfkASPxCigdcKSt6+3jL0iaf4ZL+Bsv43dKjRpKk7aJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988008; c=relaxed/simple;
	bh=USxDlh+cTOmctRbVLXUwHBHqPmHhLde8bvmv+bZmeZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sn65TrR2eS2nlqSbNtLVIeYDEsaiinwW2J3yMDk/OtfNHBjXE93cgEieqUJzDbFxbyzIshnWsomZkSAFDelC42JV9rEBEsmE62qv+iLbbAO8WVNK//zTh6LLavvVWk5gwNTunRtWL6J8BDRAxJ2sHO7WesgTbZVRC/WVWBCLZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6c7e8c9f612so1843078137.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 23:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988005; x=1781592805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfrTmKBa/6XQOKTJVCGFPY/9uy59Ow4t/P5iBf4xoKk=;
        b=XNC+lcMrSeDDpjO8nHjKOs8r28rbzNGnztQUAjnzcL2DUCaXmPlhcFC73drfycR8nm
         mLrr7tf2O8IfrCm/IlgncS6nn4Tx64teKE6q3fVkxJQyijXqkkQaCWtdjLGiYovmTmr4
         ncX09MBwqEUBTGsCe6Oob76WSYncmRNINWh26gqwgGIEmUScJSr9umLvzlBdp2zKG/4G
         D7sLcIgArKs02k19p/njW9/XeL1OHcgLvtI8SPvuOsr8mKzmn8DUKHtK6y25sgAy8L98
         Z+XfhZ14d8EtEaWaCUda4i1ZssZyuA8Vm+mg3Nta+gYl2Hd1odVCwWeyMJNjYyX4rQOM
         zaJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Apxrhq+OjxDKKJKtfSb4IXrskNmAxnRUWDHWSUhrESXJn/+VSJ2xNJwbJNIjk5IDu2+RPPw9TAoxE@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhTsnGP/jCopWcEGzsVWYCL8ICd20ehUcjnpyRbGqGeIDwZ9U
	ka9Uo9xHc0OvQbWUrWnNCr5+Tz86ABUvt1BGppXJx8xnCNJhVSA1bG3UvcH2tHB5
X-Gm-Gg: Acq92OG2QLBJZjCGGR1hCQxxP0XUUYuqUb3xrYORFPv1nlwWAW6cfuoc9UqSkztwTeY
	iEE/QK+rrcVbJmbuqRUhJXnWy9cNHsXsd7ruwBfIGFz00Ex46RlHUnA2nlEKyLleWl9eIO2pHXt
	0/HqjU0JpgD2CkMXi4GwKoybgZ373U7Ff1ibwSKNVVjQGlpplerpbKDB4dSAuxKUhdpDTMqvkXF
	252i0BQSR3uhWEl+NR5dMcqpbNarVv01P0U35xC44reXuzLZfNeZlJTX4F0RbcHN0LHKr7T/QsZ
	8qZGQkciiqVdrXWT2ETz1p1+/FsbTS6GcSVm/bvEAIrWkdX8tuiQo7kALOmrJtUhNGRW1s3vpRP
	DiUUgrOmFSIrFehUOzJhwA/tyIzumJrTVCDqJNATou9eZXWX3+rroYIm4ZnYfTWo9aHBB0YpTM6
	GVup5yfT5NlqNiSwDBLp99bvIh4SthawFGgwya/WHOYlAhBS0hieHUVHMK6X+u62NYvsEiYks=
X-Received: by 2002:a05:6102:548c:b0:612:7ddc:52ee with SMTP id ada2fe7eead31-6ff02387138mr9194285137.15.1780988004736;
        Mon, 08 Jun 2026 23:53:24 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb649b54e0sm16196314137.9.2026.06.08.23.53.23
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 23:53:23 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9638c832c48so1865621241.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2026 23:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+cXevE3EcmCFS5zFyzBz/vsX3LpDlei6FNB7AaI3u7xkGLfSLxCNwu3eJWRk1nvKk54PMwR1005184@vger.kernel.org
X-Received: by 2002:a05:6102:94c:b0:6cb:d562:b96a with SMTP id
 ada2fe7eead31-6ff02387516mr9986946137.14.1780988002958; Mon, 08 Jun 2026
 23:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-acpi_spcr-v2-0-3cd9a3bda727@posteo.de> <20260609-acpi_spcr-v2-1-3cd9a3bda727@posteo.de>
In-Reply-To: <20260609-acpi_spcr-v2-1-3cd9a3bda727@posteo.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 08:53:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXH0mR9Sr+ze2_m94uc46_7gubApzWOkf+vUO+w=DmNoQ@mail.gmail.com>
X-Gm-Features: AVVi8Cemo9bnqwwW5sau-L6wcH5-zrPfob50Y8WSYUrCMRB7OtaTQ6EIMHl5BFg
Message-ID: <CAMuHMdXH0mR9Sr+ze2_m94uc46_7gubApzWOkf+vUO+w=DmNoQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] serial: earlycon: add uart_clk_freq parameter
To: Markus Probst <markus.probst@posteo.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Tue, 9 Jun 2026 at 00:40, Markus Probst <markus.probst@posteo.de> wrote:
> Add `uart_clk_freq` parameter to `setup_earlycon`. This allows the
> options string to be reused with `add_preferred_console`, while still
> allowing to set the uart clock frequency. This will be used in the
> following commit ("ACPI: SPCR: Support UART clock frequency field").
>
> No logical change intended.
>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -135,11 +135,14 @@ static int __init parse_options(struct earlycon_device *device, char *options)
>         return 0;
>  }
>
> -static int __init register_earlycon(char *buf, const struct earlycon_id *match)
> +static int __init register_earlycon(char *buf, unsigned int uart_clk_freq,
> +                                   const struct earlycon_id *match)
>  {
>         int err;
>         struct uart_port *port = &early_console_dev.port;
>
> +       port->uartclk = uart_clk_freq;

Who is actually consuming this value?
Earlycon typically works with the serial console, as configured before
Linux boot by the firmware.
The Microsoft doc referenced in patch 2 seem to agree with that:

   "On a system where the BIOS or system firmware uses the serial
    port for console input/output, this table should be used to convey
    information about the settings, to ensure a seamless transition
    between the firmware console output and Windows EMS output."

> +
>         /* On parsing error, pass the options buf to the setup function */
>         if (buf && !parse_options(&early_console_dev, buf))
>                 buf = NULL;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
