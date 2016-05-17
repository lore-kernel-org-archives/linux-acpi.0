From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 1/2] ACPI / button: Send "open" state after boot/resume
Date: Wed, 18 May 2016 01:36:31 +0200
Message-ID: <CAJZ5v0g6RM53oTWRGF-7k2=dDktawmOZbJY56xDXRbQcKoWpmg@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33627 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbcEQXgd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 19:36:33 -0400
In-Reply-To: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>

On Tue, May 17, 2016 at 10:27 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> (This patch hasn't been tested, it's sent for comments)

I have a couple of concerns (see below).

> Linux userspace (systemd-logind) keeps on rechecking lid state when the
> lid state is closed. If it failed to update the lid state to open after
> boot/resume, it could suspend the system. But as:
> 1. Traditional ACPI platform may not generate the lid open event after
>    resuming as the open event is actually handled by the BIOS and the system
>    is then resumed from a FACS vector.
> 2. The _LID control method's initial returning value is not reliable. The
>    _LID control method is described to return the "current" lid state,
>    however the word of "current" has ambiguity, many BIOSen return lid
>    state upon last lid notification while the developers may think the
>    BIOSen should always return the lid state upon last _LID evaluation.
>    There won't be difference when we evaluate _LID during the runtime, the
>    problem is the initial returning value of this function. When the BIOSen
>    implement this control method with cached value, the initial returning
>    value is likely not reliable.
> Thus there is no mean for the ACPI lid driver to provide such an event
> conveying correct current lid state. When there is no such an event or the
> event conveys wrong result, false suspending can be examined.
>
> The root cause of the issue is systemd itself, it could handle the ACPI
> control method lid device by implementing a special option like
> LidSwitchLevelTriggered=False when it detected the ACPI lid device. However
> there is no explicit documentation clarified the ambiguity, we need to
> work it around in the kernel before systemd changing its mind.

The above doesn't explain how the issue is addressed here.

