From: jono <lejono@gmail.com>
Subject: Re: ibm-acpi developers not responding despite serious bugs and debuggers
Date: Sat, 30 Jan 2016 16:30:38 +0000
Message-ID: <CAJXMp+qkbAQK7KUW190etHd57oUtmM_99YHJenA4OtemOi+sHg@mail.gmail.com>
References: <CAJXMp+ozoeeca_WMKfDOKhbLuf1hE_-m-Cv2KhsztYVZ-OEYLA@mail.gmail.com>
	<20160130155614.GB14919@khazad-dum.debian.net>
	<CAJXMp+qb6PfbT1LAs-KcKePkmknYHJ=DBtVX6J7Me-HUqPcTGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36476 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035AbcA3Qaj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2016 11:30:39 -0500
Received: by mail-ob0-f180.google.com with SMTP id ba1so87392097obb.3
        for <linux-acpi@vger.kernel.org>; Sat, 30 Jan 2016 08:30:39 -0800 (PST)
In-Reply-To: <CAJXMp+qb6PfbT1LAs-KcKePkmknYHJ=DBtVX6J7Me-HUqPcTGw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Thanks Henrique and Rafael,
Really appreciate the reply! I didn't realise Lenovo doesn't support
this effort in some way.

Indeed, I rmmod thinkpad-acpi, and then suspended, and still it
doesn't resume. I had assumed it was thinkpad_acpi.  Is there someone
I can contact or another list that's more appropriate? There should be
enough info in those three links, but myself and a number of other
people are happy to help debug.
Best,
Jonathan

On Sat, Jan 30, 2016 at 4:29 PM, jono <lejono@gmail.com> wrote:
> Thanks Henrique and Rafael,
> Really appreciate the reply! I didn't realise Lenovo doesn't support
> this effort in some way.
>
> Indeed, I rmmod thinkpad-acpi, and then suspended, and still it
> doesn't resume. I had assumed it was thinkpad_acpi.  Is there someone
> I can contact or another list that's more appropriate? There should be
> enough info in those three links, but myself and a number of other
> people are happy to help debug.
> Best,
> Jonathan
>
> On Sat, Jan 30, 2016 at 3:56 PM, Henrique de Moraes Holschuh
> <hmh@hmh.eng.br> wrote:
>> On Sat, 30 Jan 2016, jono wrote:
>>> Sorry to trouble you, but a number of us are having lots of grief
>>> getting a response from ibm/lenovo regarding acpi bugs in newer models
>>> like the Helix 2. The bugs make these machines difficult to use, and
>>> there are various reports of this on the internet, along with people
>>> willing to debug patches. But it's impossible to contact anyone on the
>>> ibm-acpi team to help with this. Do you know who we can contact to
>>
>> There's me for ibm-acpi-devel, but let's make one thing VERY clear:
>>
>> 1.  I do not work for Lenovo or IBM, I never did.  I am a volunteer.
>>
>> 2.  That specific ML is about the thinkpad-acpi driver, not about anything
>>     else, not even generic ACPI issues.
>>
>> Also, I work on thinkpad-acpi on my spare time, I do not have the hardware
>> to test many of the issues in the first place as I get no help at all from
>> Lenovo Brazil, so my resources to help are often very limited.
>>
>>> The example is the Helix 2, see:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=100171
>>
>> This is not a thinkpad-acpi bug as far as I can see, but thinkpad-acpi is a
>> completely optional driver: anytime you suspect it of something, you just
>> remove it, reboot, and check if things start working.  If they do, you can
>> contact me about it and we will find the root cause and fix it.
>>
>> On a related note, for a while you *could* unofficially reach some Lenovo
>> people through the linux-thinkpad ML.  You'd comment on something there --
>> with **all** the relevant detais as you often would get only one shot at
>> getting their attention, so you must make it count! -- and after a while,
>> Lenovo would (often silently) act on it.  I am unsure if they are still
>> lurking there, but you could try.
>>
>> That said, please ensure you're running the latest Lenovo firmware on *any*
>> ThinkPad that is experiencing issues, and install your distro's distribution
>> for the Intel processor package unified update (aka "Intel microcode update"
>> -- it was reported that nowadays it updates more areas of the chip, such as
>> power management control/tables, etc.).
>>
>>> and various repetitions of this...
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1424088
>>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1520965?comments=all
>>
>> Same deal as bugzilla #100171, above.
>>
>> --
>>   "One disk to rule them all, One disk to find them. One disk to bring
>>   them all and in the darkness grind them. In the Land of Redmond
>>   where the shadows lie." -- The Silicon Valley Tarot
>>   Henrique Holschuh
