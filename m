From: Christopher HORLER <cshorler@googlemail.com>
Subject: Re: System overloaded with ACPI interrupts
Date: Thu, 7 May 2009 23:22:48 +0100
Message-ID: <3337c250905071522o43707f0cq41bf647e6e660b72@mail.gmail.com>
References: <3337c250905040300v3279a48evb347f0b037bba85f@mail.gmail.com>
	 <1241588901.15284.105.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40500 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbZEGWWt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 May 2009 18:22:49 -0400
Received: by fxm2 with SMTP id 2so1072757fxm.37
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2009 15:22:48 -0700 (PDT)
In-Reply-To: <1241588901.15284.105.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi Rui,

as requested - further details here:

http://bugzilla.kernel.org/show_bug.cgi?id=3D13268

Chris

On Wed, May 6, 2009 at 6:48 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> hi,
>
> please try a recent vanilla kernel and see if it's reproducible. 2.6.=
29
> would be a good choice.
>
> if the problem still exists in 2.6.29 kernel, please attach the outpu=
t
> of dmesg and "grep . /sys/firmware/acpi/interrupts/*" after the
> interrupt storm occurs.
> please also attach the acpidump of this laptop.
>
> it would be great of you can open a new bug report at
> http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI
> and attach all the info there.
>
> thanks,
> rui
>
>
> On Mon, 2009-05-04 at 18:00 +0800, Christopher HORLER wrote:
>> Hello,
>>
>> I think I'm experiencing some kind of ACPI issue, I haven't been abl=
e
>> to identify a series of actions that causes this.
>>
>> I first noticed the problem when looking at 'top' - seeing kacpi at
>> the top of the process list (followed by kacpi_notify).
>> I have powertop installed, the dump is attached - acpi interrupts se=
em
>> to be excessive.
>>
>> The computer is perhaps not the best machine: =A0Arima M620-DC. =A0I=
 think
>> the same chassis may be used by a number of other manufacturers.
>>
>> The system does not boot in this state - it occurs rather
>> unpredictably after high CPU loads. =A0I had thought this was a CPU
>> temperature issue and replaced the thermal paste of the heatsink,
>> which improved matters.
>>
>> I have also blacklisted the following modules:
>> blacklist i2c_i801
>> blacklist yenta_socket
>>
>> The kernel reports a conflict between ACPI SBUS and i2c_i801.
>> I forget why I disabled yenta_socket, but I don't use the card reade=
r.
>>
>> The OS is openSuSE 11.1 with the 2.6.27.21-0.1-default kernel instal=
led.
>>
>> I've also tried booting the system with acpi=3Dnoirq. =A0This gives =
a 'irq
>> 5: nobody cared' and the wireless card (ipw2200) then doesn't work.
>>
>> My normal kernel command line contains the following parameters:
>> hpet=3Dforce lapic vga=3D0x317
>> This is what all the attached logs are generated from and when my
>> system functions with all devices working.
>>
>> I have also disassembled the ACPI tables. =A0I can post them if requ=
ired?
>>
>> Hopefully someone can suggest a temporary solution or a permanent on=
e?
>>
>> Thanks,
>> Chris
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
