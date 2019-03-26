From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / PM: Propagate KEY_POWER wakeup events to user space
Date: Tue, 26 Mar 2019 22:49:32 +0100
Message-ID: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
References: <20190304030022.22492-1-hu1.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304030022.22492-1-hu1.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Chen, Hu" <hu1.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 4, 2019 at 4:18 AM Chen, Hu <hu1.chen@intel.com> wrote:
>
> When the system is woken from S3 by the ACPI fixed power button, send
> KEY_POWER to user space.
>
> I run Android on x86 PC (it's a NUC). Everytime I press the power button
> to wake the system, it suspends right away. After some debug, I find
> that Android wants to see KEY_POWER at resume. Otherwise, its
> opportunistic suspend will kick in shortly.

Alas that extra button event will cause other (non-Android) systems to
want to power off immediately after resume AFAICS.

Something else needs to be done for the Android case.

> Signed-off-by: Chen, Hu <hu1.chen@intel.com>
> ---
>  drivers/acpi/button.c | 4 +++-
>  drivers/acpi/sleep.c  | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index a19ff3977ac4..117718057938 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -33,6 +33,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <acpi/button.h>
> +#include <linux/suspend.h>
>
>  #define PREFIX "ACPI: "
>
> @@ -417,7 +418,8 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>                         int keycode;
>
>                         acpi_pm_wakeup_event(&device->dev);
> -                       if (button->suspended)
> +                       if (button->suspended &&
> +                           mem_sleep_current == PM_SUSPEND_TO_IDLE)
>                                 break;
>
>                         keycode = test_bit(KEY_SLEEP, input->keybit) ?
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 403c4ff15349..c5dcee9f5872 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
>         return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
>  }
>
> +static void pwr_btn_notify(struct device *dev)
> +{
> +       struct acpi_device *device = to_acpi_device(dev);
> +
> +       device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
> +}
> +
>  /**
>   *     acpi_pm_finish - Instruct the platform to leave a sleep state.
>   *
> @@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
>                                       find_powerf_dev);
>         if (pwr_btn_dev) {
>                 pm_wakeup_event(pwr_btn_dev, 0);
> +               pwr_btn_notify(pwr_btn_dev);
>                 put_device(pwr_btn_dev);
>         }
>  }
> --
> 2.20.1
>
