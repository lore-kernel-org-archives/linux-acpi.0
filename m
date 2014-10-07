From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 05/13] misc: at25: Make use of device property API
Date: Tue, 7 Oct 2014 11:10:23 +0200
Message-ID: <CAMuHMdXHRbbjf8WJHwtZEgdctmVSMzjOKXfd9a1YcHundBG4-Q@mail.gmail.com>
References: <2660541.BycO7TFnA2@vostro.rjw.lan>
	<1443736.WYtVLjNfzc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:39074 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaJGJKZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Oct 2014 05:10:25 -0400
In-Reply-To: <1443736.WYtVLjNfzc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>

On Tue, Oct 7, 2014 at 2:14 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> @@ -301,35 +301,33 @@ static ssize_t at25_mem_write(struct memory_accessor *mem, const char *buf,
>
>  /*-------------------------------------------------------------------------*/
>
> -static int at25_np_to_chip(struct device *dev,
> -                          struct device_node *np,
> -                          struct spi_eeprom *chip)
> +static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
>  {
>         u32 val;
>
>         memset(chip, 0, sizeof(*chip));
> -       strncpy(chip->name, np->name, sizeof(chip->name));
> +       strncpy(chip->name, "at25", sizeof(chip->name));

So this changes chip->name from "eeprom" (or whatever name the DTS
writer used; "eeprom" is the ePAPR-compliant name) to "at25"?

Note:The example in Documentation/devicetree/bindings/misc/at25.txt
uses "at25", not "eeprom".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
