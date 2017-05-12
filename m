From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 2/5] ACPI: button: Add button.lid_init_state=close
Date: Fri, 12 May 2017 11:55:48 +0200
Message-ID: <CAN+gG=H23wEZA0uc+3B6mERWtcxzdyZZ5uV6zL=F2SRgdSpw8Q@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <7c7f3a265974fb1f885dbfafcc0b97adc7b72f3b.1494311429.git.lv.zheng@intel.com>
 <CAN+gG=Ft+=z5FGindvp+h6BQcBuCRGpof5db4UX-Eny7NXypiA@mail.gmail.com> <1AE640813FDE7649BE1B193DEA596E886CEA2BC9@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35265 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757603AbdELJzu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2017 05:55:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id v4so12748875wmb.2
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2017 02:55:50 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CEA2BC9@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, May 12, 2017 at 3:31 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> Hi,
>
>> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Benjamin
>> Tissoires
>> Subject: Re: [PATCH v2 2/5] ACPI: button: Add button.lid_init_state=close
>>
>> On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
>> > We have tested that:
>> > 1. If ACPI button driver sends "open" to the user space but _LID return
>> >    value to the kernel space, external monitor issues still cannot be fixed
>> >    (link #1, comment #33, test result #2), while
>> > 2. if ACPI button driver sends "close" to the user space but _LID return
>> >    value to the kernel space, external monitor issues can be fixed (link
>> >    #1, comment #33, test result #3).
>> > We knew that some platforms require "open" to be sent to the user space to
>> > avoid entering a suspend/resume loop. So we have 2 contradictory user space
>> > requirements and are not possible to fix them both in 1 kernel driver mode
>> > without using platform specific quirks. This actually can also be treated
>> > as a proof that the root causes of the bugs are not in the kernel button
>> > driver but in the user space usage models.
>> >
>> > This patch adds button.lid_init_state=close so that it can explicitly
>> > explain the contradictory requirements and help the kernel community to
>> > raise such bugs to the correct responsibles.
>>
>> Well, I just can't see the difference between "close" and "method".
>> The intel driver actually triggers the evaluation of _LID, so this
>> explains why the value gets corrected on platform where the _LID
>> method is accurate.
>>
>> And I don't see the point of sending "close" to user space if close
>> means suspend loops and only fixes a dynamic case where you boot your
>> laptop with the lid closed. Do you expect users to append this option
>> at each boot when the lid is closed?
>
> There in fact is a difference.
> If a BIOS implements _LID using cached value.
> And BIOS AML code never generates lid notification after boot/resume.
> And the _LID default value is "open" after boot/resume.
>
> Then let's compare:
> 1. after boot:
> 1.1. button.lid_init_state=method sends open to the user space
> 1.2. button.lid_init_state=close sends close to the user space
> 2. after resume:
> 1.1. button.lid_init_state=method sends open to the user space
> 1.2. button.lid_init_state=close sends close to the user space
>
> See, that's the difference.
>
> If there is such a platform, for the reported user space issues,
> button.lid_init_state=method cannot work for them,
> they'll have to use button.lid_init_state=close
> to achieve the expected behavior.
>
> So I believe this mode is useful.

I don't buy it because you are missing a parameter here: what is the
actual state of the lid (open or closed).
And if you report "close" while it's opened, that's not good.

So maybe, it can be interesting for debugging, but for end users, I
don't see why anyone would use it. Because a laptop can be moved,
docked or not, and this is a static parameter. So there will always be
a state where you will be reporting a false state.

Cheers,
Benjamin

>
> Cheers,
> Lv
>
>>
>> Cheers,
>> Benjamin
>>
>> >
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=195455 [#1]
>> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1430259
>> > Tested-by: Steffen Weber <steffen.weber@gmail.com>
>> > Tested-by: Julian Wiedmann <julian.wiedmann@jwi.name>
>> > Reported-by: Joachim Frieben <jfrieben@hotmail.com>
>> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>> > ---
>> >  Documentation/acpi/acpi-lid.txt | 12 +++++++-----
>> >  drivers/acpi/button.c           | 11 ++++++++++-
>> >  2 files changed, 17 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/Documentation/acpi/acpi-lid.txt b/Documentation/acpi/acpi-lid.txt
>> > index effe7af..e846a59 100644
>> > --- a/Documentation/acpi/acpi-lid.txt
>> > +++ b/Documentation/acpi/acpi-lid.txt
>> > @@ -69,13 +69,15 @@ A. button.lid_init_state=method:
>> >     notification is missing.
>> >     This option is the default behavior during the period the userspace
>> >     isn't ready to handle the buggy AML tables.
>> > -B. button.lid_init_state=open:
>> > -   When this option is specified, the ACPI button driver always reports the
>> > -   initial lid state as "opened" and whether the "opened"/"closed" events
>> > -   are paired fully relies on the firmware implementation.
>> > +B. button.lid_init_state=open/close:
>> > +   When one of these options are specified, the ACPI button driver always
>> > +   reports the initial lid state as fixed "opened"/"closed" and whether the
>> > +   "opened"/"closed" events are paired fully relies on the firmware
>> > +   implementation.
>> >     This may fix some platforms where the returning value of the _LID
>> >     control method is not reliable and the initial lid state notification is
>> > -   missing.
>> > +   missing. Especially useful for platforms where different usage models
>> > +   require contractory initial lid state.
>> >
>> >  If the userspace has been prepared to ignore the unreliable "opened" events
>> >  and the unreliable initial state notification, Linux users should always
>> > diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>> > index 6d5a8c1..8b4666f 100644
>> > --- a/drivers/acpi/button.c
>> > +++ b/drivers/acpi/button.c
>> > @@ -57,7 +57,8 @@
>> >
>> >  #define ACPI_BUTTON_LID_INIT_IGNORE    0x00
>> >  #define ACPI_BUTTON_LID_INIT_OPEN      0x01
>> > -#define ACPI_BUTTON_LID_INIT_METHOD    0x02
>> > +#define ACPI_BUTTON_LID_INIT_CLOSE     0x02
>> > +#define ACPI_BUTTON_LID_INIT_METHOD    0x03
>> >
>> >  #define _COMPONENT             ACPI_BUTTON_COMPONENT
>> >  ACPI_MODULE_NAME("button");
>> > @@ -377,6 +378,9 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
>> >         case ACPI_BUTTON_LID_INIT_OPEN:
>> >                 (void)acpi_lid_notify_state(device, 1);
>> >                 break;
>> > +       case ACPI_BUTTON_LID_INIT_CLOSE:
>> > +               (void)acpi_lid_notify_state(device, 0);
>> > +               break;
>> >         case ACPI_BUTTON_LID_INIT_METHOD:
>> >                 (void)acpi_lid_update_state(device);
>> >                 break;
>> > @@ -563,6 +567,9 @@ static int param_set_lid_init_state(const char *val, struct kernel_param *kp)
>> >         if (!strncmp(val, "open", sizeof("open") - 1)) {
>> >                 lid_init_state = ACPI_BUTTON_LID_INIT_OPEN;
>> >                 pr_info("Notify initial lid state as open\n");
>> > +       } else if (!strncmp(val, "close", sizeof("close") - 1)) {
>> > +               lid_init_state = ACPI_BUTTON_LID_INIT_CLOSE;
>> > +               pr_info("Notify initial lid state as close\n");
>> >         } else if (!strncmp(val, "method", sizeof("method") - 1)) {
>> >                 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
>> >                 pr_info("Notify initial lid state with _LID return value\n");
>> > @@ -579,6 +586,8 @@ static int param_get_lid_init_state(char *buffer, struct kernel_param *kp)
>> >         switch (lid_init_state) {
>> >         case ACPI_BUTTON_LID_INIT_OPEN:
>> >                 return sprintf(buffer, "open");
>> > +       case ACPI_BUTTON_LID_INIT_CLOSE:
>> > +               return sprintf(buffer, "close");
>> >         case ACPI_BUTTON_LID_INIT_METHOD:
>> >                 return sprintf(buffer, "method");
>> >         case ACPI_BUTTON_LID_INIT_IGNORE:
>> > --
>> > 2.7.4
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