> Link 1: https://lkml.org/2016/3/7/460
> Link 2: https://github.com/systemd/systemd/issues/2087
> Link 3: https://bugzilla.kernel.org/show_bug.cgi?id=89211
>         https://bugzilla.kernel.org/show_bug.cgi?id=106151
>         https://bugzilla.kernel.org/show_bug.cgi?id=106941
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Bastien Nocera: <hadess@hadess.net>
> ---
>  drivers/acpi/button.c |   63 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 5c3b091..bb14ca5 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -53,6 +53,10 @@
>  #define ACPI_BUTTON_DEVICE_NAME_LID    "Lid Switch"
>  #define ACPI_BUTTON_TYPE_LID           0x05
>
> +#define ACPI_BUTTON_LID_INIT_IGNORE    0x00
> +#define ACPI_BUTTON_LID_INIT_OPEN      0x01
> +#define ACPI_BUTTON_LID_INIT_METHOD    0x02
> +
>  #define _COMPONENT             ACPI_BUTTON_COMPONENT
>  ACPI_MODULE_NAME("button");
>
> @@ -105,6 +109,7 @@ struct acpi_button {
>
>  static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
>  static struct acpi_device *lid_device;
> +static u8 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>
>  /* --------------------------------------------------------------------------
>                                FS Interface (/proc)
> @@ -246,7 +251,8 @@ int acpi_lid_open(void)
>  }
>  EXPORT_SYMBOL(acpi_lid_open);
>
> -static int acpi_lid_send_state(struct acpi_device *device)
> +static int acpi_lid_send_state(struct acpi_device *device,
> +                              bool notify_init_state)
>  {
>         struct acpi_button *button = acpi_driver_data(device);
>         unsigned long long state;
> @@ -257,6 +263,10 @@ static int acpi_lid_send_state(struct acpi_device *device)
>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
>
> +       if (notify_init_state &&
> +           lid_init_state == ACPI_BUTTON_LID_INIT_OPEN)
> +               state = 1;
> +

Why do we need to complicate this function?

Can't we have a separate function for sending the fake "lid open" event?

>         /* input layer checks if event is redundant */
>         input_report_switch(button->input, SW_LID, !state);
>         input_sync(button->input);
> @@ -278,6 +288,13 @@ static int acpi_lid_send_state(struct acpi_device *device)
>         return ret;
>  }
>
> +static int acpi_lid_send_init_state(struct acpi_device *device)
> +{
> +       if (lid_init_state != ACPI_BUTTON_LID_INIT_IGNORE)
> +               return acpi_lid_send_state(device, true);
> +       return 0;
> +}
> +
>  static void acpi_button_notify(struct acpi_device *device, u32 event)
>  {
>         struct acpi_button *button = acpi_driver_data(device);
> @@ -290,7 +307,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>         case ACPI_BUTTON_NOTIFY_STATUS:
>                 input = button->input;
>                 if (button->type == ACPI_BUTTON_TYPE_LID) {
> -                       acpi_lid_send_state(device);
> +                       acpi_lid_send_state(device, false);

I wouldn't change this code at all.

>                 } else {
>                         int keycode;
>
> @@ -335,7 +352,7 @@ static int acpi_button_resume(struct device *dev)
>
>         button->suspended = false;
>         if (button->type == ACPI_BUTTON_TYPE_LID)
> -               return acpi_lid_send_state(device);
> +               return acpi_lid_send_init_state(device);
>         return 0;
>  }
>  #endif
> @@ -416,7 +433,7 @@ static int acpi_button_add(struct acpi_device *device)
>         if (error)
>                 goto err_remove_fs;
>         if (button->type == ACPI_BUTTON_TYPE_LID) {
> -               acpi_lid_send_state(device);
> +               acpi_lid_send_init_state(device);
>                 /*
>                  * This assumes there's only one lid device, or if there are
>                  * more we only care about the last one...
> @@ -446,4 +463,42 @@ static int acpi_button_remove(struct acpi_device *device)
>         return 0;
>  }
>
> +static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
> +{
> +       int result = 0;
> +
> +       if (!strncmp(val, "open", sizeof("open") - 1)) {
> +               lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
> +               pr_info("Notify initial lid state as open\n");
> +       } else if (!strncmp(val, "method", sizeof("method") - 1)) {
> +               lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
> +               pr_info("Notify initial lid state with _LID return value\n");
> +       } else if (!strncmp(val, "ignore", sizeof("ignore") - 1)) {
> +               lid_init_state = ACPI_BUTTON_LID_INIT_IGNORE;
> +               pr_info("Do not notify initial lid state\n");
> +       } else
> +               result = -EINVAL;
> +       return result;
> +}
> +
> +static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
> +{
> +       switch (lid_init_state) {
> +       case ACPI_BUTTON_LID_INIT_OPEN:
> +               return sprintf(buffer, "open");
> +       case ACPI_BUTTON_LID_INIT_METHOD:
> +               return sprintf(buffer, "method");
> +       case ACPI_BUTTON_LID_INIT_IGNORE:
> +               return sprintf(buffer, "ignore");
> +       default:
> +               return sprintf(buffer, "invalid");
> +       }
> +       return 0;
> +}
> +
> +module_param_call(lid_init_state,
> +                 param_set_lid_init_state, param_get_lid_init_state,
> +                 NULL, 0644);
> +MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
> +

I'm not seeing a particular value in having this command line switch
to be honest.  Apparently, the issue can be worked around from user
space in any case, so why do we need one more way to work around it?

>  module_acpi_driver(acpi_button_driver);
> --

The main concern is general, though.  Evidently, we send fake lid
input events to user space on init and resume.  I don't think this is
a good idea, because it may confuse systems like Chrome that want to
implement "dark resume" scenarios and may rely on input events to
decide whether to start a UI or suspend again.

Thus it might be better to simply drop the sending of those fake input
events from the code.
