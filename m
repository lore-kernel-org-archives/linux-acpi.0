From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: button: Fix lid notification
Date: Thu, 11 May 2017 12:21:16 +0200
Message-ID: <CAN+gG=GVhe-xfEt_zF4C2q+EDXjEAu-xWN=TRJn0BURnzjCGRw@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <ed2a5c00b7dbb5b72f3a7e263a8cf3e214fd1c4f.1494311429.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36825 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdEKKVS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2017 06:21:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so5838376wmu.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 May 2017 03:21:17 -0700 (PDT)
In-Reply-To: <ed2a5c00b7dbb5b72f3a7e263a8cf3e214fd1c4f.1494311429.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> In acpi_lid_notify_state(), it now contains logic to avoid duplicate
> notifications which originally was ensured by using blocking notifier. On
> the contrary, using blocking notifier is wrong as it could keep on
> returning NOTIFY_DONE, causing events lost.
> This patch thus changes lid notification to atomic notifier in order not to
> have events lost.
>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---

Looks good to me:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin


>  drivers/acpi/button.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 8b4666f..b91ff86 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -112,7 +112,7 @@ struct acpi_button {
>         bool suspended;
>  };
>
> -static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
> +static ATOMIC_NOTIFIER_HEAD(acpi_lid_notifier);
>  static struct acpi_device *lid_device;
>  static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>
> @@ -139,10 +139,9 @@ static int acpi_lid_evaluate_state(struct acpi_device *device)
>         return lid_state ? 1 : 0;
>  }
>
> -static int acpi_lid_notify_state(struct acpi_device *device, int state)
> +static void acpi_lid_notify_state(struct acpi_device *device, int state)
>  {
>         struct acpi_button *button = acpi_driver_data(device);
> -       int ret;
>         ktime_t next_report;
>         bool do_update;
>
> @@ -220,18 +219,7 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
>         if (state)
>                 pm_wakeup_event(&device->dev, 0);
>
> -       ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
> -       if (ret == NOTIFY_DONE)
> -               ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
> -                                                  device);
> -       if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
> -               /*
> -                * It is also regarded as success if the notifier_chain
> -                * returns NOTIFY_OK or NOTIFY_DONE.
> -                */
> -               ret = 0;
> -       }
> -       return ret;
> +       atomic_notifier_call_chain(&acpi_lid_notifier, state, device);
>  }
>
>  static int acpi_button_state_seq_show(struct seq_file *seq, void *offset)
> @@ -342,13 +330,13 @@ static int acpi_button_remove_fs(struct acpi_device *device)
>     -------------------------------------------------------------------------- */
>  int acpi_lid_notifier_register(struct notifier_block *nb)
>  {
> -       return blocking_notifier_chain_register(&acpi_lid_notifier, nb);
> +       return atomic_notifier_chain_register(&acpi_lid_notifier, nb);
>  }
>  EXPORT_SYMBOL(acpi_lid_notifier_register);
>
>  int acpi_lid_notifier_unregister(struct notifier_block *nb)
>  {
> -       return blocking_notifier_chain_unregister(&acpi_lid_notifier, nb);
> +       return atomic_notifier_chain_unregister(&acpi_lid_notifier, nb);
>  }
>  EXPORT_SYMBOL(acpi_lid_notifier_unregister);
>
> @@ -369,7 +357,8 @@ static int acpi_lid_update_state(struct acpi_device *device)
>         if (state < 0)
>                 return state;
>
> -       return acpi_lid_notify_state(device, state);
> +       acpi_lid_notify_state(device, state);
> +       return 0;
>  }
>
>  static void acpi_lid_initialize_state(struct acpi_device *device)
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
