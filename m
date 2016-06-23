From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
Date: Thu, 23 Jun 2016 15:12:59 +0200
Message-ID: <CAJZ5v0iR6KU+Oy3iP5Ungw2cpqpmRBPw6fy26OL+cjFUnMJCUg@mail.gmail.com>
References: <1462772495-71113-1-git-send-email-hehy1@lenovo.com>
 <2611430.1T9CgX71hW@vostro.rjw.lan> <BCBE834BAC19744BA2C3AC4D68DBF2198D8AC790@CNMAILEX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38584 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbcFWNNC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2016 09:13:02 -0400
In-Reply-To: <BCBE834BAC19744BA2C3AC4D68DBF2198D8AC790@CNMAILEX03.lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>

On Thu, Jun 23, 2016 at 2:55 PM, Ocean HY1 He <hehy1@lenovo.com> wrote:
> Hi Rafael,
> Please see my reply in below.
>
> Regards,
> Ocean He
> SW Development Dept.
> Beijing Design Center
> Enterprise Product Group
> Mobile: 18911778926
> E-mail: hehy1@lenovo.com
> No.6 Chuang Ye Road, Haidian District, Beijing, China 100085
>
>> -----Original Message-----
>> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
>> Sent: Wednesday, June 22, 2016 7:56 AM
>> To: Ocean HY1 He
>> Cc: lenb@kernel.org; linux-acpi@vger.kernel.org;
>> linux-kernel@vger.kernel.org; David Tanaka; Nagananda Chumbalkar
>> Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
>>
>> On Monday, May 09, 2016 05:50:11 AM Ocean HY1 He wrote:
>> > The _PTS control method is defined in the section 7.4.1 of acpi 6.0
>> > spec. The _PTS control method is executed by the OS during the sleep
>> > transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
>> > The sleeping state value (For example, 1, 2, 3, 4 or 5 for the S5
>> > soft-off state) is passed to the _PTS control method. This method
>> > is called after OSPM has notified native device drivers of the sleep
>> > state transition and before the OSPM has had a chance to fully
>> > prepare the system for a sleep state transition.
>> >
>> > The _PTS control method provides the BIOS a mechanism for performing
>> > some housekeeping, such as writing the sleep type value to the
>> embedded
>> > controller, before entering the system sleeping state.
>> >
>> > According to section 7.5 of acpi 6.0 spec, _PTS should run after _TTS.
>> >
>> > Thus, a _PTS block notifier is added to the reboot notifier list so that
>> > the _PTS object will also be evaluated when the system reboot.
>>
>> So I understand why it may be necessary to evaluate _PTS before entering
>> S5,
>> but I'm totally unsure about reboot.
>>
>> What does reboot have to do with S5?
>>
> In ACPI spec, there is no explicit words saying _PTS should be
> executed when reboot. But reboot could be equal to the
> process S0->S5->S0.

Not in general.

In particular, wakeup devices that would be set up for S5 need not be
set up for that.  Also the mechanism by which transitions to S5 are
entered is different from the reboot one, at least from the OS
perspective.

> Thus _PTS should be executed when reboot.

No, it doesn't follow.

> I am thinking this is the same as _TTS. In ACPI spec, there is also
> no explicit words saying _TTS should be executed when reboot.
> But kernel executes _TTS when reboot indeed.

Yes, it does.  Maybe it shouldn't?

It may not hurt to call _PTS before reboot too, but is it guaranteed
to work across the board on all systems everywhere?

>> > Signed-off-by: Ocean He <hehy1@lenovo.com>
>> > Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
>> > ---
>> >  drivers/acpi/sleep.c | 27 +++++++++++++++++++++++++++
>> >  1 file changed, 27 insertions(+)
>> >
>> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> > index 2a8b596..8b290fb 100644
>> > --- a/drivers/acpi/sleep.c
>> > +++ b/drivers/acpi/sleep.c
>> > @@ -55,6 +55,26 @@ static struct notifier_block tts_notifier = {
>> >     .priority       = 0,
>> >  };
>> >
>> > +static int pts_notify_reboot(struct notifier_block *this,
>> > +                   unsigned long code, void *x)
>> > +{
>> > +   acpi_status status;
>> > +
>> > +   status = acpi_execute_simple_method(NULL, "\\_PTS",
>> ACPI_STATE_S5);
>> > +   if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>> > +           /* It won't break anything. */
>> > +           printk(KERN_NOTICE "Failure in evaluating _PTS object\n");
>> > +   }
>> > +
>> > +   return NOTIFY_DONE;
>> > +}
>> > +
>> > +static struct notifier_block pts_notifier = {
>> > +   .notifier_call  = pts_notify_reboot,
>> > +   .next           = NULL,
>> > +   .priority       = 0,
>> > +};
>> > +
>> >  static int acpi_sleep_prepare(u32 acpi_state)
>> >  {
>> >  #ifdef CONFIG_ACPI_SLEEP
>> > @@ -896,5 +916,12 @@ int __init acpi_sleep_init(void)
>> >      * object can also be evaluated when the system enters S5.
>> >      */
>> >     register_reboot_notifier(&tts_notifier);
>> > +
>> > +   /*
>> > +    * According to section 7.5 of acpi 6.0 spec, _PTS should run after
>> > +    * _TTS when the system enters S5.
>> > +    */
>> > +   register_reboot_notifier(&pts_notifier);
>>
>> Why do you have to add a second notifier?
>>
>> Why can't _TTS and _PTS be evaluated from one notifier?
>>
> If execute _PTS method in tts_notify_reboot(), then it would break
> definition of tts_notify_reboot().

What exactly would it break?

> My intention is to keep new codes
> has limited impact on existed codes.

Even if that makes a little sense?

> Of course, it's possible to merge _TTS and _PTS into one unified notifier.
> The advantage is more actions could be added into the unified notifier in future.
> Which way you prefer?

I would just use one notifier.

Thanks,
Rafael
