From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: button: Add an info message when we're sending
 a LID closed event
Date: Wed, 15 Nov 2017 18:16:31 +0100
Message-ID: <CAJZ5v0iHNj3XD1XWPrp_XZD+Nq-YzG665Ar+BeyCLfJEUT-nbQ@mail.gmail.com>
References: <20171115140718.13026-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46333 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbdKORQc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Nov 2017 12:16:32 -0500
Received: by mail-oi0-f65.google.com with SMTP id n16so7459155oig.3
        for <linux-acpi@vger.kernel.org>; Wed, 15 Nov 2017 09:16:31 -0800 (PST)
In-Reply-To: <20171115140718.13026-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Nov 15, 2017 at 3:07 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> I've been debugging some spurious suspend issues on various devices,
> at least on some devices these spurious suspends are caused by surious
> LID closed events being send to userspace.
>
> Running e.g. evemu-record after noticing a spurious suspend is too late
> to detect that a LID closed event it the (probable) cause of this.
> This commit adds a pr_info("ACPI LID closed\n") call to help debugging.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/button.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index ef1856b15488..07da60fe9cae 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -210,6 +210,9 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>         }
>         /* Send the platform triggered reliable event */
>         if (do_update) {
> +               if (!state)
> +                       pr_info("ACPI LID closed\n");

Why pr_info()?

> +
>                 input_report_switch(button->input, SW_LID, !state);
>                 input_sync(button->input);
>                 button->last_state = !!state;
> --
> 2.14.3
>
> --
