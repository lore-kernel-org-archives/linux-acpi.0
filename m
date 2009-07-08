From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for run-time PM of I/O
	devices (rev. 8)
Date: Wed, 8 Jul 2009 13:40:06 +0900
Message-ID: <aec7e5c30907072140y7dd3b4c7ge7cb0b750bef3226@mail.gmail.com>
References: <200907080007.38595.rjw@sisk.pl>
	 <Pine.LNX.4.44L0.0907072222210.13052-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:44532 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZGHEkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Jul 2009 00:40:08 -0400
In-Reply-To: <Pine.LNX.4.44L0.0907072222210.13052-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

On Wed, Jul 8, 2009 at 11:54 AM, Alan Stern<stern@rowland.harvard.edu> =
wrote:
> On Wed, 8 Jul 2009, Rafael J. Wysocki wrote:
>
>> > I've now jumped from v5 to v8 and I feel that the code is getting
>> > cleaner and cleaner. Very nice.
>>
>> That's mostly thanks to Alan.
>
> I haven't had time yet to look through the new code. =A0Things have b=
een
> very busy.
>
>> > Issue 1:
>> > ------------
>> > Device drivers which do not perform any hardware access in probe()
>> > work fine. During software setup in probe() the runtime pm code is
>> > initialized with the following:
>> >
>> > + =A0 pm_suspend_ignore_children(&dev->dev, true);
>> > + =A0 pm_runtime_set_suspended(&dev->dev);
>> > + =A0 pm_runtime_enable(&dev->dev);
>> >
>> > Before accessing hardware I perform:
>> > + =A0 pm_runtime_resume(pd->dev);
>> >
>> > When done with the hardware I do:
>> > + =A0 pm_runtime_suspend(pd->dev);
>> >
>> > Not so complicated. Am I supposed to initialize something else as =
well?
>
> No, that's all you need.

Ok, thank you!

>> > All good with the code above, but there seem to be some issue with=
 how
>> > usage_count is counted up and down and when runtime_disabled is se=
t:
>> >
>> > 1. pm_runtime_init(): usage_count =3D 1, runtime_disabled =3D true
>> > 2. driver_probe_device(): pm_runtime_get_sync()
>> > 3. pm_runtime_get_sync(): usage_count =3D 2
>> > 4. device driver probe(): pm_runtime_enable()
>> > 5. pm_runtime_enable(): usage_count =3D 1
>> > 6. driver_probe_device(): pm_runtime_put()
>> > 7. pm_runtime_put(): usage_count =3D 0
>> >
>> > I expect runtime_disabled =3D false in 7.
>
> Wasn't it? =A0It should have been set to false in step 4 and remained
> that way.

I may misunderstand, but in v8 won't the pm_runtime_enable() function
do a atomic_dec_test() where the counter value will go from 2 to 1 in
the case above? This would mean that atomic_dec_test() returns false
so runtime_disabled is never modified.

Thanks for your feedback,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
