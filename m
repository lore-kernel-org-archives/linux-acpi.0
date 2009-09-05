From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] topstar_acpi: add new driver for hotkeys support on
	Topstar N01
Date: Sat, 5 Sep 2009 14:02:32 +0100
Message-ID: <9b2b86520909050602q1c62c648kdce76dc77b9f3dfd@mail.gmail.com>
References: <200909050229.55665.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56844 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbZIENCd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Sep 2009 09:02:33 -0400
Received: by fxm17 with SMTP id 17so1180090fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 05 Sep 2009 06:02:34 -0700 (PDT)
In-Reply-To: <200909050229.55665.herton@mandriva.com.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Cc: linux-acpi@vger.kernel.org

On 9/5/09, Herton Ronaldo Krzesinski <herton@mandriva.com.br> wrote:
> This adds Topstar Laptop Extras ACPI driver. It enables hotkeys
> functionality with Topstar N01 netbook. Besides hotkeys there are
> other functions exposed by its ACPI firmware, but for now only
> hotkeys reporting on Topstar N01 is supported. Topstar is a chinese
> manufacturer, its website can be currently reached at
> http://www.topstardigital.cn/
>
> Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

> +static void __exit acpi_topstar_exit(void)
> +{
> +	acpi_bus_unregister_driver(&acpi_topstar_driver);
> +
> +	printk(KERN_INFO "Topstar Laptop ACPI extras driver unloaded\n");

Oh... and this type of message always strikes me as gratuitous.  rmmod
doesn't happen during normal operation.  So if the user removed the
module... they know they did it.  They can check lsmod if they forget
and are not sure.

If (as a developer) you want to be sure the acpi driver was really
unregistered, you can (and probably should) look in sysfs.

Thanks
Alan
