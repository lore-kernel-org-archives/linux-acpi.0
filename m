Return-Path: <SRS0=S9MC=5J=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB051C4332B
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Mar 2020 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5DB20870
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Mar 2020 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585050341;
	bh=dAub+OokKtMO8ylxBClvCpfZkAVysCaaTSUPFX7w9TY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NQdNQ9P+T3cH/nJbuLGUHAHQa6ngKyLI8ppoUDw9q74X3z3u3GlbltcdAlZc1hP3X
	 gUvii3UrlM/nPJY8XCT5o+/NA0qavYkfPEtgnXE7pjrDMMPXeGQ12wyrhUCiUF+UBq
	 NFb0ixYaidrv4wbU7ZPVoX2lXbExt7gtq9m3XpEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgCXLpl (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:45:41 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34089 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCXLpk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2020 07:45:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so16704630otl.1;
        Tue, 24 Mar 2020 04:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Xukp+Fc29wzZVTyzrk0qXNwo77782YSPsXV0QOP/4s=;
        b=CKMISH7rNroUwn5rqL97h0snWq8ec+kW1cZpKeb6u8szCQNd4iJ7GnohX2QYPuYSq7
         AU8/Hv/8X8aH3mluD+wN0QxvdcK3lph/5imwk0afct3HAClO8pThavmnO+SWWSqY9qkP
         /PWjB3VBzsBYGpNh7lIbUDZrghhPXeBPu905VFORtzFUhK7AYw445e+tnCpEvDwlmmiB
         R0UT2qROQG43M8A2XmbpeHUYyI/ORzIBWMS5Z+Ly3mP68bGibWGqHbbvNccMviprgJWG
         y+XiFMqzlTJyN47fb9LCfjFBusT3q6SldinanEX+IktHHHmJqDp42O9IFAxizcfucHlj
         QuFA==
X-Gm-Message-State: ANhLgQ3+gtEAWHdq6ux/TrndlXuM6tTlHhAN+lfKJKOMQ0f73kNhV+yn
        yz2bYG71slY/mNvTbCZD9kakuyUsvowOYBfrK/E=
X-Google-Smtp-Source: ADFU+vtHv2jhYbUQsGRpWUfeFfSaAVuU5XJfBh/zKjb/MDZ/2zYirryiypPOKyCEo5dYq+i4k0/xKdoJzQrs/2CTN40=
X-Received: by 2002:a4a:df05:: with SMTP id i5mr1851614oou.9.1585050339936;
 Tue, 24 Mar 2020 04:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200324100923.8332-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200324100923.8332-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Mar 2020 12:45:29 +0100
Message-ID: <CAJZ5v0gMbpBNu=C+YoNY1jSGFfXkwro=srtxAXc8NmBZV+cP+Q@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Add ACPI support for USB interface devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2020 at 11:09 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently on ACPI-enabled systems the USB interface device has no link to
> the actual firmware node and thus drivers may not parse additional information
> given in the table. The new feature, proposed here, allows to pass properties
> or other information to the drivers.
>
> The ACPI companion of the device has to be set for USB interface devices
> to achieve above. Use ACPI_COMPANION_SET macro to set this.
>
> Note, OF already does link of_node and this is the same for ACPI case.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: rewrite commit message to emphasize that it is a new feature (Greg)
>  drivers/usb/core/message.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index 5adf489428aa..d5f834f16993 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -5,6 +5,7 @@
>   * Released under the GPLv2 only.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/pci.h> /* for scatterlist macros */
>  #include <linux/usb.h>
>  #include <linux/module.h>
> @@ -1941,6 +1942,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>                         intf->dev.of_node = usb_of_get_interface_node(dev,
>                                         configuration, ifnum);
>                 }
> +               ACPI_COMPANION_SET(&intf->dev, ACPI_COMPANION(&dev->dev));
>                 intf->dev.driver = NULL;
>                 intf->dev.bus = &usb_bus_type;
>                 intf->dev.type = &usb_if_device_type;
> --
> 2.25.1
>
