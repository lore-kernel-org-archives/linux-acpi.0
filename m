From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/5] acpi: battery: make optional power_supply register
Date: Fri, 1 Jul 2016 00:10:29 +0200
Message-ID: <CAJZ5v0gFFdhaK+PkJJrO_dqGuhL5rscy-c6eh5yYH1QXrZY2Ew@mail.gmail.com>
References: <1467244819-19046-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1467244819-19046-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34612 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcF3WKb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 18:10:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so870538wmz.1
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jun 2016 15:10:30 -0700 (PDT)
In-Reply-To: <1467244819-19046-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jun 30, 2016 at 2:00 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Added additional paramater to acpi_battery_common_add(), which makes it
> optional to register with power_supply class or /proc/acpi/battery.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/battery.c        |  7 ++++++-
>  drivers/acpi/battery.h        |  2 +-
>  drivers/acpi/battery_common.c | 27 +++++++++++++++++----------
>  3 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index a5c9bde..5482d50 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -85,13 +85,18 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
>
>  static SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_common_resume);
>
> +static int acpi_battery_add(struct acpi_device *device)
> +{
> +       return acpi_battery_common_add(device, true);
> +}
> +
>  static struct acpi_driver acpi_battery_driver = {
>         .name = "battery",
>         .class = ACPI_BATTERY_CLASS,
>         .ids = battery_device_ids,
>         .flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>         .ops = {
> -               .add = acpi_battery_common_add,
> +               .add = acpi_battery_add,
>                 .remove = acpi_battery_common_remove,
>                 .notify = acpi_battery_common_notify,
>                 },
> diff --git a/drivers/acpi/battery.h b/drivers/acpi/battery.h
> index 99cac62..626093c 100644
> --- a/drivers/acpi/battery.h
> +++ b/drivers/acpi/battery.h
> @@ -26,7 +26,7 @@ extern int battery_bix_broken_package;
>  extern int battery_notification_delay_ms;
>  extern struct proc_dir_entry *acpi_battery_dir;
>
> -int acpi_battery_common_add(struct acpi_device *device);
> +int acpi_battery_common_add(struct acpi_device *device, bool power_supply_register);

I would call the second argument "real_battery" or similar.  An
analogously the new field in struct acpi_battery.

Then, I'd register with the power supply class if real_battery was true.
