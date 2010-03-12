From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: Possible bug in eeepc-laptop.c - EeePC 900
Date: Fri, 12 Mar 2010 09:49:55 +0100
Message-ID: <71cd59b01003120049n1a9fbbf3qfd37f14f241a7f64@mail.gmail.com>
References: <b637ec0b1003111328u5c1d7d7fw6c76c409740827c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62162 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab0CLIt5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2010 03:49:57 -0500
In-Reply-To: <b637ec0b1003111328u5c1d7d7fw6c76c409740827c7@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: ACPI mailing list <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Mar 11, 2010 at 10:28 PM, Fabio Comolli <fabio.comolli@gmail.co=
m> wrote:
> Hi.
>
> On Tue, Mar 9, 2010 at 11:58 PM, Fabio Comolli <fabio.comolli@gmail.c=
om> wrote:
>> Hi.
>> I have an EeePC 900 running 2.6.34-rc1.
>>
>> If I boot it on AC the cpu runs at full speed, 900MHz; if I boot it =
on
>> battery it runs only at 630Mhz. Plugging / unplugging the AC does no=
t
>> change the cpu frequency. Only a reboot can change the situation.
>>
>> I already tried to echo 0 or 1 to the
>> /sys/devices/platform/eeepc/cpufv file; no effects, even if the file
>> changes its value.
>>
>> This is not a regression from 2.6.33: this behavior is also present =
in
>> that version.
>>
>> Does this ring any bells? This is really annoying, especially when
>> trying to watch a movie on battery. Also 3D apps show a 30%
>> performance drop, as expected.
>>
>> Regards,
>> Fabio
>
> Well, it turns out that this is indeed a regression, but I don't know
> from which kernel version.
> I reverted (not cleanly) this patch:
>
> =A0 =A0 =A0 =A0http://patchwork.kernel.org/patch/28591
>
> and now
>
> =A0 =A0 =A0 =A0echo 1 > /sys/devices/platform/eeepc/cpufv
>
> enables the powersave mode and
>
> =A0 =A0 =A0 =A0echo 0 > /sys/devices/platform/eeepc/cpufv
>
> enables the performance mode.
>
> Tested with the non-benchmark glxgears (275 frames/sec in powersave
> mode and 405 in performance mode) and stellarium (14 frames and 20
> frames).
>
> Regards,
> Fabio
>

Thanks for the report,
Could you try to add a quick printk to show the value stored in
set_acpi(CM_ASL_CPUFV, value); ?
And also, could you send the result of acpidump ?
Thanks,


--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
