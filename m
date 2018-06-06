From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI LID: increment wakeup count only when notified.
Date: Thu, 7 Jun 2018 01:21:24 +0200
Message-ID: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
References: <20180604182612.72699-1-ravisadineni@chromium.org>
 <CAJZ5v0jBTpUzqEj1CeQ0CKH7zVRkgj1qJffoSujEZWi0HXABXw@mail.gmail.com> <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606231130.GA57957@decatoncale.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benson Leung <bleung@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ravi Chandra Sadineni <ravisadineni@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Ravi Chandra Sadineni <ravisadineni@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Todd Broch <tbroch@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rajat Jain <rajatja@google.com>, Furquan Shaikh <furquan@chromium.org>, Benson Leung <bleung@chromium.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 7, 2018 at 1:11 AM, Benson Leung <bleung@google.com> wrote:
> Hi Rafael,
>
> On Wed, Jun 06, 2018 at 09:00:43AM +0200, Rafael J. Wysocki wrote:
>> > @@ -417,6 +414,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
>> >                 /* fall through */
>> >         case ACPI_BUTTON_NOTIFY_STATUS:
>> >                 input = button->input;
>> > +               acpi_pm_wakeup_event(&device->dev);
>>
>> Not really.
>>
>> There already is an acpi_pm_wakeup_event() call in the else branch below.
>>
>
> Ravi removes that other call below.

OK, I missed that, not sure why, sorry.

> The intent for this is to call
> acpi_pm_wakeup_event() regardless if the button->type is ACPI_BUTTON_TYPE_LID,
> in case that event is ACPI_BUTTON_NOTIFY_STATUS.

Well, the patch really drops the acpi_pm_wakeup_event() call from
acpi_lid_notify_state() and so it has to ensure that this function
will be called here for ACPI_BUTTON_NOTIFY_STATUS regardless of the
button->type value.

That's fine, but still the changelog doesn't make it clear why the
acpi_pm_wakeup_event() call in acpi_lid_notify_state() is not
necessary in general.

Thanks,
Rafael
