From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Leave modalias empty for devices
 which are not present
Date: Mon, 16 Oct 2017 01:47:20 +0200
Message-ID: <CAJZ5v0hAx_-OUQNBngScNKHstZhZ42A42LwcBOFhR2g5pCFXOA@mail.gmail.com>
References: <20171015192449.16035-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34933 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdJOXrW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Oct 2017 19:47:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id e123so5998901oig.2
        for <linux-acpi@vger.kernel.org>; Sun, 15 Oct 2017 16:47:21 -0700 (PDT)
In-Reply-To: <20171015192449.16035-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sun, Oct 15, 2017 at 9:24 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Most Bay and Cherry Trail devices use a generic DSDT with all possible
> peripheral devices present in the DSDT, with their _STA returning 0x00 or
> 0x0f based on AML variables which describe what is actually present on
> the board.
>
> Since ACPI device objects with a 0x00 status (not present) still get an
> entry under /sys/bus/acpi/devices, and those entry had an acpi:PNPID
> modalias, userspace would end up loading modules for non present hardware.
>
> This commit fixes this by leaving the modalias empty for non present
> devices. This results in 10 modules less being loaded with a generic
> distro kernel config on my Cherry Trail test-device (a GPD pocket).

Well, what about hotplug?

On some systems _STA may change from 0 to nonzero for some devices, so
what's going to happen to the modalias then?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/device_sysfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 24418932612e..a041689e5701 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -146,6 +146,10 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
>         int count;
>         struct acpi_hardware_id *id;
>
> +       /* Avoid unnecessarily loading modules for non present devices. */
> +       if (!acpi_device_is_present(acpi_dev))
> +               return 0;
> +
>         /*
>          * Since we skip ACPI_DT_NAMESPACE_HID from the modalias below, 0 should
>          * be returned if ACPI_DT_NAMESPACE_HID is the only ACPI/PNP ID in the
> --
