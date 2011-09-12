From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/5] ACPI processor: Fix error path, also remove sysdev link
Date: Mon, 12 Sep 2011 10:46:36 -0700
Message-ID: <CAErSpo6FF4TEKjLGq5TXSTf8XU4yP7g9dSiwaNV36P_-Pcudgw@mail.gmail.com>
References: <1315784551-39118-1-git-send-email-trenn@suse.de> <1315784551-39118-4-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:20495 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1ILRrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2011 13:47:04 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p8CHl2C0021049
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:47:02 -0700
Received: from gyg8 (gyg8.prod.google.com [10.243.50.136])
	by hpaq11.eem.corp.google.com with ESMTP id p8CHkxJc001940
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:47:01 -0700
Received: by gyg8 with SMTP id 8so377361gyg.20
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2011 10:46:59 -0700 (PDT)
In-Reply-To: <1315784551-39118-4-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Sun, Sep 11, 2011 at 4:42 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> CC: Len Brown <lenb@kernel.org>
> CC: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/processor_driver.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor=
_driver.c
> index 9247e67..7bc141a 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -540,6 +540,7 @@ err_thermal_unregister:
> =A0 =A0 =A0 =A0thermal_cooling_device_unregister(pr->cdev);
> =A0err_power_exit:
> =A0 =A0 =A0 =A0acpi_processor_power_exit(pr, device);
> + =A0 =A0 =A0 sysfs_remove_link(&device->dev.kobj, "sysdev");

The sysfs_remove_link("sysdev") looks right to me.

acpi_processor_power_exit() looks like it is undoing whatever
acpi_processor_power_init() did earlier.  But we only called
_power_init() if we're using acpi_idle_driver, and we call
_power_exit() always.  That seems wrong.  It seems like you only want
to call _power_exit() if you successfully called _power_init().

Oh, and _power_init() can return failure, but we didn't check for it.
Seems like we ought to do *something*.  While you're looking at it,
I'd say the "if (!pr) return -EINVAL" in _power_init() should just be
removed.  It's impossible to call with pr=3D=3DNULL, and even if we cou=
ld,
I'd rather take the null pointer oops so we could find the problem.

I know these issues aren't your fault, but maybe you could fix them
since you're in the area?

Bjorn

> =A0err_free_cpumask:
> =A0 =A0 =A0 =A0free_cpumask_var(pr->throttling.shared_cpu_map);
>
> --
> 1.7.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
