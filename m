From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Mon, 15 Sep 2003 09:09:02 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.GSO.4.21.0309150908430.3191-100000@vervain.sonytel.be>
References: <20030915040318.1f8bfd18.djgeray2k@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030915040318.1f8bfd18.djgeray2k-/E1597aS9LQMlKAeRRkD2Q@public.gmane.org>
To: Gerardo Exequiel Pozzi <djgeray2k-/E1597aS9LQMlKAeRRkD2Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 15 Sep 2003, Gerardo Exequiel Pozzi wrote:
> On Mon, 15 Sep 2003 08:43:56 +0200 (MEST), Geert Uytterhoeven wrote:
> >With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> >w.r.t. power management:
> >  - It doesn't poweroff anymore (screen contents are still there after the
> >    powering down message)
> >  - It doesn't reboot anymore (screen goes black, though)
> >  - It accidentally suspended to RAM once while I was actively working on it (I
> >    never managed to get suspend working, except for this `accident'). I didn't
> >    see any messages about this in the kernel log.
> >
> >Relevant config options for 2.4.22:
> >| tux$ grep acpi .config
> >| # ACPI Support
> >| CONFIG_ACPI=y
> >| # CONFIG_ACPI_HT_ONLY is not set
> >| CONFIG_ACPI_BOOT=y
> >| CONFIG_ACPI_BUS=y
> >| CONFIG_ACPI_INTERPRETER=y
> >| CONFIG_ACPI_EC=y
> >| CONFIG_ACPI_POWER=y
> >| CONFIG_ACPI_PCI=y
> >| CONFIG_ACPI_SLEEP=y
> >| CONFIG_ACPI_SYSTEM=y
> >| CONFIG_ACPI_AC=y
> >| CONFIG_ACPI_BATTERY=y
> >| CONFIG_ACPI_BUTTON=y
> >| CONFIG_ACPI_FAN=y
> >| CONFIG_ACPI_PROCESSOR=y
> >| CONFIG_ACPI_THERMAL=y
> >| # CONFIG_ACPI_ASUS is not set
> >| # CONFIG_ACPI_TOSHIBA is not set
> >| CONFIG_ACPI_DEBUG=y
> >| # CONFIG_ACPI_RELAXED_AML is not set
> >| tux$ 
> >
> >If you need more information or want me to ttry something, please ask!
> 
>  you have activate this opcion?
> CONFIG_PM=y
> 
> without this my machine don't poweroff after halt.

Yes I have.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
