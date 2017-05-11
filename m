From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 2/5] ACPI: button: Add button.lid_init_state=close
Date: Thu, 11 May 2017 12:20:22 +0200
Message-ID: <CAN+gG=Ft+=z5FGindvp+h6BQcBuCRGpof5db4UX-Eny7NXypiA@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <7c7f3a265974fb1f885dbfafcc0b97adc7b72f3b.1494311429.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36814 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755274AbdEKKUY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2017 06:20:24 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so2839651wrc.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 May 2017 03:20:23 -0700 (PDT)
In-Reply-To: <7c7f3a265974fb1f885dbfafcc0b97adc7b72f3b.1494311429.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> We have tested that:
> 1. If ACPI button driver sends "open" to the user space but _LID return
>    value to the kernel space, external monitor issues still cannot be fixed
>    (link #1, comment #33, test result #2), while
> 2. if ACPI button driver sends "close" to the user space but _LID return
>    value to the kernel space, external monitor issues can be fixed (link
>    #1, comment #33, test result #3).
> We knew that some platforms require "open" to be sent to the user space to
> avoid entering a suspend/resume loop. So we have 2 contradictory user space
> requirements and are not possible to fix them both in 1 kernel driver mode
> without using platform specific quirks. This actually can also be treated
> as a proof that the root causes of the bugs are not in the kernel button
> driver but in the user space usage models.
>
> This patch adds button.lid_init_state=close so that it can explicitly
> explain the contradictory requirements and help the kernel community to
> raise such bugs to the correct responsibles.

Well, I just can't see the difference between "close" and "method".
The intel driver actually triggers the evaluation of _LID, so this
explains why the value gets corrected on platform where the _LID
method is accurate.

And I don't see the point of sending "close" to user space if close
means suspend loops and only fixes a dynamic case where you boot your
laptop with the lid closed. Do you expect users to append this option
at each boot when the lid is closed?

Cheers,
Benjamin

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=195455 [#1]
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1430259
> Tested-by: Steffen Weber <steffen.weber@gmail.com>
> Tested-by: Julian Wiedmann <julian.wiedmann@jwi.name>
> Reported-by: Joachim Frieben <jfrieben@hotmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  Documentation/acpi/acpi-lid.txt | 12 +++++++-----
>  drivers/acpi/button.c           | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
> index effe7af..e846a59 100644
> --- a/Documentation/acpi/acpi-lid.txt
> +++ b/Documentation/acpi/acpi-lid.txt
> @@ -69,13 +69,15 @@ A. button.lid_init_state=method:
>     notification is missing.
>     This option is the default behavior during the period the userspace
>     isn't ready to handle the buggy AML tables.
> -B. button.lid_init_state=open:
> -   When this option is specified, the ACPI button driver always reports the
> -   initial lid state as "opened" and whether the "opened"/"closed" events
> -   are paired fully relies on the firmware implementation.
> +B. button.lid_init_state=open/close:
> +   When one of these options are specified, the ACPI button driver always
> +   reports the initial lid state as fixed "opened"/"closed" and whether the
> +   "opened"/"closed" events are paired fully relies on the firmware
> +   implementation.
>     This may fix some platforms where the returning value of the _LID
>     control method is not reliable and the initial lid state notification is
> -   missing.
> +   missing. Especially useful for platforms where different usage models
> +   require contractory initial lid state.
>
>  If the userspace has been prepared to ignore the unreliable "opened" events
>  and the unreliable initial state notification, Linux users should always
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 6d5a8c1..8b4666f 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -57,7 +57,8 @@
>
>  #define ACPI_BUTTON_LID_INIT_IGNORE    0x00
>  #define ACPI_BUTTON_LID_INIT_OPEN      0x01
> -#define ACPI_BUTTON_LID_INIT_METHOD    0x02
> +#define ACPI_BUTTON_LID_INIT_CLOSE     0x02
> +#define ACPI_BUTTON_LID_INIT_METHOD    0x03
>
>  #define _COMPONENT             ACPI_BUTTON_COMPONENT
>  ACPI_MODULE_NAME("button");
> @@ -377,6 +378,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>         case ACPI_BUTTON_LID_INIT_OPEN:
>                 (void)acpi_lid_notify_state(device, 1);
>                 break;
> +       case ACPI_BUTTON_LID_INIT_CLOSE:
> +               (void)acpi_lid_notify_state(device, 0);
> +               break;
>         case ACPI_BUTTON_LID_INIT_METHOD:
>                 (void)acpi_lid_update_state(device);
>                 break;
> @@ -563,6 +567,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
>         if (!strncmp(val, "open", sizeof("open") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>                 pr_info("Notify initial lid state as open\n");
> +       } else if (!strncmp(val, "close", sizeof("close") - 1)) {
> +               lid_init_state = ACPI_BUTTON_LID_INIT_CLOSE;
> +               pr_info("Notify initial lid state as close\n");
>         } else if (!strncmp(val, "method", sizeof("method") - 1)) {
>                 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
>                 pr_info("Notify initial lid state with _LID return value\n");
> @@ -579,6 +586,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
>         switch (lid_init_state) {
>         case ACPI_BUTTON_LID_INIT_OPEN:
>                 return sprintf(buffer, "open");
> +       case ACPI_BUTTON_LID_INIT_CLOSE:
> +               return sprintf(buffer, "close");
>         case ACPI_BUTTON_LID_INIT_METHOD:
>                 return sprintf(buffer, "method");
>         case ACPI_BUTTON_LID_INIT_IGNORE:
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
