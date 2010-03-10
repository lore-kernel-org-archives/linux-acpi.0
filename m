From: Fabio Comolli <fabio.comolli@gmail.com>
Subject: Re: Possible bug in eeepc-laptop.c - EeePC 900
Date: Wed, 10 Mar 2010 14:46:19 +0100
Message-ID: <b637ec0b1003100546l121f3a54o311aba94c8cabc5e@mail.gmail.com>
References: <b637ec0b1003091458j67efc62cg2c975e9e286f4b0b@mail.gmail.com>
	 <71cd59b01003100507q79878fdan98e53cb4e705d2c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45694 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218Ab0CJNqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2010 08:46:21 -0500
In-Reply-To: <71cd59b01003100507q79878fdan98e53cb4e705d2c2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi.

On Wed, Mar 10, 2010 at 2:07 PM, Corentin Chary
<corentin.chary@gmail.com> wrote:
> On Tue, Mar 9, 2010 at 11:58 PM, Fabio Comolli <fabio.comolli@gmail.com> wrote:
>> Hi.
>> I have an EeePC 900 running 2.6.34-rc1.
>>
>> If I boot it on AC the cpu runs at full speed, 900MHz; if I boot it on
>> battery it runs only at 630Mhz. Plugging / unplugging the AC does not
>> change the cpu frequency. Only a reboot can change the situation.
>>
>> I already tried to echo 0 or 1 to the
>> /sys/devices/platform/eeepc/cpufv file; no effects, even if the file
>> changes its value.
>>
>> This is not a regression from 2.6.33: this behavior is also present in
>> that version.
>>
>> Does this ring any bells? This is really annoying, especially when
>> trying to watch a movie on battery. Also 3D apps show a 30%
>> performance drop, as expected.
>
> Can you change the frequency with cpufreq ?

No, I can't. Which cpufreq driver am I supposed to use? With only
cpufreq compiled in, the directory
/sys/drivers/system/cpu/cpu0/cpufreq is empty.

> Did you try all cpufv values (see cpufv_available file) ?

Yes, it only shows 0 and 1. I tried both, without success.

> Is you bios up-to-date ?

Yes it is, it's 1006.

>
> --
> Corentin Chary
> http://xf.iksaif.net
>

Thanks.
Fabio
