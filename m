From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] acpi: handle the acpi hotplug schedule error
Date: Wed, 7 Jun 2017 11:36:55 +0300
Message-ID: <CAHp75Vdeagae37PHoD4yw4dncFQJ2tmuxRu0zzbH_b+SnY4pEQ@mail.gmail.com>
References: <20170607060527.23407-1-jlee@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33586 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbdFGIg4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2017 04:36:56 -0400
In-Reply-To: <20170607060527.23407-1-jlee@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>

On Wed, Jun 7, 2017 at 9:05 AM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> Kernel should decrements the reference count of acpi device
> when scheduling acpi hotplug work is failed, and also evaluates
> _OST to notify BIOS the failure.

> -       if (hotplug_event && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
> -               return;
> +       if (hotplug_event) {
> +               if (ACPI_FAILURE(acpi_hotplug_schedule(adev, type))) {
> +                       acpi_bus_put_acpi_device(adev);
> +                       goto err;
> +               } else {
> +                       return;
> +               }
> +       }

Wouldn't be simpler to

-               return;
+               goto err_put_device;

+ err_put_device:
+       acpi_bus_put_acpi_device(adev);
 err:

-- 
With Best Regards,
Andy Shevchenko
