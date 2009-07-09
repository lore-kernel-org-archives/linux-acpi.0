From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for run-time PM of I/O
	devices (rev. 8)
Date: Fri, 10 Jul 2009 00:31:02 +0900
Message-ID: <aec7e5c30907090831y180b0972o6dcb961dd292a3c0@mail.gmail.com>
References: <aec7e5c30907081952t4b88f1ccjeec6ab11b1d913b8@mail.gmail.com>
	 <Pine.LNX.4.44L0.0907090937530.5823-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:1968 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760742AbZGIPbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jul 2009 11:31:03 -0400
In-Reply-To: <Pine.LNX.4.44L0.0907090937530.5823-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

On Thu, Jul 9, 2009 at 10:48 PM, Alan Stern<stern@rowland.harvard.edu> =
wrote:
> On Thu, 9 Jul 2009, Magnus Damm wrote:
>
>> Clocks should be stopped as soon as possible without any delay. The
>> clock stopping is very cheap performance wise. Also, the clock
>> stopping is done on bus level without invoking any driver callbacks.
>> Delaying the clock stopping does not make any sense to me.
>
> In that case the device driver or bus subsystem should manage the
> device's clock directly. =A0There's no need to tie it in with the run=
time
> PM framework. =A0Simply start the clock before each I/O operation and
> stop it afterward.

It's not that easy. The clock needs to be enabled to let the hardware
device perform device specific stuff. For instance, the clock for the
LCD controller needs to be on to redraw the screen. When the driver
knows that it's done with the clock it can notify the bus using
Runtime PM.

>> For my use case the driver callbacks manage context save and restore=
=2E
>> This to allow turning off power domains.
>>
>> The reason why I don't want to execute the driver ->runtime_suspend(=
)
>> callbacks directly is performance. Basically, we only want to execut=
e
>> the driver callbacks when we know that we will be able to power off
>> the domain. The driver callbacks need to save and restore registers,
>> and each uncached memory access is expensive. Executing the driver
>> callback does not give us any power savings at all, it's just consum=
es
>> power.
>>
>> I want to avoid the situation where the driver ->runtime_suspend() a=
nd
>> ->runtime_resume() callbacks get invoked over and over for all devic=
es
>> except one in a certain power domain even though we will never be ab=
le
>> to power off because a single device in the power domain is active.
>
> Okay, I get the picture. =A0So what you want is something like this: =
Each
> time a driver starts a clock, it does a pm_runtime_get on the
> power-domain device. =A0Each time it stops the clock, it does a
> pm_runtime_put on the power-domain device.

Yes, this is exactly what I'd like to do in the driver.

> When the power-domain device's runtime_idle callback runs, it should
> call pm_schedule_suspend. =A0The runtime_suspend callback should call
> pm_runtime_suspend for each of the devices in the power domain before
> turning off the power supply. =A0Conversely, the runtime_resume callb=
ack
> for the power-domain device should turn on the power supply and then
> call pm_runtime_resume for each of the devices in the domain.
>
> This will have to get more complicated if the individual device drive=
rs
> want to maintain their own usage counters -- especially if they want =
to
> turn off the clock while leaving the counter positive.

I'd like to mange both clocks and power domains using Runtime PM. The
prototype I just posted does that, but the code is not very well
integrated with the shared Runtime PM code.

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
