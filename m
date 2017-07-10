From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: ATK0110 GITM[0x6020011] ACPI exception: AE_BAD_PARAMETER errors
Date: Mon, 10 Jul 2017 11:05:18 +0100
Message-ID: <CAKPcRGqKkUu3124kO+teFvDRuVkQHj1mgQxrmPfda7534HYQbQ@mail.gmail.com>
References: <c3774583-930e-a683-bf2f-0684689e12a4@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35315 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbdGJKFU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2017 06:05:20 -0400
Received: by mail-ua0-f176.google.com with SMTP id j53so50832477uaa.2
        for <linux-acpi@vger.kernel.org>; Mon, 10 Jul 2017 03:05:20 -0700 (PDT)
In-Reply-To: <c3774583-930e-a683-bf2f-0684689e12a4@internode.on.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arthur Marsh <arthur.marsh@internode.on.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Hi,

On 9 July 2017 at 05:35, Arthur Marsh <arthur.marsh@internode.on.net> wrote:
> On post 4.12.0 kernels

So 4.11.9 works but 4.12 doesn't, correct?

> on an ASUS M3A7A Pro motherboard, I've been getting
> messages about the asus_atk0110 module:
>
> am64:/usr/src/linux# dmesg|grep -i atk
> [   12.517304] ATK0110 ATK0110:00: hwmon_device_register() is deprecated.
> Please convert the driver to use hwmon_device_register_with_info().
> [   54.749748] ATK0110 ATK0110:00: GITM[0x6020011] ACPI exception:
> AE_BAD_PARAMETER
> [   54.752680] ATK0110 ATK0110:00: GITM[0x6020061] ACPI exception:
> AE_BAD_PARAMETER
> [   54.755502] ATK0110 ATK0110:00: GITM[0x6020062] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758310] ATK0110 ATK0110:00: GITM[0x6020063] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758390] ATK0110 ATK0110:00: GITM[0x6040013] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758466] ATK0110 ATK0110:00: GITM[0x6040073] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758527] ATK0110 ATK0110:00: GITM[0x60400c3] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758579] ATK0110 ATK0110:00: GITM[0x6030012] ACPI exception:
> AE_BAD_PARAMETER
> [   54.758631] ATK0110 ATK0110:00: GITM[0x6030074] ACPI exception:
> AE_BAD_PARAMETER
>
> This might be related to hard CPU lock-ups that I see later on, so for now
> I've unloaded the asus_atk0110 module to see if that prevents later
> lock-ups.
>
> I can supply more configuration/log information and run tests if anyone want
> them.

Can you please supply the full dmesg when booting with loglevel=7?
Also please attach a copy of the DSDT table (/sys/firmware/acpi/tables/DSDT).

L.
