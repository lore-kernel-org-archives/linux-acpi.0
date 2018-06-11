From: Ravi Chandra Sadineni <ravisadineni@google.com>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
Date: Mon, 11 Jun 2018 10:59:03 -0700
Message-ID: <CAOGSYL0dCWZvA1TYTFMWwJ7QGSSmwQcWxmJ+JZerxxt6=vx9Sg@mail.gmail.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com>
 <20180606231130.GA57957@decatoncale.mtv.corp.google.com> <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Benson Leung <bleung@google.com>, Ravi Chandra Sadineni <ravisadineni@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rajat Jain <rajatja@google.com>, Furquan Shaikh <furquan@chromium.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

Hopefully this will clear things a bit.

1. Why is this patch needed ?
 Consider the following scenario.
      1. User left the device idle for some time.
      2. A deamon in the userland that controls suspend policy might
suspend the device. The lid is still open.
      3. Now the user returns and wakes the system up by pressing a
key. The system resumes.
      4. In the current implementation we call pm_wakeup_event() (if
the lid is open) irrespective of whether we have received a notify
signal.
      5. The deamon in the userland tries to identify what might woken
the system up based on the wakeup_count.
      6. The deamon sees a wakeup_count  increment for both keyboard
and lid and is confused.
 This patch is an attempt to address the same.

2. Will it break any existing logic ?
   AFAIK pm_wakeup_event() serves 2 purposes.
               1. Helps preventing a race between system wide suspend
and wakeup event.
               2. Helps identifying the device that woke the system up.

As far as preventing races during suspend is concerned, in the
existing implementation, we increment the wakeup_count only when there
is a lid open. Thus only lid open can prevent the system from
suspending (if lid is a wake enabled device). But with my previous
change, we will end up incrementing the wakeup_count for both lid
close and lid open. Fixed this in V2,  so that we do not  increment
the wakeup_count when there is a lid close.

And currently we cannot identify if the lid is the reason for wake
anyway.  So this patch can only make things better here.

Thanks,
Ravi

On Wed, Jun 6, 2018 at 4:21 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, Jun 7, 2018 at 1:11 AM, Benson Leung <bleung@google.com> wrote:
>> Hi Rafael,
>>
>> On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
>>> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>>> >                 /* fall through */
>>> >         case ACPI_BUTTON_NOTIFY_STATUS:
>>> >                 input = button->input;
>>> > +               acpi_pm_wakeup_event(&device->dev);
>>>
>>> Not really.
>>>
>>> There already is an acpi_pm_wakeup_event() call in the else branch below.
>>>
>>
>> Ravi removes that other call below.
>
> OK, I missed that, not sure why, sorry.
>
>> The intent for this is to call
>> acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_LID,
>> in case that event is ACPI_BUTTON_NOTIFY_STATUS.
>
> Well, the patch really drops the acpi_pm_wakeup_event() call from
> acpi_lid_notify_state() and so it has to ensure that this function
> will be called here for ACPI_BUTTON_NOTIFY_STATUS regardless of the
> button->type value.
>
> That's fine, but still the changelog doesn't make it clear why the
> acpi_pm_wakeup_event() call in acpi_lid_notify_state() is not
> necessary in general.
>
> Thanks,
> Rafael
