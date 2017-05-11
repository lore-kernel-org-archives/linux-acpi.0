From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 4/5] ACPI: button: Always notify kernel space using
 _LID returning value
Date: Thu, 11 May 2017 12:28:21 +0200
Message-ID: <CAN+gG=HuwVz_vvW3Y8ZZ9DWWpcA8FO1QzGDio1nhe=3Y6xmdSQ@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <81c156ff4ba959afba755182979227c90c6b6776.1494311429.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35388 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdEKK2X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2017 06:28:23 -0400
Received: by mail-wr0-f193.google.com with SMTP id g12so2878227wrg.2
        for <linux-acpi@vger.kernel.org>; Thu, 11 May 2017 03:28:22 -0700 (PDT)
In-Reply-To: <81c156ff4ba959afba755182979227c90c6b6776.1494311429.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> Both nouveau and i915, the only 2 kernel space lid notification listeners,
> invoke acpi_lid_open() API to obtain _LID returning value instead of using
> the notified value.
>
> So this patch moves this logic from listeners to lid driver, always notify
> kernel space listeners using _LID returning value.
>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/button.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index b91ff86..7ff3a75 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -119,6 +119,9 @@ static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>  static unsigned long lid_report_interval __read_mostly = 500;
>  module_param(lid_report_interval, ulong, 0644);
>  MODULE_PARM_DESC(lid_report_interval, "Interval (ms) between lid key events");
> +static bool lid_fake_events __read_mostly = true;
> +module_param(lid_fake_events, bool, 0644);
> +MODULE_PARM_DESC(lid_fake_events, "Deliver fake events to kernel drivers");
>
>  /* --------------------------------------------------------------------------
>                                FS Interface (/proc)
> @@ -139,7 +142,8 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
>         return lid_state ? 1 : 0;
>  }
>
> -static void acpi_lid_notify_state(struct acpi_device *device, int state)
> +static void acpi_lid_notify_state(struct acpi_device *device,
> +                                 int state, bool bios_notify)
>  {
>         struct acpi_button *button = acpi_driver_data(device);
>         ktime_t next_report;
> @@ -219,7 +223,11 @@ static void acpi_lid_notify_state(struct acpi_device *device, int state)
>         if (state)
>                 pm_wakeup_event(&device->dev, 0);
>
> -       atomic_notifier_call_chain(&acpi_lid_notifier, state, device);
> +       if (bios_notify)
> +               atomic_notifier_call_chain(&acpi_lid_notifier, state, device);
> +       else if (lid_fake_events)
> +               atomic_notifier_call_chain(&acpi_lid_notifier,
> +                       acpi_lid_evaluate_state(device), device);

I don't quite get the "lid_fake_event" parameter. If set, you are
forwarding the evaluated method, which should be correct, not faked...

Also, what if bios_notify is false and so is lid_fake_events? Is that
expected that no events are forwarded?

Honestly, adding one more kernel parameter doesn't seem to solve
anything, it just adds more blur on a blurry situation.

How about:
- you keep the "ignore", "method" and "open" (because they are kernel
API now) and don't add more
- you revert the "method" initial lid state, as requested by me and
others hitting the docking station "bug"
- you just let user space deal with false lid switch values by
forwarding the bugs to libinput.

IMO, we don't need such patch.

Cheers,
Benjamin

>  }
>
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
> @@ -349,7 +357,8 @@ int acpi_lid_open(void)
>  }
>  EXPORT_SYMBOL(acpi_lid_open);
>
> -static int acpi_lid_update_state(struct acpi_device *device)
> +static int acpi_lid_update_state(struct acpi_device *device,
> +                                bool bios_notify)
>  {
>         int state;
>
> @@ -357,7 +366,7 @@ static int acpi_lid_update_state(struct acpi_device *device)
>         if (state < 0)
>                 return state;
>
> -       acpi_lid_notify_state(device, state);
> +       acpi_lid_notify_state(device, state, bios_notify);
>         return 0;
>  }
>
> @@ -365,13 +374,13 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>  {
>         switch (lid_init_state) {
>         case ACPI_BUTTON_LID_INIT_OPEN:
> -               (void)acpi_lid_notify_state(device, 1);
> +               (void)acpi_lid_notify_state(device, 1, false);
>                 break;
>         case ACPI_BUTTON_LID_INIT_CLOSE:
> -               (void)acpi_lid_notify_state(device, 0);
> +               (void)acpi_lid_notify_state(device, 0, false);
>                 break;
>         case ACPI_BUTTON_LID_INIT_METHOD:
> -               (void)acpi_lid_update_state(device);
> +               (void)acpi_lid_update_state(device, false);
>                 break;
>         case ACPI_BUTTON_LID_INIT_IGNORE:
>         default:
> @@ -391,7 +400,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>         case ACPI_BUTTON_NOTIFY_STATUS:
>                 input = button->input;
>                 if (button->type == ACPI_BUTTON_TYPE_LID) {
> -                       acpi_lid_update_state(device);
> +                       acpi_lid_update_state(device, true);
>                 } else {
>                         int keycode;
>
> @@ -555,13 +564,13 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
>
>         if (!strncmp(val, "open", sizeof("open") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> -               pr_info("Notify initial lid state as open\n");
> +               pr_info("Notify initial lid state to users space as open and kernel drivers with _LID return value\n");
>         } else if (!strncmp(val, "close", sizeof("close") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_CLOSE;
> -               pr_info("Notify initial lid state as close\n");
> +               pr_info("Notify initial lid state to user space as close and kernel drivers with _LID return value\n");
>         } else if (!strncmp(val, "method", sizeof("method") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> -               pr_info("Notify initial lid state with _LID return value\n");
> +               pr_info("Notify initial lid state to user/kernel space with _LID return value\n");
>         } else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
>                 pr_info("Do not notify initial lid state\n");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
